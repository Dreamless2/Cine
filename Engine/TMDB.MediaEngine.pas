unit TMDB.MediaEngine;

interface

uses
  System.SysUtils, System.JSON, System.Character, System.Math, System.Generics.Collections,
  LanguageMapper, CountryMapper;

type
  TMediaData = record
    IsSerie: Boolean;
    Nome: string;
    Sinopse: string;
    NomeOriginal: string;
    DataEstreia: string;
    NomeAlternativo: string;
    Franquia: string;
    Generos: string;
    Diretores: string;
    Artistas: string;
    Produtoras: string;
    Tags: string;
    LocalProducao: string;
    IdiomaOriginal: string;
    ObraReferencia: string;
    Showrunners: string;
    TituloTag: string;
  end;

function ProcessarMidiaTMDB(const AJsonString: string; AIsSerie: Boolean): TMediaData;
function GerarTagDupla(const ATexto: string): string;
function GerarTag(const ANome: string): string;
function GerarTagLocalProducao(const ANomePais: string): string;

implementation

function FormatarParaTag(const ATexto: string; ARemoverAcentos: Boolean = True): string;
var
  I: Integer;
  LChar: Char;
  LTextoLimpo: string;
  LStringBuilder: TStringBuilder;
const
  ComAcento = 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿ';
  SemAcento = 'AAAAAAACEEEEIIIIDNOOOOOOUUUUYbBaaaaaaaceeeeiiiidnoooooouuuuyby';
begin
  Result := '';
  if ATexto.IsEmpty then Exit;

  LTextoLimpo := ATexto;
  if ARemoverAcentos then
  begin
    for I := 1 to Length(LTextoLimpo) do
    begin
      var PosAcento := Pos(LTextoLimpo[I], ComAcento);
      if PosAcento > 0 then
        LTextoLimpo[I] := SemAcento[PosAcento];
    end;
  end;

  LStringBuilder := TStringBuilder.Create;
  try
    LStringBuilder.Append('#');
    for I := 1 to Length(LTextoLimpo) do
    begin
      LChar := LTextoLimpo[I];
      if LChar.IsLetterOrDigit then
        LStringBuilder.Append(LChar);
    end;
    Result := LStringBuilder.ToString;
  finally
    LStringBuilder.Free;
  end;
end;

function GerarTagDupla(const ATexto: string): string;
var
  LComAcento, LSemAcento: string;
begin
  LComAcento := FormatarParaTag(ATexto, False);
  LSemAcento := FormatarParaTag(ATexto, True);

  if LComAcento = LSemAcento then
    Result := LComAcento
  else
    Result := LSemAcento + ' ' + LComAcento;
end;

function GerarTag(const ANome: string): string;
begin
  Result := GerarTagDupla(ANome);
end;

function GerarTagLocalProducao(const ANomePais: string): string;
var
  LTagSemAcento, LTagComAcento: string;
begin
  LTagSemAcento := FormatarParaTag(ANomePais, True);
  LTagComAcento := FormatarParaTag(ANomePais, False);

  if LTagSemAcento = LTagComAcento then
    Result := LTagSemAcento
  else
    Result := LTagSemAcento + Char(160) + '#' + ANomePais;
end;

procedure TratarDataEAno(const ADataISO: string; out ADataPTBR, AAno: string);
begin
  ADataPTBR := '';
  AAno := '';
  if (ADataISO.IsEmpty) or (Length(ADataISO) < 10) then Exit;

  AAno := ADataISO.Substring(0, 4);
  ADataPTBR := Format('%s/%s/%s', [ADataISO.Substring(8, 2), ADataISO.Substring(5, 2), AAno]);
end;

function ProcessarMidiaTMDB(const AJsonString: string; AIsSerie: Boolean): TMediaData;
var
  LJson, LCredits, LItem, LAltTitlesCollection: TJSONObject;
  LArr, LCastArr, LCrewArr, LKeywordsResultsArr, LOriginArr: TJSONArray;
  I: Integer;
  LDataISO, LAno, LLang: string;
  LIsAnimacao: Boolean;
  LKeywordsObj: TJSONObject;
