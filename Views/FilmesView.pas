unit FilmesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, MidiaFormEvents,
  Vcl.Buttons, TMDB.ApiClient, System.JSON, TMDB.MediaEngine, System.Threading, ResumoBuilder,
  System.UITypes;


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
    procedure PreencherComMedia(const AMedia: TMediaData);
    procedure BuscarFilme(Sender: TObject; var Key: Char);
    procedure BuscarFilmeExit(Sender: TObject);
  end;

var
  FilmesMain: TFilmesMain;

implementation

{$R *.dfm}

procedure TFilmesMain.FormCreate(Sender: TObject);
begin
  {FMidiaEvents := TMidiaFormHelper.Create(
    [AudioBox, SinopseBox, OriginalBox, EstreiaBox, AlternativoBox, FilmeBox,
     FranquiaBox, GeneroBox, TagsBox, DiretorBox, ArtistasBox, ProdutoraBox, MCUBox],
    NomeBox, FilmeBox, ResumoBox,
    function: string
    begin
      Result := MontarResumo(
        NomeBox.Text, AudioBox.Text, SinopseBox.Text, OriginalBox.Text,
        EstreiaBox.Text, AlternativoBox.Text, TagsBox.Text, FilmeBox.Text,
        MCUBox.Text, FranquiaBox.Text, GeneroBox.Text, DiretorBox.Text,
        ArtistasBox.Text, ProdutoraBox.Text);
    end,
    function(ANome: string): string
    begin
      Result := GerarTagFilme(ANome);
    end);
  FMidiaEvents.AtualizarResumo;
  DoubleBuffered := True;
  CodigoBox.OnKeyPress := BuscarFilme;
  CodigoBox.OnExit := BuscarFilmeExit;}
  FMidiaEvents := TMidiaFormHelper.Create(
  [AudioBox, SinopseBox, OriginalBox, EstreiaBox, AlternativoBox, FilmeBox,
   FranquiaBox, GeneroBox, TagsBox, DiretorBox, ArtistasBox, ProdutoraBox, MCUBox],
  NomeBox, FilmeBox, ResumoBox,
  function: string
  begin
    Result := MontarResumo(
      NomeBox.Text, AudioBox.Text, SinopseBox.Text, OriginalBox.Text,
      EstreiaBox.Text, AlternativoBox.Text, TagsBox.Text, FilmeBox.Text,
      MCUBox.Text, FranquiaBox.Text, GeneroBox.Text, DiretorBox.Text,
      ArtistasBox.Text, ProdutoraBox.Text);
  end,
  function(ANome: string): string
  begin
    Result := GerarTagFilme(ANome);
  end
);

FMidiaEvents.AtualizarResumo;
end;


procedure TFilmesMain.FormDestroy(Sender: TObject);
begin
  FMidiaEvents.Free;
  FTMDBClient.Free;
end;

procedure TFilmesMain.PreencherComMedia(const AMedia: TMediaData);
begin
  FMidiaEvents.DesativarEventos;
  try
    NomeBox.Text := AMedia.Nome;
    SinopseBox.Text := AMedia.Sinopse;
    OriginalBox.Text := AMedia.NomeOriginal;
    EstreiaBox.Text := AMedia.DataEstreia;
    AlternativoBox.Text := AMedia.NomeAlternativo;
    FilmeBox.Text := GerarTagFilme(AMedia.Nome);
    GeneroBox.Text := AMedia.Generos;
    TagsBox.Text := AMedia.Tags;
    DiretorBox.Text := AMedia.Diretores;
    ArtistasBox.Text := AMedia.Artistas;
    ProdutoraBox.Text := AMedia.Produtoras;
  finally
    FMidiaEvents.ReativarEventos;
  end;
  FMidiaEvents.AtualizarResumo;
end;

procedure TFilmesMain.BuscarFilme(Sender: TObject; var Key: Char);
var
  LMovieId: Integer;
  LFuture: IFuture<TJSONObject>;
  LJson: TJSONObject;
  LMedia: TMediaData;
begin
  if Key = #13 then
  begin
    Key := #0;

    if not TryStrToInt(CodigoBox.Text, LMovieId) then
    begin
      MessageDlg('Digite o código do filme no TMDB.', mtWarning, [mbOK], 0);
      CodigoBox.SetFocus;
      Exit;
    end;

    Screen.Cursor := crHourGlass;
    try
      try
        LFuture := FTMDBClient.GetMovieAsync(LMovieId);
        LJson := LFuture.Value;
        try
          LMedia := ProcessarMidiaTMDB(LJson.ToJSON, False);
          PreencherComMedia(LMedia);
        finally
          LJson.Free;
        end;
      except
        on E: Exception do
          MessageDlg('Erro ao buscar filme: ' + E.Message, mtError, [mbOK], 0);
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFilmesMain.BuscarFilmeExit(Sender: TObject);
var
  LKey: Char;
begin
  LKey := #13;
  BuscarFilme(Sender, LKey);
end;



end.
