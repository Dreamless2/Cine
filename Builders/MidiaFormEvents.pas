unit MidiaFormEvents;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,
  ResumoBuilder, TMDB.MediaEngine;

type
  TCustomEditAberto = class(TCustomEdit);

type
  TMidiaFormHelper = class
  private
    FNomeBox, FAudioBox, FSinopseBox, FOriginalBox, FEstreiaBox, FAlternativoBox,
      FFilmeBox, FFranquiaBox, FGeneroBox, FTagsBox, FDiretorBox, FArtistasBox,
      FProdutoraBox, FMCUBox: TCustomEdit;
    FResumoBox: TMemo;
    procedure QualquerAlteracao(Sender: TObject);
    procedure NomeBoxChange(Sender: TObject);
  public
    constructor Create(
      ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox, AAlternativoBox,
      AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox, AArtistasBox,
      AProdutoraBox, AMCUBox: TCustomEdit; AResumoBox: TMemo);
    procedure AtualizarResumo;
  end;

implementation

constructor TMidiaFormHelper.Create(
  ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox, AAlternativoBox,
  AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox, AArtistasBox,
  AProdutoraBox, AMCUBox: TCustomEdit; AResumoBox: TMemo);
var
  LControles: TArray<TCustomEdit>;
  LCtrl: TCustomEdit;
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
     TCustomEditAberto(LCtrl).OnChange := QualquerAlteracao;

  TCustomEditAberto(FNomeBox).OnChange := NomeBoxChange;
end;

procedure TMidiaFormHelper.QualquerAlteracao(Sender: TObject);
begin
  AtualizarResumo;
end;

procedure TMidiaFormHelper.NomeBoxChange(Sender: TObject);
begin
  FFilmeBox.Text := GerarTagFilme(FNomeBox.Text);
  AtualizarResumo;
end;

procedure TMidiaFormHelper.AtualizarResumo;
begin
  FResumoBox.Lines.Text := MontarResumo(
    FNomeBox.Text, FAudioBox.Text, FSinopseBox.Text, FOriginalBox.Text,
    FEstreiaBox.Text, FAlternativoBox.Text, FFilmeBox.Text, FFranquiaBox.Text,
    FGeneroBox.Text, FTagsBox.Text, FDiretorBox.Text, FArtistasBox.Text,
    FProdutoraBox.Text, FMCUBox.Text);
end;

end.
