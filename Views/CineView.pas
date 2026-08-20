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
  private
    { Private declarations }
    FCurrentChildForm: TForm;
    procedure OpenChildForm(AChildForm: TForm);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Filmes_Click(Sender: TObject);
    procedure PanelTopBar_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  end;

var
  CineMain: TCineMain;

implementation

{$R *.dfm}

constructor TCineMain.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
  FilmesButton.OnClick := Filmes_Click;
end;

procedure TCineMain.OpenChildForm(AChildForm: TForm);
begin
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Parent := nil;
    FCurrentChildForm.Free;
    FCurrentChildForm := nil;
  end;

  FCurrentChildForm := AChildForm;

  AChildForm.BorderStyle := bsNone;
  AChildForm.Align       := alClient;
  AChildForm.Parent      := PanelDesktop;
  AChildForm.BringToFront;
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
  OpenChildForm(TFilmesMain.Create(Self));
end;

procedure TCineMain.PanelTopBar_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    PostMessage(PanelTopBar.Handle, WM_SYSCOMMAND, $F012, 0);
    PostMessage(PanelTopTitle.Handle, )
  end;
end;





end.
