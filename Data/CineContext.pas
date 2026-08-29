unit CineContext;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

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

end.
