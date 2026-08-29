unit CineContext;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.IOUtils, Vcl.Dialogs;

type
  THistoricoDataModule = class(TDataModule)
    HistoricoTable: TFDMemTable;

  private
    FArquivoJSON: string;
    procedure DefinirEstrutura;
    function ResolverCaminhoArquivo: string;
  public
    procedure CarregarDados;
    procedure SalvarDados;
    procedure NovoRegistro(const ATipoTela: string);
    //constructor DataModuleCreate(AOwner: TComponent); override;
    //destructor DataModuleDestroy(Sender: TObject);
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
  HistoricoTable.FieldDefs.Add('TipoMidia', ftString, 20);
  HistoricoTable.FieldDefs.Add('Codigo', ftString, 20);
  HistoricoTable.FieldDefs.Add('Nome', ftString, 100);
  HistoricoTable.FieldDefs.Add('Audio', ftString, 50);
  HistoricoTable.FieldDefs.Add('Sinopse', ftMemo);
  HistoricoTable.FieldDefs.Add('Original', ftString, 100);
  HistoricoTable.FieldDefs.Add('Estreia', ftString, 30);
  HistoricoTable.FieldDefs.Add('Alternativo', ftString, 100);
  HistoricoTable.FieldDefs.Add('Tags', ftString, 150);
  HistoricoTable.FieldDefs.Add('Serie', ftString, 100);
  HistoricoTable.FieldDefs.Add('MCU', ftString, 50);
  HistoricoTable.FieldDefs.Add('Local', ftString, 100);
  HistoricoTable.FieldDefs.Add('Idioma', ftString, 50);
  HistoricoTable.FieldDefs.Add('Referencia', ftString, 100);
  HistoricoTable.FieldDefs.Add('Autores', ftString, 100);
  HistoricoTable.FieldDefs.Add('Franquia', ftString, 100);
  HistoricoTable.FieldDefs.Add('Showrunners', ftString, 100);
  HistoricoTable.FieldDefs.Add('Genero', ftString, 50);
  HistoricoTable.FieldDefs.Add('Diretor', ftString, 100);
  HistoricoTable.FieldDefs.Add('Artistas', ftString, 100);
  HistoricoTable.FieldDefs.Add('Produtora', ftString, 100);
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

{
procedure THistoricoDataModule.DataModuleDestroy(Sender: TObject);
begin
  if HistoricoTable.Active and (HistoricoTable.RecordCount > 0) then
    HistoricoTable.SaveToFile(FArquivoJSON, sfJSON);
end;
}

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
