unit SeriesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  TMDB.ApiClient, System.JSON, TMDB.MediaEngine, System.Threading, ResumoBuilder,
  System.UITypes, TMDB.KeyStore, MidiaFormEvents;

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
    AnteriorButton: TButton;
    ProximoButton: TButton;
    SerieBox: TEdit;
    MCUBox: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    LocalBox: TEdit;
    IdiomaBox: TEdit;
    ReferenciaBox: TEdit;
    AutoresBox: TEdit;
    ShowrunnersBox: TEdit;
    Label21: TLabel;
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
    constructor Create(AOwner: TComponent);
  end;

var
  SeriesMain: TSeriesMain;

implementation

{$R *.dfm}

constructor TSeriesMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if HasStoredApiKey then
    FTMDBClient := TTMDBClient.Create(LoadApiKey)
  else
    FTMDBClient := nil;

  FMidiaEvents := TMidiaFormHelper.Create(
    [AudioBox, SinopseBox, OriginalBox, EstreiaBox, AlternativoBox, SerieBox,
    MCUBox, LocalBox, IdiomaBox, ReferenciaBox, AutoresBox, FranquiaBox, ShowrunnersBox,
    GeneroBox, TagsBox, DiretorBox, ArtistasBox, ProdutoraBox],
    NomeBox, SerieBox, ResumoBox,
    function: string
    begin
      Result := MontarResumo(
        NomeBox.Text, AudioBox.Text, SinopseBox.Text, OriginalBox.Text, EstreiaBox.Text, AlternativoBox.Text,
        TagsBox.Text, SerieBox.Text, MCUBox.Text, LocalBox.Text, IdiomaBox.Text, ReferenciaBox.Text, AutoresBox.Text,
        FranquiaBox.Text, ShowrunnersBox.Text, GeneroBox.Text, DiretorBox.Text, ArtistasBox.Text, ProdutoraBox.Text
      );
    end,
    function(ANome: string): string
    begin
      Result := GerarTag(ANome);
    end);
  FMidiaEvents.AtualizarResumo;
  CodigoBox.OnKeyPress := Buscar;
  CopiarButton.OnClick := CopiarButton_Click;
  LimparPainel(PanelDesktop);
end;

function ExceptionDetalhes(E: Exception): string;
begin
  Result := E.ClassName + ': ' + E.Message;

  while Assigned(E.InnerException) do
  begin
    E := E.InnerException;

    Result := Result + sLineBreak + '  -> ' + E.ClassName + ': ' + E.Message;
  end;
end;

procedure TSeriesMain.FormDestroy(Sender: TObject);
begin
  FMidiaEvents.Free;
  FTMDBClient.Free;
end;

procedure TSeriesMain.LimparPainel(Painel: TPanel);
var
  i: Integer;
begin
  for i := 0 to Painel.ControlCount - 1 do
  begin
    if Painel.Controls[i] is TEdit then
      TEdit(Painel.Controls[i]).Text := '--';

    if Painel.Controls[i] is TMaskEdit then
      TMaskEdit(Painel.Controls[i]).Text := '--';
  end;
end;

procedure TSeriesMain.PreencherComMedia(const AMedia: TMediaData);
begin
  FMidiaEvents.DesativarEventos;
  try
    NomeBox.Text := AMedia.Nome;
    SinopseBox.Text := AMedia.Sinopse;
    OriginalBox.Text := AMedia.NomeOriginal;
    EstreiaBox.Text := AMedia.DataEstreia;
    AlternativoBox.Text := AMedia.NomeAlternativo;
    SerieBox.Text := GerarTag(AMedia.Nome);
    LocalBox.Text := AMedia.LocalProducao;
    IdiomaBox.Text := GerarTag(AMedia.IdiomaOriginal);
    ShowrunnersBox.Text := AMedia.Showrunners;
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

procedure TSeriesMain.Buscar(Sender: TObject; var Key: Char);
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

    if not Assigned(FTMDBClient) then
    begin
    MessageDlg('A chave da API do TMDB não está configurada.', mtWarning, [mbOK], 0);
      Exit;
    end;

    Screen.Cursor := crHourGlass;
    try
      try
        LFuture := FTMDBClient.GetTvShowAsync(LMovieId);
        LJson := LFuture.Value;
        try
          LMedia := ProcessarMidiaTMDB(LJson.ToJSON, True);
          PreencherComMedia(LMedia);
        finally
          LJson.Free;
        end;
      except
        on E: EAggregateException do
        begin
         if E.Count > 0 then
            begin
              var Erros: string := '';
              for var I := 0 to E.Count - 1 do
              begin
                Erros := Erros + '• ' + E.InnerExceptions[I].Message + sLineBreak;
              end;
              MessageDlg('Erros TMDB encontrados:' + sLineBreak + Erros, mtError, [mbOK], 0);
          end
          else
            MessageDlg('Erro TMDB:' + sLineBreak + E.Message, mtError, [mbOK], 0);
         end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TSeriesMain.CopiarButton_Click(Sender: TObject);
begin
  ResumoBox.SelectAll;
  ResumoBox.CopyToClipboard;
end;

end.
