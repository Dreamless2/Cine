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
    procedure AdicionarRegistro(const AAcao, ADetalhe: string);
  end;

var
  HistoricoDataModule: THistoricoDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure THistoricoDataModule.DataModuleCreate(Sender: TObject);
begin
  FArquivoJSON := TPath.Combine(TPath.GetDocumentsPath, 'historico_sistema.json');

  // Configura a estrutura uma única vez para o sistema inteiro
  HistoricoTable.FieldDefs.Clear;
  HistoricoTable.FieldDefs.Add('DataHora', ftDateTime);
  HistoricoTable.FieldDefs.Add('Acao', ftString, 50);
  HistoricoTable.FieldDefs.Add('Detalhe', ftString, 250);
  HistoricoTable.CreateDataSet;

  if TFile.Exists(FArquivoJSON) then
    HistoricoTable.LoadFromFile(FArquivoJSON, sfJSON);
end;

procedure THistoricoDataModule.AdicionarRegistro(const AAcao, ADetalhe: string);
begin
  HistoricoTable.Append;
  HistoricoTable.FieldByName('DataHora').AsDateTime := Now;
  HistoricoTable.FieldByName('Acao').AsString := AAcao;
  HistoricoTable.FieldByName('Detalhe').AsString := ADetalhe;
  HistoricoTable.Post;

  HistoricoTable.SaveToFile(FArquivoJSON, sfJSON);
end;

procedure THistoricoDataModule.DataModuleDestroy(Sender: TObject);
begin
  if HistoricoTable.Active and (HistoricoTable.RecordCount > 0) then
    HistoricoTable.SaveToFile(FArquivoJSON, sfJSON);
end;

end.
