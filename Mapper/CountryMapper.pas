unit CountryMapper;

interface

function MapearPais(const ANomeIngles: string): string;

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections;

var
  MapaPaises: TDictionary<string, string>;

procedure InicializarMapa;
begin
  if Assigned(MapaPaises) then
    Exit;

  MapaPaises := TDictionary<string, string>.Create;
  MapaPaises.AddOrSetValue('Afghanistan', 'Afeganistão');
  MapaPaises.AddOrSetValue('Albania', 'Albânia');
  MapaPaises.AddOrSetValue('Algeria', 'Argélia');
  MapaPaises.AddOrSetValue('Andorra', 'Andorra');
  MapaPaises.AddOrSetValue('Angola', 'Angola');
  MapaPaises.AddOrSetValue('Argentina', 'Argentina');
  MapaPaises.AddOrSetValue('Armenia', 'Armênia');
  MapaPaises.AddOrSetValue('Australia', 'Austrália');
  MapaPaises.AddOrSetValue('Austria', 'Áustria');
  MapaPaises.AddOrSetValue('Azerbaijan', 'Azerbaijão');
  MapaPaises.AddOrSetValue('Bahamas', 'Bahamas');
  MapaPaises.AddOrSetValue('Bahrain', 'Bahrein');
  MapaPaises.AddOrSetValue('Bangladesh', 'Bangladesh');
  MapaPaises.AddOrSetValue('Barbados', 'Barbados');
  MapaPaises.AddOrSetValue('Belarus', 'Belarus');
  MapaPaises.AddOrSetValue('Belgium', 'Bélgica');
  MapaPaises.AddOrSetValue('Belize', 'Belize');
  MapaPaises.AddOrSetValue('Benin', 'Benim');
  MapaPaises.AddOrSetValue('Bolivia', 'Bolívia');
  MapaPaises.AddOrSetValue('Bosnia and Herzegovina', 'Bósnia e Herzegovina');
  MapaPaises.AddOrSetValue('Botswana', 'Botsuana');
  MapaPaises.AddOrSetValue('Brazil', 'Brasil');
  MapaPaises.AddOrSetValue('Brunei', 'Brunei');
  MapaPaises.AddOrSetValue('Bulgaria', 'Bulgária');
  MapaPaises.AddOrSetValue('Burkina Faso', 'Burquina Faso');
  MapaPaises.AddOrSetValue('Burundi', 'Burundi');
  MapaPaises.AddOrSetValue('Cambodia', 'Camboja');
  MapaPaises.AddOrSetValue('Cameroon', 'Camarões');
  MapaPaises.AddOrSetValue('Canada', 'Canadá');
  MapaPaises.AddOrSetValue('Cape Verde', 'Cabo Verde');
  MapaPaises.AddOrSetValue('Chad', 'Chade');
  MapaPaises.AddOrSetValue('Chile', 'Chile');
  MapaPaises.AddOrSetValue('China', 'China');
  MapaPaises.AddOrSetValue('Colombia', 'Colômbia');
  MapaPaises.AddOrSetValue('Congo', 'Congo');
  MapaPaises.AddOrSetValue('Costa Rica', 'Costa Rica');
  MapaPaises.AddOrSetValue('Croatia', 'Croácia');
  MapaPaises.AddOrSetValue('Cuba', 'Cuba');
  MapaPaises.AddOrSetValue('Cyprus', 'Chipre');
  MapaPaises.AddOrSetValue('Czech Republic', 'República Tcheca');
  MapaPaises.AddOrSetValue('Czechia', 'Tchequia');
  MapaPaises.AddOrSetValue('Denmark', 'Dinamarca');
  MapaPaises.AddOrSetValue('Djibouti', 'Djibuti');
  MapaPaises.AddOrSetValue('Dominica', 'Dominica');
  MapaPaises.AddOrSetValue('Dominican Republic', 'República Dominicana');
  MapaPaises.AddOrSetValue('Ecuador', 'Equador');
  MapaPaises.AddOrSetValue('Egypt', 'Egito');
  MapaPaises.AddOrSetValue('El Salvador', 'El Salvador');
  MapaPaises.AddOrSetValue('England', 'Inglaterra');
  MapaPaises.AddOrSetValue('Equatorial Guinea', 'Guiné Equatorial');
  MapaPaises.AddOrSetValue('Eritrea', 'Eritreia');
  MapaPaises.AddOrSetValue('Estonia', 'Estônia');
  MapaPaises.AddOrSetValue('Eswatini', 'Eswatini');
  MapaPaises.AddOrSetValue('Ethiopia', 'Etiópia');
  MapaPaises.AddOrSetValue('Fiji', 'Fiji');
  MapaPaises.AddOrSetValue('Finland', 'Finlândia');
  MapaPaises.AddOrSetValue('France', 'França');
  MapaPaises.AddOrSetValue('Gabon', 'Gabão');
  MapaPaises.AddOrSetValue('Gambia', 'Gâmbia');
  MapaPaises.AddOrSetValue('Georgia', 'Geórgia');
  MapaPaises.AddOrSetValue('Germany', 'Alemanha');
  MapaPaises.AddOrSetValue('Ghana', 'Gana');
  MapaPaises.AddOrSetValue('Greece', 'Grécia');
  MapaPaises.AddOrSetValue('Grenada', 'Granada');
  MapaPaises.AddOrSetValue('Guatemala', 'Guatemala');
  MapaPaises.AddOrSetValue('Guinea', 'Guiné');
  MapaPaises.AddOrSetValue('Guyana', 'Guiana');
  MapaPaises.AddOrSetValue('Haiti', 'Haiti');
  MapaPaises.AddOrSetValue('Honduras', 'Honduras');
  MapaPaises.AddOrSetValue('Hungary', 'Hungria');
  MapaPaises.AddOrSetValue('Iceland', 'Islândia');
  MapaPaises.AddOrSetValue('India', 'Índia');
  MapaPaises.AddOrSetValue('Indonesia', 'Indonésia');
  MapaPaises.AddOrSetValue('Iran', 'Irã');
  MapaPaises.AddOrSetValue('Iraq', 'Iraque');
  MapaPaises.AddOrSetValue('Ireland', 'Irlanda');
  MapaPaises.AddOrSetValue('Israel', 'Israel');
  MapaPaises.AddOrSetValue('Italy', 'Itália');
  MapaPaises.AddOrSetValue('Jamaica', 'Jamaica');
  MapaPaises.AddOrSetValue('Japan', 'Japão');
  MapaPaises.AddOrSetValue('Jordan', 'Jordânia');
  MapaPaises.AddOrSetValue('Kazakhstan', 'Cazaquistão');
  MapaPaises.AddOrSetValue('Kenya', 'Quênia');
  MapaPaises.AddOrSetValue('Kiribati', 'Quiribati');
  MapaPaises.AddOrSetValue('Kuwait', 'Kuwait');
  MapaPaises.AddOrSetValue('Kyrgyzstan', 'Quirguistão');
  MapaPaises.AddOrSetValue('Laos', 'Laos');
  MapaPaises.AddOrSetValue('Latvia', 'Letônia');
  MapaPaises.AddOrSetValue('Lebanon', 'Líbano');
  MapaPaises.AddOrSetValue('Lesotho', 'Lesoto');
  MapaPaises.AddOrSetValue('Liberia', 'Libéria');
  MapaPaises.AddOrSetValue('Libya', 'Líbia');
  MapaPaises.AddOrSetValue('Liechtenstein', 'Liechtenstein');
  MapaPaises.AddOrSetValue('Lithuania', 'Lituânia');
  MapaPaises.AddOrSetValue('Luxembourg', 'Luxemburgo');
  MapaPaises.AddOrSetValue('Madagascar', 'Madagascar');
  MapaPaises.AddOrSetValue('Malawi', 'Malaui');
  MapaPaises.AddOrSetValue('Malaysia', 'Malásia');
  MapaPaises.AddOrSetValue('Maldives', 'Maldivas');
  MapaPaises.AddOrSetValue('Mali', 'Mali');
  MapaPaises.AddOrSetValue('Malta', 'Malta');
  MapaPaises.AddOrSetValue('Mauritania', 'Mauritânia');
  MapaPaises.AddOrSetValue('Mauritius', 'Maurício');
  MapaPaises.AddOrSetValue('Mexico', 'México');
  MapaPaises.AddOrSetValue('Micronesia', 'Micronésia');
  MapaPaises.AddOrSetValue('Moldova', 'Moldávia');
  MapaPaises.AddOrSetValue('Monaco', 'Mônaco');
  MapaPaises.AddOrSetValue('Mongolia', 'Mongólia');
  MapaPaises.AddOrSetValue('Montenegro', 'Montenegro');
  MapaPaises.AddOrSetValue('Morocco', 'Marrocos');
  MapaPaises.AddOrSetValue('Mozambique', 'Moçambique');
  MapaPaises.AddOrSetValue('Myanmar', 'Myanmar');
  MapaPaises.AddOrSetValue('Namibia', 'Namíbia');
  MapaPaises.AddOrSetValue('Nauru', 'Nauru');
  MapaPaises.AddOrSetValue('Nepal', 'Nepal');
  MapaPaises.AddOrSetValue('Netherlands', 'Holanda');
  MapaPaises.AddOrSetValue('New Zealand', 'Nova Zelândia');
  MapaPaises.AddOrSetValue('Nicaragua', 'Nicarágua');
  MapaPaises.AddOrSetValue('Niger', 'Níger');
  MapaPaises.AddOrSetValue('Nigeria', 'Nigéria');
  MapaPaises.AddOrSetValue('North Korea', 'Coreia do Norte');
  MapaPaises.AddOrSetValue('North Macedonia', 'Macedônia do Norte');
  MapaPaises.AddOrSetValue('Norway', 'Noruega');
  MapaPaises.AddOrSetValue('Oman', 'Omã');
  MapaPaises.AddOrSetValue('Pakistan', 'Paquistão');
  MapaPaises.AddOrSetValue('Palau', 'Palau');
  MapaPaises.AddOrSetValue('Palestine', 'Palestina');
  MapaPaises.AddOrSetValue('Panama', 'Panamá');
  MapaPaises.AddOrSetValue('Papua New Guinea', 'Papua-Nova Guiné');
  MapaPaises.AddOrSetValue('Paraguay', 'Paraguai');
  MapaPaises.AddOrSetValue('Peru', 'Peru');
  MapaPaises.AddOrSetValue('Philippines', 'Filipinas');
  MapaPaises.AddOrSetValue('Poland', 'Polônia');
  MapaPaises.AddOrSetValue('Portugal', 'Portugal');
  MapaPaises.AddOrSetValue('Qatar', 'Catar');
  MapaPaises.AddOrSetValue('Romania', 'Romênia');
  MapaPaises.AddOrSetValue('Russia', 'Rússia');
  MapaPaises.AddOrSetValue('Rwanda', 'Ruanda');
  MapaPaises.AddOrSetValue('Saudi Arabia', 'Arábia Saudita');
  MapaPaises.AddOrSetValue('Scotland', 'Escócia');
  MapaPaises.AddOrSetValue('Senegal', 'Senegal');
  MapaPaises.AddOrSetValue('Serbia', 'Sérvia');
  MapaPaises.AddOrSetValue('Seychelles', 'Seychelles');
  MapaPaises.AddOrSetValue('Sierra Leone', 'Serra Leoa');
  MapaPaises.AddOrSetValue('Singapore', 'Cingapura');
  MapaPaises.AddOrSetValue('Slovakia', 'Eslováquia');
  MapaPaises.AddOrSetValue('Slovenia', 'Eslovênia');
  MapaPaises.AddOrSetValue('Somalia', 'Somália');
  MapaPaises.AddOrSetValue('South Africa', 'África do Sul');
  MapaPaises.AddOrSetValue('South Korea', 'Coreia do Sul');
  MapaPaises.AddOrSetValue('South Sudan', 'Sudão do Sul');
  MapaPaises.AddOrSetValue('Spain', 'Espanha');
  MapaPaises.AddOrSetValue('Sri Lanka', 'Sri Lanka');
  MapaPaises.AddOrSetValue('Sudan', 'Sudão');
  MapaPaises.AddOrSetValue('Suriname', 'Suriname');
  MapaPaises.AddOrSetValue('Sweden', 'Suécia');
  MapaPaises.AddOrSetValue('Switzerland', 'Suíça');
  MapaPaises.AddOrSetValue('Syria', 'Síria');
  MapaPaises.AddOrSetValue('Taiwan', 'Taiwan');
  MapaPaises.AddOrSetValue('Tajikistan', 'Tajiquistão');
  MapaPaises.AddOrSetValue('Tanzania', 'Tanzânia');
  MapaPaises.AddOrSetValue('Thailand', 'Tailândia');
  MapaPaises.AddOrSetValue('Togo', 'Togo');
  MapaPaises.AddOrSetValue('Tonga', 'Tonga');
  MapaPaises.AddOrSetValue('Trinidad and Tobago', 'Trinidad e Tobago');
  MapaPaises.AddOrSetValue('Tunisia', 'Tunísia');
  MapaPaises.AddOrSetValue('Turkey', 'Turquia');
  MapaPaises.AddOrSetValue('Turkiye', 'Turquia');
  MapaPaises.AddOrSetValue('Turkmenistan', 'Turcomenistão');
  MapaPaises.AddOrSetValue('Tuvalu', 'Tuvalu');
  MapaPaises.AddOrSetValue('Uganda', 'Uganda');
  MapaPaises.AddOrSetValue('Ukraine', 'Ucrânia');
  MapaPaises.AddOrSetValue('United Arab Emirates', 'Emirados Árabes Unidos');
  MapaPaises.AddOrSetValue('United Kingdom', 'Reino Unido');
  MapaPaises.AddOrSetValue('Uk', 'Reino Unido');
  MapaPaises.AddOrSetValue('United States', 'Estados Unidos');
  MapaPaises.AddOrSetValue('United States of America', 'Estados Unidos da América');
  MapaPaises.AddOrSetValue('Usa', 'Estados Unidos da América');
  MapaPaises.AddOrSetValue('Uruguay', 'Uruguai');
  MapaPaises.AddOrSetValue('Uzbekistan', 'Uzbequistão');
  MapaPaises.AddOrSetValue('Vanuatu', 'Vanuatu');
  MapaPaises.AddOrSetValue('Vatican City', 'Vaticano');
  MapaPaises.AddOrSetValue('Venezuela', 'Venezuela');
  MapaPaises.AddOrSetValue('Vietnam', 'Vietnã');
  MapaPaises.AddOrSetValue('Wales', 'País de Gales');
  MapaPaises.AddOrSetValue('Yemen', 'Iêmen');
  MapaPaises.AddOrSetValue('Zambia', 'Zâmbia');
  MapaPaises.AddOrSetValue('Zimbabwe', 'Zimbábue');
end;

function MapearPais(const ANomeIngles: string): string;
var
  NomeTratado: string;
begin
  InicializarMapa;

  NomeTratado := ANomeIngles.Trim;

  if NomeTratado.StartsWith('the ', True) then
    NomeTratado := Copy(NomeTratado, 5, MaxInt).Trim;

  if not MapaPaises.TryGetValue(NomeTratado, Result) then
    Result := ANomeIngles.Trim;
end;

initialization

finalization
  FreeAndNil(MapaPaises);

end.
