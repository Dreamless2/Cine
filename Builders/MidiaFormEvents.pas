unit MidiaFormEvents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  ResumoBuilder, TMDB.MediaEngine;

type
  TMidiaFormHelper = class
  private
    FNomeBox, FAudioBox, FSinopseBox, FOriginalBox, FEstreiaBox, FAlternativoBox,
      FFilmeBox, FFranquiaBox, FGeneroBox, FTagsBox, FDiretorBox, FArtistasBox,
      FProdutoraBox, FMCUBox: TWinControl; // Mudado para TWinControl
    FResumoBox: TMemo;
    procedure QualquerAlteracao(Sender: TObject);
    procedure NomeBoxChange(Sender: TObject);
    procedure AtribuirOnChange(AControl: TWinControl; ANotifyEvent: TNotifyEvent);
    function ObterTexto(AControl: TWinControl): string;
    procedure DefinirTexto(AControl: TWinControl; const ATexto: string);
  public
    constructor Create(
      ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox, AAlternativoBox,
      AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox, AArtistasBox,
      AProdutoraBox, AMCUBox: TWinControl; AResumoBox: TMemo); // Mudado para TWinControl
    procedure AtualizarResumo;
  end;

implementation

constructor TMidiaFormHelper.Create(
  ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox, AAlternativoBox,
  AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox, AArtistasBox,
  AProdutoraBox, AMCUBox: TWinControl; AResumoBox: TMemo);
var
  LControles: TArray<TWinControl>;
  LCtrl: TWinControl;
begin
  inherited Create;

  FNomeBox := ANomeBox;
  FAudioBox := AAudioBox;
  FSinopseBox := ASinopseBox;
  FOriginalBox := AOriginalBox;
  FEstreiaBox := AEstreiaBox;
  FAlternativoBox := AAlternativoBox;
  FFilmeBox := AFilmeBox;
  FFranquiaBox := AFranquiaBox;
  FGeneroBox := AGeneroBox;
  FTagsBox := ATagsBox;
  FDiretorBox := ADiretorBox;
  FArtistasBox := AArtistasBox;
  FProdutoraBox := AProdutoraBox;
  FMCUBox := AMCUBox;
  FResumoBox := AResumoBox;

  LControles := [FAudioBox, FSinopseBox, FOriginalBox, FEstreiaBox, FAlternativoBox,
    FFilmeBox, FFranquiaBox, FGeneroBox, FTagsBox, FDiretorBox, FArtistasBox,
    FProdutoraBox, FMCUBox];

  for LCtrl in LControles do
     AtribuirOnChange(LCtrl, QualquerAlteracao);

  AtribuirOnChange(FNomeBox, NomeBoxChange);
end;

procedure TMidiaFormHelper.AtribuirOnChange(AControl: TWinControl; ANotifyEvent: TNotifyEvent);
begin
  if AControl is TCustomEdit then
    TCustomEdit(AControl).OnChange := ANotifyEvent
  else if AControl is TComboBox then
    TComboBox(AControl).OnChange := ANotifyEvent;
end;

function TMidiaFormHelper.ObterTexto(AControl: TWinControl): string;
begin
  if AControl is TCustomEdit then
    Result := TCustomEdit(AControl).Text
  else if AControl is TComboBox then
    Result := TComboBox(AControl).Text
  else
    Result := '';
end;

procedure TMidiaFormHelper.DefinirTexto(AControl: TWinControl; const ATexto: string);
begin
  if AControl is TCustomEdit then
    TCustomEdit(AControl).Text := ATexto
  else if AControl is TComboBox then
    TComboBox(AControl).Text := ATexto;
end;

procedure TMidiaFormHelper.QualquerAlteracao(Sender: TObject);
begin
  AtualizarResumo;
end;

procedure TMidiaFormHelper.NomeBoxChange(Sender: TObject);
begin
  DefinirTexto(FFilmeBox, GerarTagFilme(ObterTexto(FNomeBox)));
  AtualizarResumo;
end;

end.
