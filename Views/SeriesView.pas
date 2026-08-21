unit SeriesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TSeriesMain = class(TForm)
    PanelDesktop: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    CodigoBox: TEdit;
    NomeBox: TEdit;
    AudioBox: TComboBox;
    SinopseBox: TMemo;
    OriginalBox: TEdit;
    EstreiaBox: TMaskEdit;
    TagsBox: TEdit;
    AlternativoBox: TEdit;
    FranquiaBox: TEdit;
    GeneroBox: TEdit;
    DiretorBox: TEdit;
    ArtistasBox: TEdit;
    ProdutoraBox: TEdit;
    ResumoBox: TMemo;
    CopiarButton: TButton;
    SalvarButton: TButton;
    Anterior: TButton;
    ProximoButton: TButton;
    FilmeBox: TEdit;
    MCUBox: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SeriesMain: TSeriesMain;

implementation

{$R *.dfm}

end.
