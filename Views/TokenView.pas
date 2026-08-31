unit TokenView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.UITypes, TMDB.KeyStore,
  CineView;

type
  TTokenMain = class(TForm)
    PanelTopBar: TPanel;
    PanelTopTitle: TPanel;
    PanelStatusBar: TPanel;
    PanelDesktop: TPanel;
    Label1: TLabel;
    TokenButton: TButton;
    TokenBox: TEdit;
    Label2: TLabel;
    CloseButton: TButton;
  private
    { Private declarations }
    procedure TokenButton_Click(Sender: TObject);
    procedure CloseButton_Click(Sender: TObject);
    procedure Panel_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  TokenMain: TTokenMain;

implementation

{$R *.dfm}

constructor TTokenMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TokenBox.PasswordChar := '*';
  ActiveControl := TokenBox;
  TokenButton.OnClick := TokenButton_Click;
  CloseButton.OnClick := CloseButton_Click;
  PanelTopBar.OnMouseDown := Panel_MouseDown;
  PanelTopTitle.OnMouseDown := Panel_MouseDown;
end;

procedure TTokenMain.TokenButton_Click(Sender: TObject);
var
  LToken: string;
begin
  LToken := Trim(TokenBox.Text);

  if LToken.IsEmpty then
  begin
    Application.MessageBox('Informe token de leitura TMDB.', 'Cine - Token', MB_OK or MB_ICONERROR);
    TokenBox.SetFocus;
    Exit;
  end;

  try
    SaveApiKey(LToken);
    Application.MessageBox('Token salvo com sucesso.', 'Cine - Token', MB_OK or MB_ICONINFORMATION);
    Application.ShowMainForm := True;
    CineMain.Show;
    Release;
  except
    on E: Exception do
      Application.MessageBox(PChar('Erro: ' + E.Message), 'Cine - Token', MB_OK or MB_ICONERROR);
  end;
end;

procedure TTokenMain.CloseButton_Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TTokenMain.Panel_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
  end;
end;


end.
