unit FilmesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.Buttons,
  TMDB.ApiClient, System.JSON, TMDB.MediaEngine, System.Threading, ResumoBuilder,
  System.UITypes, TMDB.KeyStore, MidiaFormEvents, System.Math, CineContext,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client;


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
    FCarregandoHistorico: Boolean;
    FTMDBClient: TTMDBClient;
    FSalvandoHistorico: Boolean;
    procedure CopiarButton_Click(Sender: TObject);
    procedure SalvarButton_Click(Sender: TObject);
    procedure AnteriorButton_Click(Sender: TObject);
    procedure ProximoButton_Click(Sender: TObject);
    procedure HistoricoDataSource_Changed(Sender: TObject; Field: TField);
    procedure LimparPainel(Painel: TPanel);
    procedure CarregarHistoricoNaTela;
  public
    { Public declarations }
    procedure FormDestroy(Sender: TObject);
    procedure PreencherComMedia(const AMedia: TMediaData);
    procedure Buscar(Sender: TObject; var Key: Char);
    constructor Create(AOwner: TComponent); override;
  protected
    procedure DoShow; override;
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
  SalvarButton.OnClick := SalvarButton_Click;
  AnteriorButton.OnClick := AnteriorButton_Click;
  ProximoButton.OnClick := ProximoButton_Click;
  HistoricoDataSource.OnDataChange := HistoricoDataSource_Changed;
  LimparPainel(PanelDesktop);
end;

procedure TFilmesMain.DoShow;
begin
  CarregarHistoricoNaTela;
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
      Application.MessageBox('Informe o código do TMDB.', 'Cine - Filmes',  MB_OK + MB_ICONQUESTION);
      CodigoBox.SetFocus;
      Exit;
    end;

    if not Assigned(FTMDBClient) then
    begin
      Application.MessageBox('A chave da API do TMDB não está configurada.', 'Cine - Filmes',  MB_OK + MB_ICONWARNING);
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
            Application.MessageBox(PChar('Erro: ' + MsgErro), 'Cine - Filmes', MB_YESNO + MB_ICONERROR);
          end
          else
          Application.MessageBox(PChar('Erro: ' + E.Message), 'Cine - Filmes', MB_YESNO + MB_ICONERROR);
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TFilmesMain.CarregarHistoricoNaTela;
var
  T: TFDMemTable;
begin
  if FCarregandoHistorico then
    Exit;

  T := HistoricoDataModule.HistoricoTable;

  if not T.Active or T.IsEmpty then
    Exit;

  FCarregandoHistorico := True;
  try
    CodigoBox.Text      := T.FieldByName('Codigo').AsString;
    NomeBox.Text        := T.FieldByName('Nome').AsString;
    AudioBox.Text       := T.FieldByName('Audio').AsString;
    SinopseBox.Text     := T.FieldByName('Sinopse').AsString;
    OriginalBox.Text    := T.FieldByName('Original').AsString;
    EstreiaBox.Text     := T.FieldByName('Estreia').AsString;
    AlternativoBox.Text := T.FieldByName('Alternativo').AsString;
    TagsBox.Text        := T.FieldByName('Tags').AsString;
    MCUBox.Text         := T.FieldByName('MCU').AsString;
    FranquiaBox.Text    := T.FieldByName('Franquia').AsString;
    GeneroBox.Text      := T.FieldByName('Genero').AsString;
    DiretorBox.Text     := T.FieldByName('Diretor').AsString;
    ArtistasBox.Text    := T.FieldByName('Artistas').AsString;
    ProdutoraBox.Text   := T.FieldByName('Produtora').AsString;
  finally
    FCarregandoHistorico := False;
  end;
end;

procedure TFilmesMain.HistoricoDataSource_Changed(Sender: TObject;
  Field: TField);
begin
  if (HistoricoDataModule = nil) or (not HistoricoDataModule.HistoricoTable.Active) or HistoricoDataModule.HistoricoTable.IsEmpty then
    Exit;

  if FCarregandoHistorico or FSalvandoHistorico then
    Exit;

  CarregarHistoricoNaTela;
end;

procedure TFilmesMain.CopiarButton_Click(Sender: TObject);
begin
  ResumoBox.SelectAll;
  ResumoBox.CopyToClipboard;
  Application.MessageBox('Copiado com sucesso.', 'Cine - Filmes', MB_YESNO + MB_ICONINFORMATION);
end;

procedure TFilmesMain.SalvarButton_Click(Sender: TObject);
begin
  FSalvandoHistorico := True;
  try
    with HistoricoDataModule.HistoricoTable do
    begin
      if Locate('Codigo', CodigoBox.Text, []) then
        Edit
      else
      Append;


    HistoricoDataModule.NovoRegistro('Filmes');
    HistoricoDataModule.HistoricoTable.FieldByName('Codigo').AsString := CodigoBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Nome').AsString := NomeBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Audio').AsString := AudioBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Sinopse').AsString := SinopseBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Original').AsString := OriginalBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Estreia').AsString := EstreiaBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Alternativo').AsString := AlternativoBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Tags').AsString := TagsBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('MCU').AsString := MCUBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Franquia').AsString := FranquiaBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Genero').AsString := GeneroBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Diretor').AsString := DiretorBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Artistas').AsString := ArtistasBox.Text;
    HistoricoDataModule.HistoricoTable.FieldByName('Produtora').AsString := ProdutoraBox.Text;
      Post;
    end;
    HistoricoDataModule.SalvarDados;
    Application.MessageBox(PChar('Filme ' + NomeBox.Text + 'cadastrado com sucesso.'), 'Cine - Filmes', MB_YESNO + MB_ICONINFORMATION);
  except
on E: Exception do
begin
if HistoricoDataModule.HistoricoTable.State in dsEditModes then
HistoricoDataModule.HistoricoTable.Cancel;

  ShowMessage(
    'Erro ao salvar filme:' + sLineBreak + E.Message
  );
end;

end;
  FSalvandoHistorico := False;
end;

procedure TFilmesMain.AnteriorButton_Click(Sender: TObject);
begin
    HistoricoDataModule.HistoricoTable.Prior;
    if HistoricoDataModule.HistoricoTable.Bof then
      Application.MessageBox('Chegou no primeiro registro.', 'Cine - Filmes', MB_OK + MB_ICONINFORMATION);
end;

procedure TFilmesMain.ProximoButton_Click(Sender: TObject);
begin
  HistoricoDataModule.HistoricoTable.Next;
  if HistoricoDataModule.HistoricoTable.Eof then
    Application.MessageBox('Chegou no último registro.', 'Cine - Filmes', MB_OK + MB_ICONINFORMATION);


end;

end.
