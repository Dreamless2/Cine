unit CineView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FilmesView, SeriesView, AnimesView;

type
  TCineMain = class(TForm)
    PanelTopBar: TPanel;
    PanelTopTitle: TPanel;
    PanelStatusBar: TPanel;
    PanelDesktop: TPanel;
    PanelButtons: TPanel;
    FecharButton: TButton;
    AnimesButton: TButton;
    SeriesButton: TButton;
    FilmesButton: TButton;
    Label1: TLabel;
  private
    { Private declarations }
    FCurrentChildForm: TForm;
    procedure OpenChildForm(AChildForm: TForm);
    procedure Filmes_Click(Sender: TObject);
    procedure Series_Click(Sender: TObject);
    procedure Animes_Click(Sender: TObject);
    procedure Panel_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
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
  PanelTopBar.OnMouseDown := Panel_MouseDown;
  PanelTopTitle.OnMouseDown := Panel_MouseDown;
end;

procedure TCineMain.OpenChildForm(AChildForm: TForm);
begin
  // Remove o formulário atual
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Hide;
    FCurrentChildForm.Parent := nil;
    FCurrentChildForm.Free;
    FCurrentChildForm := nil;
  end;

  // Configura o novo formulário ANTES de mostrar
  AChildForm.Visible := False;
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
    AChildForm.Perform(WM_SETREDRAW, 1, 0); // libera
  AChildForm.Invalidate;
  AChildForm.Show;
  end;

  AChildForm.Show;
end;

destructor TCineMain.Destroy;
begin
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Parent := nil;
    FCurrentChildForm.Free;
  end;
  inherited Destroy;
end;

procedure TCineMain.Filmes_Click(Sender: TObject);
begin
  LockWindowUpdate(PanelDesktop.Handle);
  try
    OpenChildForm(TFilmesMain.Create(nil));
    Label1.Caption := 'Filmes';
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TCineMain.Series_Click(Sender: TObject);
begin
  OpenChildForm(TSeriesMain.Create(Self));
  Label1.Caption := 'Séries';
end;

procedure TCineMain.Animes_Click(Sender: TObject);
begin
  OpenChildForm(TAnimesMain.Create(Self));
  Label1.Caption := 'Animes';
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
