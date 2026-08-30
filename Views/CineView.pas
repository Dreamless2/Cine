unit CineView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls,
  FilmesView, SeriesView, AnimesView, Vcl.ButtonStylesAttributes,
  Vcl.StyledButton, ES.BaseControls, ES.Layouts, Vcl.ButtonGroup,
  Vcl.StyledButtonGroup, Vcl.Dialogs, System.UITypes;

type
  TCineMain = class(TForm)
    PanelTopBar: TPanel;
    PanelTopTitle: TPanel;
    PanelStatusBar: TPanel;
    LabelHome: TLabel;
    Panel1: TPanel;
    PanelDesktop: TPanel;
    FilmesButton: TStyledButton;
    SeriesButton: TStyledButton;
    AnimesButton: TStyledButton;
    FecharButton: TStyledButton;
    LabelTime: TLabel;
  private
    { Private declarations }
    FCurrentChildForm: TForm;
    procedure OpenChildForm(AChildForm: TForm);
    procedure Filmes_Click(Sender: TObject);
    procedure Series_Click(Sender: TObject);
    procedure Animes_Click(Sender: TObject);
    procedure Fechar_Click(Sender: TObject);
    procedure Panel_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimerTempoTimer(Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    procedure DoShow; override;
  end;

var
  CineMain: TCineMain;

implementation

{$R *.dfm}

constructor TCineMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FilmesButton.OnClick := Filmes_Click;
  SeriesButton.OnClick := Series_Click;
  AnimesButton.OnClick := Animes_Click;
  FecharButton.OnClick := Fechar_Click;
  PanelTopBar.OnMouseDown := Panel_MouseDown;
  PanelTopTitle.OnMouseDown := Panel_MouseDown;
end;

procedure DoShow(AOwner: TComponent);
var
  TimerTempo: TTimer;
begin
  TimerTempo := TTimer.Create(Self);
  TimerTempo.Interval := 1000;
  TimerTempo.OnTimer  := TimerTempoTimer;
  TimerTempo.Enabled  := True;
end;

 procedure TCineMain.TimerTempoTimer(Sender: TObject);
 begin
  TTimer(Sender).Enabled := False;

  try
    LabelTime.Caption :=
  finally

  end;

 end;

procedure TCineMain.OpenChildForm(AChildForm: TForm);
begin
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Hide;
    FCurrentChildForm.Parent := nil;
    FCurrentChildForm.Free;
    FCurrentChildForm := nil;
  end;

  AChildForm.BorderStyle := bsNone;
  AChildForm.DoubleBuffered := True;
  FCurrentChildForm := AChildForm;

  AChildForm.Perform(WM_SETREDRAW, 0, 0);
  try
    PanelDesktop.DisableAlign;
    try
      AChildForm.Parent := PanelDesktop;
      AChildForm.Align := alClient;
    finally
      PanelDesktop.EnableAlign;
    end;
  finally
    AChildForm.Perform(WM_SETREDRAW, 1, 0);
    AChildForm.Invalidate;
    AChildForm.Show;
  end;
end;

destructor TCineMain.Destroy;
begin
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Parent := nil;
    FCurrentChildForm.Free;
    FCurrentChildForm := nil;
  end;
  inherited Destroy;
end;

procedure TCineMain.Filmes_Click(Sender: TObject);
begin
  LockWindowUpdate(PanelDesktop.Handle);
  try
    OpenChildForm(TFilmesMain.Create(nil));
    LabelHome.Caption := 'Cine - Filmes';
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TCineMain.Series_Click(Sender: TObject);
begin
  LockWindowUpdate(PanelDesktop.Handle);
  try
    OpenChildForm(TSeriesMain.Create(Self));
    LabelHome.Caption := 'Cine - Séries';
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TCineMain.Animes_Click(Sender: TObject);
begin
  LockWindowUpdate(PanelDesktop.Handle);
  try
    OpenChildForm(TAnimesMain.Create(Self));
    LabelHome.Caption := 'Cine - Animes';
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TCineMain.Fechar_Click(Sender: TObject);
begin
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Hide;
    FCurrentChildForm.Parent := nil;
    FCurrentChildForm.Free;
    FCurrentChildForm := nil;
  end;

  if mrOK=MessageDlg('Fechar?', mtConfirmation, [mbOK, mbCancel], 0) then
  begin
    Application.Terminate;
    Application.ProcessMessages;
    ExitProcess(0);
    Exit;
  end;
end;

procedure TCineMain.Panel_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    PostMessage(Self.Handle, WM_SYSCOMMAND, $F012, 0);
  end;
end;

end.
