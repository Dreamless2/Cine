unit SeriesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  TMDB.ApiClient, System.JSON, TMDB.MediaEngine, System.Threading, ResumoBuilder,
  System.UITypes, TMDB.KeyStore, MidiaFormEvents, System.Math, CineContext,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.Client;

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
    FCarregandoHistorico: Boolean;
    FTMDBClient: TTMDBClient;
    FSalvandoHistorico: Boolean;
    procedure CopiarButton_Click(Sender: TObject);
    procedure SalvarButton_Click(Sender: TObject);
    procedure AnteriorButton_Click(Sender: TObject);
    procedure ProximoButton_Click(Sender: TObject);
    procedure LimparPainel(Painel: TPanel);
    procedure CarregarHistoricoNaTela;
    procedure AtualizarCamposComRegistroAtual;
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
  SalvarButton.OnClick := SalvarButton_Click;
  AnteriorButton.OnClick := AnteriorButton_Click;
  ProximoButton.OnClick := ProximoButton_Click;
  LimparPainel(PanelDesktop);
end;

procedure TSeriesMain.DoShow;
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
    SerieBox.Text := GerarTag(ValorOuPadrao(AMedia.Nome));
    FranquiaBox.Text := ValorOuPadrao(AMedia.Franquia);
    LocalBox.Text;
    IdiomaBox.Text;
    ReferenciaBox.Text;
    AutoresBox.Text;
    Showrunners
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
      Application.MessageBox('Informe o código do TMDB.', 'Cine - Series',  MB_OK + MB_ICONQUESTION);
      CodigoBox.SetFocus;
      Exit;
    end;

    if not Assigned(FTMDBClient) then
    begin
      Application.MessageBox('A chave da API do TMDB não está configurada.', 'Cine - Series',  MB_OK + MB_ICONWARNING);
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
            Application.MessageBox(PChar('Erro: ' + MsgErro), 'Cine - Series', MB_OK + MB_ICONERROR);
          end
          else
          Application.MessageBox(PChar('Erro: ' + E.Message), 'Cine - Series', MB_OK + MB_ICONERROR);
        end;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TSeriesMain.CarregarHistoricoNaTela;
var
  T: TFDTable;
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

procedure TSeriesMain.AtualizarCamposComRegistroAtual;
begin
  with HistoricoDataModule.HistoricoTable do
  begin
    CodigoBox.Text := FieldByName('Codigo').AsString;
    NomeBox.Text := FieldByName('Nome').AsString;
    AudioBox.Text := FieldByName('Audio').AsString;
    SinopseBox.Text := FieldByName('Sinopse').AsString;
    OriginalBox.Text := FieldByName('Original').AsString;
    EstreiaBox.Text := FieldByName('Estreia').AsString;
    AlternativoBox.Text := FieldByName('Alternativo').AsString;
    TagsBox.Text := FieldByName('Tags').AsString;
    MCUBox.Text := FieldByName('MCU').AsString;
    FranquiaBox.Text := FieldByName('Franquia').AsString;
    GeneroBox.Text := FieldByName('Genero').AsString;
    DiretorBox.Text := FieldByName('Diretor').AsString;
    ArtistasBox.Text := FieldByName('Artistas').AsString;
    ProdutoraBox.Text := FieldByName('Produtora').AsString;
  end;
end;

procedure TSeriesMain.CopiarButton_Click(Sender: TObject);
begin
  ResumoBox.SelectAll;
  ResumoBox.CopyToClipboard;
end;

procedure TSeriesMain.SalvarButton_Click(Sender: TObject);
var
  LEhNovoRegistro: Boolean;
begin
  FSalvandoHistorico := True;
  try
    with HistoricoDataModule.HistoricoTable do
    begin
      LEhNovoRegistro := not Locate('Codigo', CodigoBox.Text, []);
      if LEhNovoRegistro then
        Append
      else
        Edit;

      FieldByName('TipoMidia').AsString := 'Filme';
      FieldByName('Codigo').AsString := CodigoBox.Text;
      FieldByName('Nome').AsString := NomeBox.Text;
      FieldByName('Audio').AsString := AudioBox.Text;
      FieldByName('Sinopse').AsString := SinopseBox.Text;
      FieldByName('Original').AsString := OriginalBox.Text;
      FieldByName('Estreia').AsString := EstreiaBox.Text;
      FieldByName('Alternativo').AsString := AlternativoBox.Text;
      FieldByName('Tags').AsString := TagsBox.Text;
      FieldByName('MCU').AsString := MCUBox.Text;
      FieldByName('Franquia').AsString := FranquiaBox.Text;
      FieldByName('Genero').AsString := GeneroBox.Text;
      FieldByName('Diretor').AsString := DiretorBox.Text;
      FieldByName('Artistas').AsString := ArtistasBox.Text;
      FieldByName('Produtora').AsString := ProdutoraBox.Text;
      Post;
      Refresh;
    end;
    if LEhNovoRegistro then
    begin
      Application.MessageBox(PChar('Filme ' + NomeBox.Text + ' cadastrado com sucesso.'), 'Cine - Series', MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      Application.MessageBox(PChar('Filme ' + NomeBox.Text + ' atualizado com sucesso.'), 'Cine - Series', MB_OK + MB_ICONINFORMATION);
    end;
  except
    on E: Exception do
    begin
      if HistoricoDataModule.HistoricoTable.State in dsEditModes then
          HistoricoDataModule.HistoricoTable.Cancel;
      Application.MessageBox(PChar('Erro ao Salvar: ' + E.Message), 'Cine - Series', MB_OK + MB_ICONERROR);
    end;
  end;
  FSalvandoHistorico := False;
end;

procedure TSeriesMain.AnteriorButton_Click(Sender: TObject);
begin
  HistoricoDataModule.HistoricoTable.Prior;
  AnteriorButton.Enabled := not HistoricoDataModule.HistoricoTable.Bof;
  ProximoButton.Enabled := True;
  AtualizarCamposComRegistroAtual;
end;

procedure TSeriesMain.ProximoButton_Click(Sender: TObject);
begin
  HistoricoDataModule.HistoricoTable.Next;
  ProximoButton.Enabled := not HistoricoDataModule.HistoricoTable.Eof;
  AnteriorButton.Enabled := True;
  AtualizarCamposComRegistroAtual;
end;

end.