begin
  Result := Default(TMediaData);
  Result.IsSerie := AIsSerie;

  LJson := TJSONObject.ParseJSONValue(AJsonString) as TJSONObject;
  if not Assigned(LJson) then Exit;

  try
    LLang := LJson.GetValue<string>('original_language', '').ToLower;
    Result.IdiomaOriginal := MapearIdioma(LLang).ToLower;
    LIsAnimacao := False;

    if not AIsSerie then
    begin
      Result.Nome := LJson.GetValue<string>('title', '');
      Result.NomeOriginal := LJson.GetValue<string>('original_title', '');
      LDataISO := LJson.GetValue<string>('release_date', '');
    end
    else
    begin
      Result.Nome := LJson.GetValue<string>('name', '');
      Result.NomeOriginal := LJson.GetValue<string>('original_name', '');
      LDataISO := LJson.GetValue<string>('first_air_date', '');
    end;

    Result.Sinopse := LJson.GetValue<string>('overview', '');
    Result.TituloTag := GerarTag(Result.Nome);

    LArr := LJson.GetValue<TJSONArray>('genres', nil);
    if Assigned(LArr) then
    begin
      for I := 0 to Min(4, LArr.Count - 1) do
      begin
        LItem := LArr.Items[I] as TJSONObject;
        if LItem.GetValue<Integer>('id', 0) = 16 then
          LIsAnimacao := True;

        Result.Generos := (Result.Generos + ' ' + GerarTagDupla(LItem.GetValue<string>('name', ''))).Trim.ToLower;
      end;
    end;

    TratarDataEAno(LDataISO, Result.DataEstreia, LAno);
    if not LAno.IsEmpty then
    begin
      if LIsAnimacao and ((LLang = 'ja') or (LLang = 'ko') or (LLang = 'zh')) then
      begin
        if (LLang = 'ja') or (LLang = 'ko') or (LLang = 'zh') then
          Result.Tags := '#Anime ' + FormatarParaTag('Anime' + LAno)
      end
      else
      begin
        if not AIsSerie then Result.Tags := '#Filme ' + FormatarParaTag('Filme' + LAno)
        else Result.Tags := '#Serie ' + FormatarParaTag('Serie' + LAno) + Chr(160) + '#Série' + Chr(160) + '#Série' + LAno;
      end;
    end;

    LAltTitlesCollection := LJson.GetValue<TJSONObject>('alternative_titles', nil);
    if Assigned(LAltTitlesCollection) then
    begin
      if not AIsSerie then LArr := LAltTitlesCollection.GetValue<TJSONArray>('titles', nil)
      else LArr := LAltTitlesCollection.GetValue<TJSONArray>('results', nil);

      if Assigned(LArr) and (LArr.Count > 0) then
        Result.NomeAlternativo := (LArr.Items[0] as TJSONObject).GetValue<string>('title', '');
    end;

    LCredits := LJson.GetValue<TJSONObject>('credits', nil);
    if Assigned(LCredits) then
    begin
      LCastArr := LCredits.GetValue<TJSONArray>('cast', nil);
      if Assigned(LCastArr) then
      begin
        for I := 0 to Min(4, LCastArr.Count - 1) do
        begin
          LItem := LCastArr.Items[I] as TJSONObject;
          Result.Artistas := (Result.Artistas + ' ' + FormatarParaTag(LItem.GetValue<string>('name', ''))).Trim;
        end;
      end;

      if not AIsSerie then
      begin
        LCrewArr := LCredits.GetValue<TJSONArray>('crew', nil);
        if Assigned(LCrewArr) then
        begin
          for I := 0 to LCrewArr.Count - 1 do
          begin
            LItem := LCrewArr.Items[I] as TJSONObject;
            if LItem.GetValue<string>('job', '') = 'Director' then
              Result.Diretores := (Result.Diretores + ' ' + FormatarParaTag(LItem.GetValue<string>('name', ''))).Trim;
          end;
        end;
      end;
    end;

    LArr := LJson.GetValue<TJSONArray>('production_companies', nil);
    if Assigned(LArr) then
    begin
      for I := 0 to Min(2, LArr.Count - 1) do
      begin
        LItem := LArr.Items[I] as TJSONObject;
        Result.Produtoras := (Result.Produtoras + ' ' + FormatarParaTag(LItem.GetValue<string>('name', ''))).Trim;
      end;
    end;

    if AIsSerie then
    begin
      LArr := LJson.GetValue<TJSONArray>('production_countries', nil);
      if Assigned(LArr) and (LArr.Count > 0) then
        Result.LocalProducao := GerarTagLocalProducao(MapearPais((LArr.Items[0] as TJSONObject).GetValue<string>('name', '')))
      else
      begin
        LOriginArr := LJson.GetValue<TJSONArray>('origin_country', nil);
        if Assigned(LOriginArr) and (LOriginArr.Count > 0) then
          Result.LocalProducao := GerarTagLocalProducao(MapearPais(LOriginArr.Items[0].Value));
      end;

      LArr := LJson.GetValue<TJSONArray>('created_by', nil);
      if Assigned(LArr) then
      begin
        for I := 0 to LArr.Count - 1 do
        begin
          LItem := LArr.Items[I] as TJSONObject;
          Result.Showrunners := (Result.Showrunners + ' ' + FormatarParaTag(LItem.GetValue<string>('name', ''))).Trim;
        end;
      end;

      LKeywordsObj := LJson.GetValue<TJSONObject>('keywords', nil);
      if Assigned(LKeywordsObj) then
      begin
        LKeywordsResultsArr := LKeywordsObj.GetValue<TJSONArray>('results', nil);
        if Assigned(LKeywordsResultsArr) then
        begin
          for I := 0 to LKeywordsResultsArr.Count - 1 do
          begin
            LItem := LKeywordsResultsArr.Items[I] as TJSONObject;
            var LKeywordName := LItem.GetValue<string>('name', '').ToLower;
            if (LKeywordName.Contains('based on novel')) or (LKeywordName.Contains('based on comic')) or
               (LKeywordName.Contains('based on book')) or (LKeywordName.Contains('based on manga')) then
            begin
              Result.ObraReferencia := LItem.GetValue<string>('name', '');
              Break;
            end;
          end;
        end;
      end;
    end;

  finally
    LJson.Free;
  end;
end;

end.
