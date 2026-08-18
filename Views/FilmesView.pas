unit FilmesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TPrincipalMain = class(TForm)
    PanelTopBar: TPanel;
    PanelTitle: TPanel;
    PanelDesktop: TPanel;
    PanelButtons: TPanel;
    PanelStatusBar: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrincipalMain: TPrincipalMain;

implementation

{$R *.dfm}

end.
