unit FilmesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, MidiaFormEvents,
  Vcl.Buttons, TMDB.ApiClient, System.JSON, MidiaFormEvents;


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
    EstreiaBox: TMaskEdit;
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
    AnteriorButton: TButton;
    ProximoButton: TButton;
    Label15: TLabel;
    FilmeBox: TEdit;
    Label16: TLabel;
    MCUBox: TEdit;
  private
    { Private declarations }
    FMidiaEvents: TMidiaFormHelper;
    FTMDBClient: TTMDBClient;
  public
    { Public declarations }
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BuscarFilme;
  end;

var
  FilmesMain: TFilmesMain;

implementation

{$R *.dfm}

procedure TFilmesMain.FormCreate(Sender: TObject);
begin
  FMidiaEvents := TMidiaFormHelper.Create(
    NomeBox, AudioBox, SinopseBox, OriginalBox, EstreiaBox, AlternativoBox,
    FilmeBox, FranquiaBox, GeneroBox, TagsBox, DiretorBox, ArtistasBox,
    ProdutoraBox, MCUBox, ResumoBox);
  DoubleBuffered := True;
  PanelDesktop.DoubleBuffered := True;
end;

procedure TFilmesMain.FormDestroy(Sender: TObject);
begin
  FMidiaEvents.Free;
  FTMDBClient.Free;
end;

procedure TFilmesMain.BuscarFilme;
var
  LMovieId: Integer;
  LFuture: IFuture<TJSONObject>;
  LJson: TJSONObject;
  LMedia: TMediaData;
begin
  if not Assigned(FTMDBClient) then
  begin
    MessageDlg('Configure o token da API TMDB antes de buscar.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not TryStrToInt(BuscarBox.Text.Trim, LMovieId) then
  begin
    MessageDlg('Digite o código (ID) do filme no TMDB.', mtWarning, [mbOK], 0);
    BuscarBox.SetFocus;
    Exit;
  end;

  BuscarButton.Enabled := False;
  Screen.Cursor := crHourGlass;
  try
    try
      LFuture := FTMDBClient.GetMovieAsync(LMovieId);
      LJson := LFuture.Value;
      try
        LMedia := ProcessarMidiaTMDB(LJson.ToJSON, False);
        FMidiaEvents.PreencherComMedia(LMedia);
      finally
        LJson.Free;
      end;
    except
      on E: Exception do
        MessageDlg('Erro ao buscar filme: ' + E.Message, mtError, [mbOK], 0);
    end;
  finally
    Screen.Cursor := crDefault;
    BuscarButton.Enabled := True;
  end;
end;




end.
