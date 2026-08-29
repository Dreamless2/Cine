program Cine;

uses
  Vcl.Forms,
  CineView in 'Views\CineView.pas' {CineMain},
  TMDB.MediaEngine in 'Engine\TMDB.MediaEngine.pas',
  TMDB.ApiClient in 'API\TMDB.ApiClient.pas',
  TMDB.KeyStore in 'Store\TMDB.KeyStore.pas',
  TokenView in 'Views\TokenView.pas' {TokenMain},
  FilmesView in 'Views\FilmesView.pas' {FilmesMain},
  SeriesView in 'Views\SeriesView.pas' {SeriesMain},
  AnimesView in 'Views\AnimesView.pas' {AnimesMain},
  ResumoBuilder in 'Builders\ResumoBuilder.pas',
  MidiaFormEvents in 'Builders\MidiaFormEvents.pas',
  LanguageMapper in 'Mapper\LanguageMapper.pas',
  CountryMapper in 'Mapper\CountryMapper.pas',
  CineContext in 'Data\CineContext.pas' {HistoricoDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;

  Application.CreateForm(TCineMain, CineMain);
  Application.CreateForm(TFilmesMain, FilmesMain);
  Application.CreateForm(TSeriesMain, SeriesMain);
  Application.CreateForm(TAnimesMain, AnimesMain);
  Application.CreateForm(THistoricoDataModule, HistoricoDataModule);
  if HasStoredApiKey then
  begin
    Application.ShowMainForm := True;
  end
  else
  begin
    Application.CreateForm(TTokenMain, TokenMain);
    TokenMain.Show;
  end;

  Application.Run;
end.
