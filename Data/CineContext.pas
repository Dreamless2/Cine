unit CineContext;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.IOUtils, Vcl.Dialogs, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys,
  FireDAC.Phys.SQLite, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.DApt;

type
  THistoricoDataModule = class(TDataModule)
    HistoricoTable: TFDMemTable;
    FConexao: TFDConnection;
    FHistoricoTable: TFDTable;
  private
    { Private declarations }
    FArquivoJSON: string;
    procedure DefinirEstrutura;
    function ResolverCaminhoArquivo: string;
  public
    { Public declarations }
    procedure CarregarDados;
    procedure SalvarDados;
    procedure NovoRegistro(const ATipoTela: string);
    constructor Create(AOwner: TComponent); override;
  end;

var
  HistoricoDataModule: THistoricoDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure THistoricoDataModule.DefinirEstrutura;
begin
  HistoricoTable.FieldDefs.Clear;
  HistoricoTable.FieldDefs.Add('TipoMidia', ftWideString, 20);
  HistoricoTable.FieldDefs.Add('Codigo', ftWideString, 20);
  HistoricoTable.FieldDefs.Add('Nome', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Audio', ftWideString, 50);
  HistoricoTable.FieldDefs.Add('Sinopse', ftMemo);
  HistoricoTable.FieldDefs.Add('Original', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Estreia', ftWideString, 30);
  HistoricoTable.FieldDefs.Add('Alternativo', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Tags', ftWideString, 150);
  HistoricoTable.FieldDefs.Add('Serie', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('MCU', ftWideString, 50);
  HistoricoTable.FieldDefs.Add('Local', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Idioma', ftWideString, 50);
  HistoricoTable.FieldDefs.Add('Referencia', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Autores', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Franquia', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Showrunners', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Genero', ftWideString, 50);
  HistoricoTable.FieldDefs.Add('Diretor', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Artistas', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('Produtora', ftWideString, 100);
  HistoricoTable.FieldDefs.Add('DataHora_Cadastro', ftDateTime);
  HistoricoTable.FieldDefs.Add('DataHora_Update', ftDateTime);
  HistoricoTable.CreateDataSet;
end;

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
  Result := TPath.Combine(LPasta, 'historico_midias.json');
end;

constructor THistoricoDataModule.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FArquivoJSON := ResolverCaminhoArquivo;
  DefinirEstrutura;
  CarregarDados;
end;

procedure THistoricoDataModule.CarregarDados;
var
  LBackup: string;
begin
  if TFile.Exists(FArquivoJSON) and (TFile.GetSize(FArquivoJSON) > 0) then
  begin
    try
      HistoricoTable.LoadFromFile(FArquivoJSON, sfJSON);
    except
      on E: Exception do
      begin
        LBackup := FArquivoJSON + '.corrompido_' + FormatDateTime('yyyymmdd_hhnnss', Now);
        TFile.Copy(FArquivoJSON, LBackup, True);
        DefinirEstrutura;
      end;
    end;
  end;
  if not HistoricoTable.Active then
    DefinirEstrutura;
end;

procedure THistoricoDataModule.SalvarDados;
begin
  TDirectory.CreateDirectory(TPath.GetDirectoryName(FArquivoJSON));
  HistoricoTable.SaveToFile(FArquivoJSON, sfJSON);
end;

procedure THistoricoDataModule.NovoRegistro(const ATipoTela: string);
var
  I: Integer;
begin
  if not HistoricoTable.Active then
    DefinirEstrutura;
  HistoricoTable.Append;
  for I := 0 to HistoricoTable.FieldCount - 1 do
  begin
    if HistoricoTable.Fields[I].DataType in [ftString, ftMemo] then
      HistoricoTable.Fields[I].AsString := '--';
  end;
  HistoricoTable.FieldByName('TipoMidia').AsString := ATipoTela;
  HistoricoTable.FieldByName('DataHora_Cadastro').AsDateTime := Now;
  HistoricoTable.FieldByName('DataHora_Update').AsDateTime := Now;
end;

end.
