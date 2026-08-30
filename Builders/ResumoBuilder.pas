unit ResumoBuilder;

interface

uses
  System.SysUtils;

function MontarResumo(const ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox,
  AAlternativoBox, ATagsBox, AFilmeBox, AMCUBox,
  AFranquiaBox, AGeneroBox, ADiretorBox,
  AArtistasBox, AProdutoraBox: string): string; overload;

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
  AAlternativoBox, ATagsBox, AFilmeBox, AMCUBox,
  AFranquiaBox, AGeneroBox, ADiretorBox,
  AArtistasBox, AProdutoraBox: string): string; overload;
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
    LBuilder.AppendLine(Format('**Data de Estreia:** __%s__', [ValorOuTraco(AEstreiaBox)]));
    LBuilder.AppendLine(Format('**Filme:** %s', [ValorOuTraco(AFilmeBox)]));
    LBuilder.AppendLine(Format('**Franquia:** %s', [ValorOuTraco(AFranquiaBox)]));
    LBuilder.AppendLine(Format('**Gênero:** %s', [ValorOuTraco(AGeneroBox)]));
    LBuilder.AppendLine(Format('**Tags:** %s', [ValorOuTraco(ATagsBox)]));
    LBuilder.AppendLine(Format('**Diretor:** %s', [ValorOuTraco(ADiretorBox)]));
    LBuilder.AppendLine(Format('**Fase MCU:** %s', [ValorOuTraco(AMCUBox)]));
    LBuilder.AppendLine(Format('**Artistas:** %s', [ValorOuTraco(AArtistasBox)]));
    LBuilder.Append(Format('**Produtora:** %s', [ValorOuTraco(AProdutoraBox)]));
    Result := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

function MontarResumo(const ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox,
  AAlternativoBox, ATagsBox, ASerieBox, AMCUBox, ALocalBox, AIdiomaBox, AReferenciaBox,
  AAutoresBox, AFranquiaBox, AShowrunnersBox, AGeneroBox, ADiretorBox,
  AArtistasBox, AProdutoraBox: string): string; overload;
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
    LBuilder.AppendLine(Format('**Data de Lançamento:** __%s__', [ValorOuTraco(AEstreiaBox)]));
    LBuilder.AppendLine(Format('**Série:** %s', [ValorOuTraco(ASerieBox)]));
    LBuilder.AppendLine(Format('**Fase MCU:** %s', [ValorOuTraco(AMCUBox)]));
    LBuilder.AppendLine(Format('**Local de Produção:** %s', [ValorOuTraco(ALocalBox)]));
    LBuilder.AppendLine(Format('**Idioma Original:** %s', [ValorOuTraco(AIdiomaBox)]));
    LBuilder.AppendLine(Format('**Obra de Referência:** __%s__', [ValorOuTraco(AReferenciaBox)]));
    LBuilder.AppendLine(Format('**Autores:** %s', [ValorOuTraco(AAutoresBox)]));
    LBuilder.AppendLine(Format('**Franquia:** %s', [ValorOuTraco(AFranquiaBox)]));
    LBuilder.AppendLine(Format('**Showrunners:** %s', [ValorOuTraco(AShowrunnersBox)]));
    LBuilder.AppendLine(Format('**Gênero:** %s', [ValorOuTraco(AGeneroBox)]));
    LBuilder.AppendLine(Format('**Tags:** %s', [ValorOuTraco(ATagsBox)]));
    LBuilder.AppendLine(Format('**Diretor:** %s', [ValorOuTraco(ADiretorBox)]));
    LBuilder.AppendLine(Format('**Artistas:** %s', [ValorOuTraco(AArtistasBox)]));
    LBuilder.Append(Format('**Produtora:** %s', [ValorOuTraco(AProdutoraBox)]));
    Result := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

function MontarResumo(const ANomeBox, AAudioBox, ASinopseBox, AOriginalBox, AEstreiaBox,
  AAlternativoBox, ATagsBox, AAnimeBox, ALocalBox, AIdiomaBox, AReferenciaBox,
  AAutoresBox, AFranquiaBox, AShowrunnersBox, AGeneroBox, ADiretorBox,
  AArtistasBox, AProdutoraBox: string): string; overload;
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
    LBuilder.AppendLine(Format('**Data de Lançamento:** __%s__', [ValorOuTraco(AEstreiaBox)]));
    LBuilder.AppendLine(Format('**Anime:** %s', [ValorOuTraco(AAnimeBox)]));
    LBuilder.AppendLine(Format('**Local de Produção:** %s', [ValorOuTraco(ALocalBox)]));
    LBuilder.AppendLine(Format('**Idioma Original:** %s', [ValorOuTraco(AIdiomaBox)]));
    LBuilder.AppendLine(Format('**Obra de Referência:** __%s__', [ValorOuTraco(AReferenciaBox)]));
    LBuilder.AppendLine(Format('**Autores:** %s', [ValorOuTraco(AAutoresBox)]));
    LBuilder.AppendLine(Format('**Franquia:** %s', [ValorOuTraco(AFranquiaBox)]));
    LBuilder.AppendLine(Format('**Showrunners:** %s', [ValorOuTraco(AShowrunnersBox)]));
    LBuilder.AppendLine(Format('**Gênero:** %s', [ValorOuTraco(AGeneroBox)]));
    LBuilder.AppendLine(Format('**Tags:** %s', [ValorOuTraco(ATagsBox)]));
    LBuilder.AppendLine(Format('**Diretor:** %s', [ValorOuTraco(ADiretorBox)]));
    LBuilder.AppendLine(Format('**Artistas:** %s', [ValorOuTraco(AArtistasBox)]));
    LBuilder.Append(Format('**Produtora:** %s', [ValorOuTraco(AProdutoraBox)]));
    Result := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

end.
