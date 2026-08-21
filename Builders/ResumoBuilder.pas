unit ResumoBuilder;

interface

uses
  System.SysUtils;

function MontarResumo(const ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox,
  AAlternativoBox, AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox,
  AArtistasBox, AProdutoraBox, AMCUBox: string): string; overload;

function MontarResumo(const ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox,
  AAlternativoBox, ATagsBox, ASerieBox, AMCUBox, ALocalBox, AIdiomaBox, AReferenciaBox,
  AAutoresBox, AFranquiaBox, AShowrunnersBox, AGeneroBox, ADiretorBox,
  AArtistasBox, AProdutoraBox: string): string; overload;

function MontarResumo(const ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox,
  AAlternativoBox, ATagsBox, AAnimeBox, ALocalBox, AIdiomaBox, AReferenciaBox,
  AAutoresBox, AFranquiaBox, AShowrunnersBox, AGeneroBox, ADiretorBox,
  AArtistasBox, AProdutoraBox: string): string; overload;


implementation

function ValorOuTraco(const AValor: string): string;
begin
  if AValor.Trim.IsEmpty then Result := '--' else Result := AValor;
end;

function LimparMascaraData(const AValor: string): string;
begin
  Result := AValor.Replace('_', '').Trim([' ', '/']);
end;

function MontarResumo(const ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox,
  AAlternativoBox, AFilmeBox, AFranquiaBox, AGeneroBox, ATagsBox, ADiretorBox,
  AArtistasBox, AProdutoraBox, AMCUBox: string): string;
var
  LBuilder: TStringBuilder;
begin
  LBuilder := TStringBuilder.Create;
  try
    LBuilder.AppendLine(Format('**%s - %s**', [ANomeBox, AAudioBox]));
    LBuilder.AppendLine;
    LBuilder.AppendLine('**HD** - __720p__');
    LBuilder.AppendLine('**SD** - __480p__');
    LBuilder.AppendLine('__(Os vídeos estão em ordem decrescente, ou seja, de cima para baixo, tal como na descrição das resoluções.)__');
    LBuilder.AppendLine;
    LBuilder.AppendLine(Format('__Sinopse: %s__', [ValorOuTraco(ASinopseBox)]));
    LBuilder.AppendLine;
    LBuilder.AppendLine(Format('**Título Original:** __%s__', [ValorOuTraco(AOriginalBox)]));
    LBuilder.AppendLine(Format('**Título Alternativo:** __%s__', [ValorOuTraco(AAlternativoBox)]));
    LBuilder.AppendLine(Format('**Data de Lançamento:** __%s__', [ValorOuTraco(LimparMascaraData(AEstreiaBox))]));
    LBuilder.AppendLine(Format('**Filme:** %s', [ValorOuTraco(AFilmeBox)]));
    LBuilder.AppendLine(Format('**Franquia:** %s', [ValorOuTraco(AFranquiaBox)]));
    LBuilder.AppendLine(Format('**Gênero:** %s', [ValorOuTraco(AGeneroBox)]));
    LBuilder.AppendLine(Format('**Tags:** %s', [ValorOuTraco(ATagsBox)]));
    LBuilder.AppendLine(Format('**Diretor:** %s', [ValorOuTraco(ADiretorBox)]));
    LBuilder.AppendLine(Format('**Fase MCU:** %s', [ValorOuTraco(AMCUBox)]));
    LBuilder.AppendLine(Format('**Estrelas:** %s', [ValorOuTraco(AArtistasBox)]));
    LBuilder.Append(Format('**Estúdio:** %s', [ValorOuTraco(AProdutoraBox)]));

    Result := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

end.
