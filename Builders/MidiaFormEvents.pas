unit MidiaFormEvents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TCustomEditAberto = class(TCustomEdit);

  TMontarResumoFunc = reference to function: string;

  TMidiaFormHelper = class
  private
    FControlesObservados: TArray<TControl>;
    FNomeBox, FFilmeBox: TControl;
    FResumoBox: TMemo;
    FMontarResumo: TMontarResumoFunc;
    FGerarTagNome: TFunc<string, string>;
    function GetText(AControl: TControl): string;
    procedure SetText(AControl: TControl; const AValue: string);
    procedure AssignOnChange(AControl: TControl; AEvent: TNotifyEvent);
    procedure QualquerAlteracao(Sender: TObject);
    procedure NomeBoxChange(Sender: TObject);
  public
    constructor Create(const AControlesObservados: TArray<TControl>;
      ANomeBox, AFilmeBox: TControl; AResumoBox: TMemo;
      AMontarResumo: TMontarResumoFunc; AGerarTagNome: TFunc<string, string> = nil);
    procedure AtualizarResumo;
    procedure DesativarEventos;
    procedure ReativarEventos;
  end;

implementation

{ TMidiaFormHelper }

function TMidiaFormHelper.GetText(AControl: TControl): string;
begin
  if AControl is TCustomEdit then
    Result := TCustomEdit(AControl).Text
  else if AControl is TComboBox then
    Result := TComboBox(AControl).Text
  else
    Result := '';
end;

procedure TMidiaFormHelper.SetText(AControl: TControl; const AValue: string);
begin
  if AControl is TCustomEdit then
    TCustomEdit(AControl).Text := AValue
  else if AControl is TComboBox then
    TComboBox(AControl).Text := AValue;
end;

procedure TMidiaFormHelper.AssignOnChange(AControl: TControl; AEvent: TNotifyEvent);
begin
  if AControl is TCustomEdit then
    TCustomEditAberto(AControl).OnChange := AEvent
  else if AControl is TComboBox then
    TComboBox(AControl).OnChange := AEvent;
end;

constructor TMidiaFormHelper.Create(const AControlesObservados: TArray<TControl>;
  ANomeBox, AFilmeBox: TControl; AResumoBox: TMemo;
  AMontarResumo: TMontarResumoFunc; AGerarTagNome: TFunc<string, string> = nil);
var
  LCtrl: TControl;
begin
  inherited Create;

  FControlesObservados := AControlesObservados;
  FNomeBox := ANomeBox;
  FFilmeBox := AFilmeBox;
  FResumoBox := AResumoBox;
  FMontarResumo := AMontarResumo;
  FGerarTagNome := AGerarTagNome;

  for LCtrl in FControlesObservados do
    AssignOnChange(LCtrl, QualquerAlteracao);

  if Assigned(FNomeBox) then
    AssignOnChange(FNomeBox, NomeBoxChange);
end;

procedure TMidiaFormHelper.QualquerAlteracao(Sender: TObject);
begin
  AtualizarResumo;
end;

procedure TMidiaFormHelper.NomeBoxChange(Sender: TObject);
begin
  if Assigned(FFilmeBox) and Assigned(FGerarTagNome) then
    SetText(FFilmeBox, FGerarTagNome(GetText(FNomeBox)));
  AtualizarResumo;
end;

procedure TMidiaFormHelper.AtualizarResumo;
begin
  if not Assigned(FResumoBox) then
    Exit;

  if not Assigned(FMontarResumo) then
    Exit;

  FResumoBox.Text := FMontarResumo();
end;

procedure TMidiaFormHelper.DesativarEventos;
var
  LCtrl: TControl;
begin
  for LCtrl in FControlesObservados do
    AssignOnChange(LCtrl, nil);

  if Assigned(FNomeBox) then
    AssignOnChange(FNomeBox, nil);
end;

procedure TMidiaFormHelper.ReativarEventos;
var
  LCtrl: TControl;
begin
  for LCtrl in FControlesObservados do
    AssignOnChange(LCtrl, QualquerAlteracao);

  if Assigned(FNomeBox) then
    AssignOnChange(FNomeBox, NomeBoxChange);
end;

end.
