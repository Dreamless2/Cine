unit AnimesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  TMDB.ApiClient, System.JSON, TMDB.MediaEngine, System.Threading, ResumoBuilder,
  System.UITypes, TMDB.KeyStore, MidiaFormEvents;

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
    constructor Create(AOwner: TComponent);
  end;

var
  AnimesMain: TAnimesMain;

implementation

{$R *.dfm}

uses System.StrUtils;

constructor TAnimesMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if HasStoredApiKey then
    FTMDBClient := TTMDBClient.Create(LoadApiKey)
  else
    FTMDBClient := nil;

  FMidiaEvents := TMidiaFormHelper.Create(
    [AudioBox, SinopseBox, OriginalBox, EstreiaBox, AlternativoBox, AnimeBox,
    LocalBox, IdiomaBox, ReferenciaBox, AutoresBox, FranquiaBox, ShowrunnersBox,
    GeneroBox, TagsBox, DiretorBox, ArtistasBox, ProdutoraBox],
    NomeBox, AnimeBox, ResumoBox,
    function: string
    begin
      Result := MontarResumo(
        NomeBox.Text, AudioBox.Text, SinopseBox.Text, OriginalBox.Text, EstreiaBox.Text, AlternativoBox.Text,
        TagsBox.Text, AnimeBox.Text, LocalBox.Text, IdiomaBox.Text, ReferenciaBox.Text, AutoresBox.Text,
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

procedure TAnimesMain.FormDestroy(Sender: TObject);
begin
  FMidiaEvents.Free;
  FTMDBClient.Free;
end;

procedure TAnimesMain.LimparPainel(Painel: TPanel);
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

function ValorOuPadrao(const Valor: string): string;
begin
  if Valor <> '' then
    Result := Valor
  else
    Result := '--';
end;



procedure TAnimesMain.PreencherComMedia(const AMedia: TMediaData);
begin
  FMidiaEvents.DesativarEventos;
  try
    NomeBox.Text := ValorOuPadrao(AMedia.Nome);
    SinopseBox.Text := ValorOuPadrao(AMedia.Sinopse);
    OriginalBox.Text := ValorOuPadrao(AMedia.NomeOriginal);
    EstreiaBox.Text := ValorOuPadrao(AMedia.DataEstreia);
    AlternativoBox.Text := ValorOuPadrao(AMedia.NomeAlternativo);
    AnimeBox.Text := ValorOuPadrao(GerarTag(AMedia.Nome));
    LocalBox.Text := ValorOuPadrao(AMedia.LocalProducao);
    IdiomaBox.Text := ValorOuPadrao(GerarTag(AMedia.IdiomaOriginal));
    ShowrunnersBox.Text := ValorOuPadrao(AMedia.Showrunners);
    GeneroBox.Text := ValorOuPadrao(AMedia.Generos);
    TagsBox.Text := ValorOuPadrao(AMedia.Tags);
    DiretorBox.Text := ValorOuPadrao(AMedia.Diretores);
    ArtistasBox.Text := ValorOuPadrao(AMedia.Artistas);
    ProdutoraBox.Text := ValorOuPadrao(AMedia.Produtoras);
  finally
    FMidiaEvents.ReativarEventos;
  end;
  FMidiaEvents.AtualizarResumo;
end;

procedure TAnimesMain.Buscar(Sender: TObject; var Key: Char);
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

procedure TAnimesMain.CopiarButton_Click(Sender: TObject);
begin
  ResumoBox.SelectAll;
  ResumoBox.CopyToClipboard;
end;

end.
