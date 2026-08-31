unit CineContext;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.DataSet, FireDAC.Stan.Def, FireDAC.Comp.Client,
  System.IOUtils, FireDAC.Phys, Vcl.Forms;

type
  THistoricoDataModule = class(TDataModule)
  private
    FConexao: TFDConnection;
    FHistoricoTable: TFDTable;
    FArquivoDB: string;
    function ResolverCaminhoArquivo: string;
    procedure CriarEstruturaSeNecessaria;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure NovoRegistro(const ATipoTela: string);
    property HistoricoTable: TFDTable read FHistoricoTable;
  end;

var
  HistoricoDataModule: THistoricoDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function THistoricoDataModule.ResolverCaminhoArquivo: string;
var
  LPasta: string;
begin
  LPasta := ExtractFilePath(ParamStr(0)) + 'Data';
  TDirectory.CreateDirectory(LPasta);
  Result := TPath.Combine(LPasta, 'midias.db');
end;

procedure THistoricoDataModule.CriarEstruturaSeNecessaria;
begin
  FConexao.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Midias (' +
    '  ID INTEGER PRIMARY KEY,' +
    '  Codigo TEXT DEFAULT ''--'',' +
    '  TipoMidia TEXT DEFAULT ''--'',' +
    '  Nome TEXT DEFAULT ''--'',' +
    '  Audio TEXT DEFAULT ''--'',' +
    '  Sinopse TEXT DEFAULT ''--'',' +
    '  Original TEXT DEFAULT ''--'',' +
    '  Estreia TEXT DEFAULT ''--'',' +
    '  Alternativo TEXT DEFAULT ''--'',' +
    '  Tags TEXT DEFAULT ''--'',' +
    '  MCU TEXT DEFAULT ''--'',' +
    '  Local TEXT DEFAULT ''--'',' +
    '  Idioma TEXT DEFAULT ''--'',' +
    '  Referencia TEXT DEFAULT ''--'',' +
    '  Autores TEXT DEFAULT ''--'',' +
    '  Franquia TEXT DEFAULT ''--'',' +
    '  Showrunners TEXT DEFAULT ''--'',' +
    '  Genero TEXT DEFAULT ''--'',' +
    '  Diretor TEXT DEFAULT ''--'',' +
    '  Artistas TEXT DEFAULT ''--'',' +
    '  Produtora TEXT DEFAULT ''--'',' +
    '  DataHora_Cadastro TEXT,' +
    '  DataHora_Update TEXT' +
    ')');

  FConexao.ExecSQL(
    'CREATE TRIGGER IF NOT EXISTS trg_Midias_Insert AFTER INSERT ON Midias ' +
    'BEGIN ' +
    '  UPDATE Midias SET DataHora_Cadastro = datetime(''now'',''localtime''), ' +
    '                    DataHora_Update = datetime(''now'',''localtime'') ' +
    '  WHERE Codigo = NEW.Codigo; ' +
    'END');

  FConexao.ExecSQL(
    'CREATE TRIGGER IF NOT EXISTS trg_Midias_Update AFTER UPDATE ON Midias ' +
    'WHEN NEW.DataHora_Update = OLD.DataHora_Update ' +
    'BEGIN ' +
    '  UPDATE Midias SET DataHora_Update = datetime(''now'',''localtime'') ' +
    '  WHERE Codigo = NEW.Codigo; ' +
    'END');
end;

constructor THistoricoDataModule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArquivoDB := ResolverCaminhoArquivo;
  FConexao := TFDConnection.Create(Self);
  FConexao.DriverName := 'SQLite';
  FConexao.Params.Add('DriverID=SQLite');
  FConexao.Params.Add('Database=' + FArquivoDB);
  FConexao.LoginPrompt := False;
  FConexao.Connected := True;
  CriarEstruturaSeNecessaria;
  FHistoricoTable := TFDTable.Create(Self);
  FHistoricoTable.Connection := FConexao;
  FHistoricoTable.TableName := 'Midias';
  FHistoricoTable.IndexFieldNames := 'Codigo';
  FHistoricoTable.Open;
end;

destructor THistoricoDataModule.Destroy;
begin
  if Assigned(FConexao) then
    FConexao.Connected := False;

  inherited Destroy;
end;

procedure THistoricoDataModule.NovoRegistro(const ATipoTela: string);
var
  I: Integer;
begin
  if not FHistoricoTable.Active then
    FHistoricoTable.Open;

  FHistoricoTable.Append;

  for I := 0 to FHistoricoTable.FieldCount - 1 do
  begin
    if (FHistoricoTable.Fields[I].DataType in [ftWideString, ftWideMemo, ftString, ftMemo])
      and (FHistoricoTable.Fields[I].FieldName <> 'DataHora_Cadastro')
      and (FHistoricoTable.Fields[I].FieldName <> 'DataHora_Update') then
      FHistoricoTable.Fields[I].AsString := '--';
  end;

  FHistoricoTable.FieldByName('TipoMidia').AsString := ATipoTela;
end;

end.
