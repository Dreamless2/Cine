unit TMDB.KeyStore;

interface

uses
  System.SysUtils, Winapi.Windows;

procedure SaveApiKey(const AApiKey: string);
function LoadApiKey: string;
function HasStoredApiKey: Boolean;

implementation

const
  CRED_TYPE_GENERIC = 1;

  CRED_PERSIST_SESSION = 1;
  CRED_PERSIST_LOCAL_MACHINE = 2;
  CRED_PERSIST_ENTERPRISE = 3;

  ERROR_NOT_FOUND = 1168;

type
  PCredentialAttributeW = ^TCredentialAttributeW;
  TCredentialAttributeW = record
    Keyword: PWideChar;
    Flags: DWORD;
    ValueSize: DWORD;
    Value: PByte;
  end;

  PCredentialW = ^TCredentialW;
  TCredentialW = record
    Flags: DWORD;
    &Type: DWORD;
    TargetName: PWideChar;
    Comment: PWideChar;
    LastWritten: FILETIME;
    CredentialBlobSize: DWORD;
    CredentialBlob: PByte;
    Persist: DWORD;
    AttributeCount: DWORD;
    Attributes: PCredentialAttributeW;
    TargetAlias: PWideChar;
    UserName: PWideChar;
  end;

function CredWriteW(
  Credential: PCredentialW;
  Flags: DWORD
): BOOL; stdcall; external 'Advapi32.dll';

function CredReadW(
  TargetName: PWideChar;
  &Type: DWORD;
  Flags: DWORD;
  out Credential: PCredentialW
): BOOL; stdcall; external 'Advapi32.dll';

procedure CredFree(
  Buffer: Pointer
); stdcall; external 'Advapi32.dll';

const
  CredentialTarget = 'Cine/TMDB/APIKey';

procedure RaiseCredentialError(const AOperation: string);
var
  LError: DWORD;
begin
  LError := GetLastError;

  raise EOSError.CreateFmt(
    '%s failed. Windows error %d: %s',
    [
      AOperation,
      LError,
      SysErrorMessage(LError)
    ]
  );
end;

procedure SaveApiKey(const AApiKey: string);
var
  LCredential: TCredentialW;
  LApiKeyBytes: TBytes;
begin
  if AApiKey.Trim.IsEmpty then
    raise EArgumentException.Create('API key cannot be empty.');

  LApiKeyBytes := TEncoding.UTF8.GetBytes(AApiKey);
  ZeroMemory(@LCredential, SizeOf(LCredential));
  LCredential.&Type := CRED_TYPE_GENERIC;
  LCredential.TargetName := PWideChar(CredentialTarget);
  LCredential.CredentialBlobSize := Length(LApiKeyBytes);

  if Length(LApiKeyBytes) > 0 then
    LCredential.CredentialBlob := @LApiKeyBytes[0];

  LCredential.Persist := CRED_PERSIST_LOCAL_MACHINE;

  if not CredWriteW(@LCredential, 0) then
    RaiseCredentialError('CredWriteW');
end;

function LoadApiKey: string;
var
  LCredential: PCredentialW;
  LApiKeyBytes: TBytes;
begin
  Result := '';
  LCredential := nil;

  if not CredReadW(PWideChar(CredentialTarget), CRED_TYPE_GENERIC, 0, LCredential) then
  begin
    if GetLastError = ERROR_NOT_FOUND then
      Exit;

    RaiseCredentialError('CredReadW');
  end;

  try
    if (LCredential = nil) or (LCredential^.CredentialBlob = nil) or (LCredential^.CredentialBlobSize = 0) then
      Exit;

    SetLength(LApiKeyBytes, LCredential^.CredentialBlobSize);
    Move(LCredential^.CredentialBlob^, LApiKeyBytes[0], LCredential^.CredentialBlobSize);
    Result := TEncoding.UTF8.GetString(LApiKeyBytes);

  finally
    if LCredential <> nil then
      CredFree(LCredential);
  end;
end;

function HasStoredApiKey: Boolean;
var
  LCredential: PCredentialW;
begin
  LCredential := nil;

  Result := CredReadW(PWideChar(CredentialTarget), CRED_TYPE_GENERIC, 0, LCredential);

  if Result then
  begin
    CredFree(LCredential);
    Exit;
  end;

  if GetLastError = ERROR_NOT_FOUND then
  begin
    Result := False;
    Exit;
  end;

  RaiseCredentialError('CredReadW');
end;

end.
