unit LanguageMapper;

interface

function MapearIdioma(const ACodigo: string): string;

implementation

uses
  System.SysUtils, System.StrUtils, System.Generics.Collections;

var
  MapaIdiomas: TDictionary<string, string>;

procedure InicializarMapa;
begin
  if Assigned(MapaIdiomas) then
    Exit;

  MapaIdiomas := TDictionary<string, string>.Create;

  MapaIdiomas.AddOrSetValue('en', 'Inglês');
  MapaIdiomas.AddOrSetValue('pt', 'Português');
  MapaIdiomas.AddOrSetValue('es', 'Espanhol');
  MapaIdiomas.AddOrSetValue('fr', 'Francês');
  MapaIdiomas.AddOrSetValue('de', 'Alemão');
  MapaIdiomas.AddOrSetValue('it', 'Italiano');
  MapaIdiomas.AddOrSetValue('ja', 'Japonês');
  MapaIdiomas.AddOrSetValue('ko', 'Coreano');
  MapaIdiomas.AddOrSetValue('zh', 'Chinês');
  MapaIdiomas.AddOrSetValue('ru', 'Russo');
  MapaIdiomas.AddOrSetValue('nl', 'Holandês');
  MapaIdiomas.AddOrSetValue('pl', 'Polonês');
  MapaIdiomas.AddOrSetValue('tr', 'Turco');
  MapaIdiomas.AddOrSetValue('ar', 'Árabe');
  MapaIdiomas.AddOrSetValue('hi', 'Hindi');
  MapaIdiomas.AddOrSetValue('sv', 'Sueco');
  MapaIdiomas.AddOrSetValue('da', 'Dinamarquês');
  MapaIdiomas.AddOrSetValue('no', 'Norueguês');
  MapaIdiomas.AddOrSetValue('fi', 'Finlandês');
  MapaIdiomas.AddOrSetValue('cs', 'Tcheco');
  MapaIdiomas.AddOrSetValue('sk', 'Eslovaco');
  MapaIdiomas.AddOrSetValue('hu', 'Húngaro');
  MapaIdiomas.AddOrSetValue('ro', 'Romeno');
  MapaIdiomas.AddOrSetValue('uk', 'Ucraniano');
  MapaIdiomas.AddOrSetValue('el', 'Grego');
  MapaIdiomas.AddOrSetValue('he', 'Hebraico');
  MapaIdiomas.AddOrSetValue('fa', 'Persa');
  MapaIdiomas.AddOrSetValue('th', 'Tailandês');
  MapaIdiomas.AddOrSetValue('vi', 'Vietnamita');
  MapaIdiomas.AddOrSetValue('id', 'Indonésio');
  MapaIdiomas.AddOrSetValue('ms', 'Malaio');
  MapaIdiomas.AddOrSetValue('tl', 'Filipino');
  MapaIdiomas.AddOrSetValue('ca', 'Catalão');
  MapaIdiomas.AddOrSetValue('eu', 'Basco');
  MapaIdiomas.AddOrSetValue('gl', 'Galego');
  MapaIdiomas.AddOrSetValue('hr', 'Croata');
  MapaIdiomas.AddOrSetValue('sr', 'Sérvio');
  MapaIdiomas.AddOrSetValue('bg', 'Búlgaro');
  MapaIdiomas.AddOrSetValue('sl', 'Esloveno');
  MapaIdiomas.AddOrSetValue('et', 'Estoniano');
  MapaIdiomas.AddOrSetValue('lv', 'Letão');
  MapaIdiomas.AddOrSetValue('lt', 'Lituano');
  MapaIdiomas.AddOrSetValue('is', 'Islandês');
  MapaIdiomas.AddOrSetValue('sw', 'Suaíli');
  MapaIdiomas.AddOrSetValue('af', 'Africâner');
  MapaIdiomas.AddOrSetValue('bn', 'Bengali');
  MapaIdiomas.AddOrSetValue('ta', 'Tâmil');
  MapaIdiomas.AddOrSetValue('te', 'Telugo');
  MapaIdiomas.AddOrSetValue('ur', 'Urdu');
  MapaIdiomas.AddOrSetValue('ml', 'Malaiala');
  MapaIdiomas.AddOrSetValue('mr', 'Marata');
  MapaIdiomas.AddOrSetValue('gu', 'Guzerate');
  MapaIdiomas.AddOrSetValue('kn', 'Canarês');
  MapaIdiomas.AddOrSetValue('pa', 'Punjabi');
  MapaIdiomas.AddOrSetValue('km', 'Khmer');
  MapaIdiomas.AddOrSetValue('my', 'Birmanês');
  MapaIdiomas.AddOrSetValue('la', 'Latim');
  MapaIdiomas.AddOrSetValue('eo', 'Esperanto');
end;

function MapearIdioma(const ACodigo: string): string;
var
  Codigo: string;
begin
  InicializarMapa;

  Codigo := ACodigo.Trim.ToLower;

  if Codigo.Contains('-') then
    Codigo := Copy(Codigo, 1, Pos('-', Codigo) - 1);

  if not MapaIdiomas.TryGetValue(Codigo, Result) then
    Result := ACodigo.Trim.ToUpper;
end;

initialization

finalization
  FreeAndNil(MapaIdiomas);

end.
