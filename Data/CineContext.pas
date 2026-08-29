unit CineContext;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.IOUtils;

type
  THistoricoDataModule = class(TDataModule)
    HistoricoTable: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FArquivoJSON: string;
  public
    { Public declarations }
    procedure CarregarDados;
    procedure SalvarDados;
    procedure NovoRegistro(const ATipoTela: string);
  end;

var
  HistoricoDataModule: THistoricoDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure THistoricoDataModule.DataModuleCreate(Sender: TObject);
begin
  FArquivoJSON := TPath.Combine(TPath.GetDocumentsPath, 'historico_midias.json');
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
  HistoricoTable.FieldDefs.Add('Artistas', ftMemo);
  HistoricoTable.FieldDefs.Add('Produtora', ftString, 100);
  HistoricoTable.FieldDefs.Add('DataHora_Cadastro', ftDateTime);
  HistoricoTable.FieldDefs.Add('DataHora_Update', ftDateTime);
  HistoricoTable.CreateDataSet;
  HistoricoTable.Open;
  CarregarDados;
end;

procedure THistoricoDataModule.DataModuleDestroy(Sender: TObject);
begin
  if HistoricoTable.Active and (HistoricoTable.RecordCount > 0) then
    HistoricoTable.SaveToFile(FArquivoJSON, sfJSON);
end;

procedure THistoricoDataModule.CarregarDados;
begin
  if TFile.Exists(FArquivoJSON) then
    HistoricoTable.LoadFromFile(FArquivoJSON, sfJSON);
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
