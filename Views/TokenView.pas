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
end;

procedure TTokenMain.TokenButton_Click(Sender: TObject);
var
  LToken: string;
begin
  LToken := Trim(TokenBox.Text);

  if LToken.IsEmpty then
  begin
    Application.MessageBox('Enter your TMDB API Read Access Token.', 'Token Error', MB_OK or MB_ICONERROR);
    TokenBox.SetFocus;
    Exit;
  end;

  try
    SaveApiKey(LToken);
    Application.MessageBox('Token saved with sucess.', 'Token', MB_OK or MB_ICONINFORMATION);
    Application.ShowMainForm := True;
    CineMain.Show;
    Release;
  except
    on E: Exception do
      Application.MessageBox(PChar('Could not save the token: ' + E.Message), 'Token Error', MB_OK or MB_ICONERROR);
  end;
end;

procedure TTokenMain.CloseButton_Click(Sender: TObject);
begin
  Application.Terminate;
end;


end.
