unit CineContext;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Stan.Async, FireDAC.DApt, System.IOUtils, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait;

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
  LPasta := TPath.GetDocumentsPath;
  if LPasta.Trim.IsEmpty then
    LPasta := TPath.Combine(TPath.GetHomePath, 'Documents');
  if LPasta.Trim.IsEmpty then
    LPasta := TPath.GetDirectoryName(ParamStr(0));
  if LPasta.Trim.IsEmpty then
    LPasta := TPath.Combine(TPath.GetTempPath, 'CineContext');
  TDirectory.CreateDirectory(LPasta);
  Result := TPath.Combine(LPasta, 'historico_midias.db');
end;

procedure THistoricoDataModule.CriarEstruturaSeNecessaria;
begin
  FConexao.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Midias (' +
    '  ID INTEGER PRIMARY KEY,' +
    '  Codigo TEXT,' +
    '  TipoMidia TEXT,' +
    '  Nome TEXT,' +
    '  Audio TEXT,' +
    '  Sinopse TEXT,' +
    '  Original TEXT,' +
    '  Estreia TEXT,' +
    '  Alternativo TEXT,' +
    '  Tags TEXT,' +
    '  MCU TEXT,' +
    '  Local TEXT,' +
    '  Idioma TEXT,' +
    '  Referencia TEXT,' +
    '  Autores TEXT,' +
    '  Franquia TEXT,' +
    '  Showrunners TEXT,' +
    '  Genero TEXT,' +
    '  Diretor TEXT,' +
    '  Artistas TEXT,' +
    '  Produtora TEXT,' +
    '  DataHora_Cadastro TEXT,' +
    '  DataHora_Update TEXT' +
    ')');

  FConexao.ExecSQL(
    'CREATE TRIGGER IF NOT EXISTS trg_Midias_Insert ' +
    'AFTER INSERT ON MIDIASJ M LOOU UIIIUUUUUUUUUUUUU9Filmes ' +
    'BEGIN ' +
    '  UPDATE Midias SET DataHora_Cadastro = datetime(''now'',''localtime''), ' +
    '                    DataHora_Update = datetime(''now'',''localtime'') ' +
    '  WHERE Codigo = NEW.Codigo; ' +
    'END');

  FConexao.ExecSQL(
    'CREATE TRIGGER IF NOT EXISTS trg_Filmes_Update ' +
    'AFTER UPDATE ON Filmes ' +
    'WHEN NEW.DataHora_Update = OLD.DataHora_Update ' +
    'BEGIN ' +
    '  UPDATE Filmes SET DataHora_Update = datetime(''now'',''localtime'') ' +
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
  FHistoricoTable.TableName := 'Filmes';
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
