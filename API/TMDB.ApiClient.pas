unit TMDB.ApiClient;

interface

uses
  System.SysUtils, System.JSON, System.Threading, System.Net.HttpClient,
  System.Net.URLClient, System.Classes;

type
  ETMDBApiError = class(Exception);

  TTMDBClient = class
  private
    FHttpClient: THTTPClient;
    FBearerToken: string;
    const BaseUrl = 'https://api.themoviedb.org/3';
    function BuildUrl(const APath: string; const AAppendToResponse: string): string;
    function ExecuteGet(const AUrl, ABearerToken: string): TJSONObject;
  public
    constructor Create(const ABearerToken: string);
    destructor Destroy; override;
    function GetMovieAsync(const AId: Integer): IFuture<TJSONObject>;
    function GetTvShowAsync(const AId: Integer): IFuture<TJSONObject>;
  end;

implementation

constructor TTMDBClient.Create(const ABearerToken: string);
begin
  inherited Create;
  FBearerToken := ABearerToken;
  FHttpClient := THTTPClient.Create;
  FHttpClient.CustomHeaders['Authorization'] := 'Bearer ' + FBearerToken;
  FHttpClient.CustomHeaders['Accept'] := 'application/json';
end;

destructor TTMDBClient.Destroy;
begin
  //FHttpClient.Free;
  inherited Destroy;
end;

function TTMDBClient.BuildUrl(const APath: string; const AAppendToResponse: string): string;
begin
  Result := Format('%s%s?append_to_response=%s', [BaseUrl, APath, AAppendToResponse]);
end;

function TTMDBClient.ExecuteGet(const AUrl, ABearerToken: string): TJSONObject;
var
  LHttpClient: THTTPClient;
  LResponse: IHTTPResponse;
  LValue: TJSONValue;
begin
  LHttpClient := THTTPClient.Create;
  try
    LHttpClient.CustomHeaders['Authorization'] :=
      'Bearer ' + ABearerToken;

    LHttpClient.CustomHeaders['Accept'] :=
      'application/json';

    LResponse := LHttpClient.Get(AUrl);

    if LResponse.StatusCode <> 200 then
      raise ETMDBApiError.CreateFmt(
        'TMDB request failed with status %d: %s',
        [
          LResponse.StatusCode,
          LResponse.ContentAsString
        ]
      );

    LValue := TJSONObject.ParseJSONValue(
      LResponse.ContentAsString(TEncoding.UTF8)
    );

    if not Assigned(LValue) or not (LValue is TJSONObject) then
    begin
      LValue.Free;
      raise ETMDBApiError.Create(
        'TMDB response could not be parsed as a JSON object'
      );
    end;

    Result := LValue as TJSONObject;
  finally
    LHttpClient.Free;
  end;
end;

function TTMDBClient.GetMovieAsync(
  const AId: Integer): IFuture<TJSONObject>;
var
  LToken: string;
begin
  LToken := FBearerToken;

  Result := TTask.Future<TJSONObject>(
    function: TJSONObject
    var
      LUrl: string;
    begin
      LUrl := BuildUrl(
        Format('/movie/%d', [AId]),
        'credits,keywords,alternative_titles'
      );

      Result := ExecuteGet(LUrl, LToken);
    end
  );
end;

function TTMDBClient.GetTvShowAsync(const AId: Integer): IFuture<TJSONObject>;
var
  LToken: string;
begin
  LToken := FBearerToken;
  Result := TTask.Future<TJSONObject>(
    function: TJSONObject
    var
      LUrl: string;
    begin
      LUrl := BuildUrl(Format('/tv/%d', [AId]), 'credits,keywords,alternative_titles');
      Result := ExecuteGet(LUrl, LToken);
    end);
end;

end.
