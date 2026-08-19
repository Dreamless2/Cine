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
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FilmesButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CineMain: TCineMain;

implementation

{$R *.dfm}

end.
