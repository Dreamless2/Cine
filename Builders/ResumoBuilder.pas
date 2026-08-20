unit ResumoBuilder;

interface

uses
  System.SysUtils, System.StrUtils, TMDB.MediaEngine;

function MontarResumo(const AMedia: TMediaData; const ANomeBox, AFilmeBox, AFranquiaBox,
  AAudioBox: string; const AFaseMCU: string = '--'): string;

implementation

function ValorOuTraco(const AValor: string): string;
begin
  if AValor.Trim.IsEmpty then Result := '--' else Result := AValor;
end;

function MontarResumo(const AMedia: TMediaData; const ANomeBox, AFilmeBox, AFranquiaBox,
  AAudioBox: string; const AFaseMCU: string = '--'): string;
var
  LBuilder: TStringBuilder;
  LTipoLabel: string;
begin
  LTipoLabel := IfThen(AMedia.IsSerie, 'Série', 'Filme');

  LBuilder := TStringBuilder.Create;
  try
    LBuilder.AppendLine(Format('**%s - %s**', [ANomeBox, AAudioBox]));
    LBuilder.AppendLine('**HD** - __720p__');
    LBuilder.AppendLine('**SD** - __480p__');
    LBuilder.AppendLine('__(Os vídeos estão em ordem decrescente, ou seja, de cima para baixo, tal como na descrição das resoluções.)__');
    LBuilder.AppendLine(Format('__Sinopse: %s__', [ValorOuTraco(AMedia.Sinopse)]));
    LBuilder.AppendLine(Format('**Título Original:** __%s__', [ValorOuTraco(AMedia.NomeOriginal)]));
    LBuilder.AppendLine(Format('**Título Alternativo:** __%s__', [ValorOuTraco(AMedia.NomeAlternativo)]));
    LBuilder.AppendLine(Format('**Data de Lançamento:** __%s__', [ValorOuTraco(AMedia.DataEstreia)]));
    LBuilder.AppendLine(Format('**%s:** %s', [LTipoLabel, ValorOuTraco(AFilmeBox)]));
    LBuilder.AppendLine(Format('**Franquia:** %s', [ValorOuTraco(AFranquiaBox)]));
    LBuilder.AppendLine(Format('**Gênero:** %s', [ValorOuTraco(AMedia.Generos)]));
    LBuilder.AppendLine(Format('**Tags:** %s', [ValorOuTraco(AMedia.Tags)]));
    LBuilder.AppendLine(Format('**Diretor:** %s', [ValorOuTraco(AMedia.Diretores)]));
    LBuilder.AppendLine(Format('**Fase MCU:** %s', [AFaseMCU]));
    LBuilder.AppendLine(Format('**Estrelas:** %s', [ValorOuTraco(AMedia.Artistas)]));
    LBuilder.Append(Format('**Estúdio:** %s', [ValorOuTraco(AMedia.Produtoras)]));

    Result := LBuilder.ToString;
  finally
    LBuilder.Free;
  end;
end;

end.
