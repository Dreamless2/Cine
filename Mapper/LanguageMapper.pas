unit LanguageMapper;

interface

function MapearIdioma(const ACodigo: string): string;

implementation

function MapearIdioma(const ACodigo: string): string;
begin
  case ACodigo of
    'en': Result := 'Inglês';
    'pt': Result := 'Português';
    'es': Result := 'Espanhol';
    'fr': Result := 'Francês';
    'de': Result := 'Alemão';
    'it': Result := 'Italiano';
    'ja': Result := 'Japonês';
    'ko': Result := 'Coreano';
    'zh': Result := 'Chinês';
    'ru': Result := 'Russo';
    'nl': Result := 'Holandês';
    'pl': Result := 'Polonês';
    'tr': Result := 'Turco';
    'ar': Result := 'Árabe';
    'hi': Result := 'Hindi';
    'sv': Result := 'Sueco';
    'da': Result := 'Dinamarquês';
    'no': Result := 'Norueguês';
    'fi': Result := 'Finlandês';
    'cs': Result := 'Tcheco';
    'sk': Result := 'Eslovaco';
    'hu': Result := 'Húngaro';
    'ro': Result := 'Romeno';
    'uk': Result := 'Ucraniano';
    'el': Result := 'Grego';
    'he': Result := 'Hebraico';
    'fa': Result := 'Persa';
    'th': Result := 'Tailandês';
    'vi': Result := 'Vietnamita';
    'id': Result := 'Indonésio';
    'ms': Result := 'Malaio';
    'tl': Result := 'Filipino';
    'ca': Result := 'Catalão';
    'eu': Result := 'Basco';
    'gl': Result := 'Galego';
    'hr': Result := 'Croata';
    'sr': Result := 'Sérvio';
    'bg': Result := 'Búlgaro';
    'sl': Result := 'Esloveno';
    'et': Result := 'Estoniano';
    'lv': Result := 'Letão';
    'lt': Result := 'Lituano';
    'is': Result := 'Islandês';
    'sw': Result := 'Suaíli';
    'af': Result := 'Africâner';
    'bn': Result := 'Bengali';
    'ta': Result := 'Tâmil';
    'te': Result := 'Telugo';
    'ur': Result := 'Urdu';
    'ml': Result := 'Malaiala';
    'mr': Result := 'Marata';
    'gu': Result := 'Guzerate';
    'kn': Result := 'Canarês';
    'pa': Result := 'Punjabi';
    'fa': Result := 'Persa';
    'km': Result := 'Khmer';
    'my': Result := 'Birmanês';
    'la': Result := 'Latim';
    'eo': Result := 'Esperanto';
  else
    Result := ACodigo.Trim.ToUpper;
  end;
end;

end.
