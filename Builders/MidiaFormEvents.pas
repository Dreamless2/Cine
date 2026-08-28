unit MidiaFormEvents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  ResumoBuilder, TMDB.MediaEngine;

type
  TCustomEditAberto = class(TCustomEdit);

  TMidiaFormHelper = class
  private
    FNomeBox, FAudioBox, FSinopseBox, FOriginalBox, FEstreiaBox, FAlternativoBox,
    FFilmeBox, FFranquiaBox, FGeneroBox, FTagsBox, FDiretorBox, FArtistasBox,
    FProdutoraBox, FMCUBox: TControl;
    FResumoBox: TMemo;
    function GetText(AControl: TControl): string;
    procedure SetText(AControl: TControl; const AValue: string);
    procedure AssignOnChange(AControl: TControl; AEvent: TNotifyEvent);
    procedure QualquerAlteracao(Sender: TObject);
    procedure NomeBoxChange(Sender: TObject);
  public
    constructor Create(
      ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox, AAlternativoBox,
      AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox, AArtistasBox,
      AProdutoraBox, AMCUBox: TControl;
      AResumoBox: TMemo);
    procedure AtualizarResumo;
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

constructor TMidiaFormHelper.Create(
  ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox, AAlternativoBox,
  AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox, AArtistasBox,
  AProdutoraBox, AMCUBox: TControl; AResumoBox: TMemo);
var
  LControles: TArray<TControl>;
  LCtrl: TControl;
begin
  inherited Create;

  FNomeBox       := ANomeBox;
  FAudioBox      := AAudioBox;
  FSinopseBox    := ASinopseBox;
  FOriginalBox   := AOriginalBox;
  FEstreiaBox    := AEstreiaBox;
  FAlternativoBox:= AAlternativoBox;
  FFilmeBox      := AFilmeBox;
  FFranquiaBox   := AFranquiaBox;
  FGeneroBox     := AGeneroBox;
  FTagsBox       := ATagsBox;
  FDiretorBox    := ADiretorBox;
  FArtistasBox   := AArtistasBox;
  FProdutoraBox  := AProdutoraBox;
  FMCUBox        := AMCUBox;
  FResumoBox     := AResumoBox;

  LControles := [FAudioBox, FSinopseBox, FOriginalBox, FEstreiaBox, FAlternativoBox,
                 FFilmeBox, FFranquiaBox, FGeneroBox, FTagsBox, FDiretorBox,
                 FArtistasBox, FProdutoraBox, FMCUBox];

  for LCtrl in LControles do
    AssignOnChange(LCtrl, QualquerAlteracao);

  AssignOnChange(FNomeBox, NomeBoxChange);
end;

procedure TMidiaFormHelper.QualquerAlteracao(Sender: TObject);
begin
  AtualizarResumo;
end;

procedure TMidiaFormHelper.NomeBoxChange(Sender: TObject);
begin
  SetText(FFilmeBox, GerarTagFilme(GetText(FNomeBox)));
  AtualizarResumo;
end;

procedure TMidiaFormHelper.AtualizarResumo;
begin
  FResumoBox.Lines.Text := MontarResumo(
    GetText(FNomeBox),
    GetText(FAudioBox),
    GetText(FSinopseBox),
    GetText(FOriginalBox),
    GetText(FEstreiaBox),
    GetText(FAlternativoBox),
    GetText(FFilmeBox),
    GetText(FFranquiaBox),
    GetText(FGeneroBox),
    GetText(FTagsBox),
    GetText(FDiretorBox),
    GetText(FArtistasBox),
    GetText(FProdutoraBox),
    GetText(FMCUBox));
end;

end.
