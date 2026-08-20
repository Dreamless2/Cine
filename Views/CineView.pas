unit CineView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

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
  end;

var
  CineMain: TCineMain;

implementation

{$R *.dfm}

procedure TCineMain.OpenChildForm(AChildForm: TForm);
begin
  if Assigned(FCurrentChildForm) then
  begin
    FCurrentChildForm.Close;
    FCurrentChildForm.Free;
    FCurrentChildForm := nil;
  end;

  FCurrentChildForm := AChildForm;
  AChildForm.BorderStyle := bsNone;    /
  AChildForm.Align := alClient;        // Dock = DockStyle.Fill
  AChildForm.Parent := PanelDesktop;   // PanelDesktop.Controls.Add(childForm)


  AChildForm.Show;                     // childForm.Show()
end;


end.
