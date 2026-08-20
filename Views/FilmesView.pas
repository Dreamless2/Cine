unit FilmesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TFilmesMain = class(TForm)
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
    CodigoBox: TEdit;
    NomeBox: TEdit;
    AudioBox: TComboBox;
    SinopseBox: TMemo;
    OriginalBox: TEdit;
    DataBox: TMaskEdit;
    TagsBox: TEdit;
    AlternativoBox: TEdit;
    FranquiaBox: TEdit;
    Label10: TLabel;
    GeneroBox: TEdit;
    DiretorBox: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ArtistasBox: TEdit;
    ProdutoraBox: TEdit;
    Label14: TLabel;
    ResumoBox: TMemo;
    CopiarButton: TButton;
    SalvarButton: TButton;
    Anterior: TButton;
    ProximoButton: TButton;
    Label15: TLabel;
    FilmeBox: TEdit;
  private
    { Private declarations }
    FNomeBox, FAudioBox, FSinopseBox, FOriginalBox, FEstreiaBox, FAlternativoBox,
      FFilmeBox, FFranquiaBox, FGeneroBox, FTagsBox, FDiretorBox, FArtistasBox,
      FProdutoraBox, FMCUBox: TCustomEdit;
    FResumoBox: TMemo;
    procedure QualquerAlteracao(Sender: TObject);
    procedure NomeBoxChange(Sender: TObject);
  public
    { Public declarations }
    constructor Create(
      ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox, AAlternativoBox,
      AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox, AArtistasBox,
      AProdutoraBox, AMCUBox: TCustomEdit; AResumoBox: TMemo);
    procedure AtualizarResumo;
  end;

var
  FilmesMain: TFilmesMain;

implementation

{$R *.dfm}

constructor TPrincipalMain


end.
