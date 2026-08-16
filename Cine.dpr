program Cine;

uses
  Vcl.Forms,
  CineView in 'Views\CineView.pas' {CineMain},
  TMDB.MediaEngine in 'Engine\TMDB.MediaEngine.pas',
  TMDB.ApiClient in 'API\TMDB.ApiClient.pas',
  TMDB.KeyStore in 'Store\TMDB.KeyStore.pas',
  TokenView in 'Views\TokenView.pas' {TokenMain},
  FilmesView in 'Views\FilmesView.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;

  Application.CreateForm(TCineMain, CineMain);
  Application.CreateForm(TForm1, Form1);
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
