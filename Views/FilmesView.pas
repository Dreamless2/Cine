unit FilmesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons,
  TMDB.ApiClient, System.JSON, TMDB.MediaEngine, System.Threading, ResumoBuilder,
  System.UITypes, TMDB.KeyStore, MidiaFormEvents, System.Math, CineContext,
  Data.DB;


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
    HistoricoDataSource: TDataSource;
  private
    { Private declarations }
    FMidiaEvents: TMidiaFormHelper;
    FTMDBClient: TTMDBClient;
    procedure CopiarButton_Click(Sender: TObject);
    procedure AnteriorButton_Click(Sender: TObject);
    procedure ProximoButton_Click(Sender: TObject);
    p
    procedure LimparPainel(Painel: TPanel);
  public
    { Public declarations }
    procedure FormDestroy(Sender: TObject);
    procedure PreencherComMedia(const AMedia: TMediaData);
    procedure Buscar(Sender: TObject; var Key: Char);
    constructor Create(AOwner: TComponent); override;
  end;

var
  FilmesMain: TFilmesMain;

implementation

{$R *.dfm}

constructor TFilmesMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if HasStoredApiKey then
    FTMDBClient := TTMDBClient.Create(LoadApiKey)
  else
    FTMDBClient := nil;

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
      Result := GerarTag(ANome);
    end);
  FMidiaEvents.AtualizarResumo;
  CodigoBox.OnKeyPress := Buscar;
  CopiarButton.OnClick := CopiarButton_Click;
  AnteriorButton.OnClick := AnteriorButton_Click;
  ProximoButton.OnClick := ProximoButton_Click;
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

procedure TFilmesMain.FormDestroy(Sender: TObject);
begin
  FMidiaEvents.Free;
  FTMDBClient.Free;
end;

procedure TFilmesMain.LimparPainel(Painel: TPanel);
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

procedure TFilmesMain.PreencherComMedia(const AMedia: TMediaData);
function ValorOuPadrao(const Valor: string): string;
begin
  if Valor <> '' then
    Result := Valor
  else
    Result := '--';
end;

begin
  FMidiaEvents.DesativarEventos;
  try
    NomeBox.Text := ValorOuPadrao(AMedia.Nome);
    SinopseBox.Text := ValorOuPadrao(AMedia.Sinopse);
    OriginalBox.Text := ValorOuPadrao(AMedia.NomeOriginal);
    EstreiaBox.Text := ValorOuPadrao(AMedia.DataEstreia);
    AlternativoBox.Text := ValorOuPadrao(AMedia.NomeAlternativo);
    FilmeBox.Text := GerarTag(ValorOuPadrao(AMedia.Nome));
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

procedure TFilmesMain.Buscar(Sender: TObject; var Key: Char);
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
      MessageDlg('Informe o código do TMDB.', mtWarning, [mbOK], 0);
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
        LFuture := FTMDBClient.GetMovieAsync(LMovieId);
        LJson := LFuture.Value;
        try
          LMedia := ProcessarMidiaTMDB(LJson.ToJSON, False);
          PreencherComMedia(LMedia);
        finally
          LJson.Free;
        end;
      except
        on E: EAggregateException do
        begin
          if E.Count > 0 then
          begin
            var MsgErro := E.InnerExceptions[0].Message;
            if MsgErro.Contains('"status_message":') then
            begin
              var PosInicio := MsgErro.IndexOf('"status_message":') + 18;
              MsgErro := MsgErro.Substring(PosInicio).Replace('"', '').Replace('}', '').Trim;
            end
            else if MsgErro.Contains('404') then
            begin
              MsgErro := 'O recurso solicitado não foi encontrado.';
            end;
            MessageDlg('Erro: ' + MsgErro, mtError, [mbOK], 0);
          end
          else
          MessageDlg('Erro: ' + E.Message, mtError, [mbOK], 0);
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFilmesMain.CopiarButton_Click(Sender: TObject);
begin
  ResumoBox.SelectAll;
  ResumoBox.CopyToClipboard;
end;

procedure TFilmesMain.AnteriorButton_Click(Sender: TObject);
begin
    HistoricoDataModule.HistoricoTable.Prior;
end;

procedure TFilmesMain.ProximoButton_Click(Sender: TObject);
begin
    HistoricoDataModule.HistoricoTable.Next;
end;

end.
