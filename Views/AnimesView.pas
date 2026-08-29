unit AnimesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TAnimesMain = class(TForm)
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
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
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
    AnteriorButton: TButton;
    ProximoButton: TButton;
    AnimeBox: TEdit;
    LocalBox: TEdit;
    IdiomaBox: TEdit;
    ReferenciaBox: TEdit;
    AutoresBox: TEdit;
    ShowrunnersBox: TEdit;
  private
    { Private declarations }
    FMidiaEvents: TMidiaFormHelper;
    FTMDBClient: TTMDBClient;
    procedure CopiarButton_Click(Sender: TObject);
    procedure LimparPainel(Painel: TPanel);
  public
    { Public declarations }
    procedure FormDestroy(Sender: TObject);
    procedure PreencherComMedia(const AMedia: TMediaData);
    procedure Buscar(Sender: TObject; var Key: Char);
    procedure BuscarExit(Sender: TObject);
    constructor Create(AOwner: TComponent);
  end;

var
  AnimesMain: TAnimesMain;

implementation

{$R *.dfm}

end.
