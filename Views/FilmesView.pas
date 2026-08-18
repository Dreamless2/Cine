unit FilmesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TPrincipalMain = class(TForm)
    PanelTopBar: TPanel;
    PanelTitle: TPanel;
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
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Edit3: TEdit;
    MaskEdit1: TMaskEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
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
