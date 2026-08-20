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
    procedure FormCreate(Sender: TObject);
    //procedure FormClose(Sender: TObject; var Action: TCloseAction);[
    procedure FormDestroy(Sender: TObject);
    procedure Filmes_Click(Sender: TObject);

  end;

var
  CineMain: TCineMain;

implementation

{$R *.dfm}

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

procedure TCineMain.FormCreate(Sender: TObject);
begin
  FilmesButton.OnClick := Filmes_Click;
end;

procedure TCineMain.FormDestroy(Sender: TObject);
begin
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Parent := nil;
    FCurrentChildForm.Free;
    FCurrentChildForm := nil;
  end;
end;

procedure TCineMain.Filmes_Click(Sender: TObject);
begin
  with Application do
  begin
    NormalizeTopMosts;
    MessageBox('This should be on top.', 'Look', MB_OK);
    RestoreTopMosts;
  end;
end;







end.
