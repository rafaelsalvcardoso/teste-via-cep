unit ViaCEP.Core;

interface

uses
  System.Classes,
  IdHTTP,
  IdSSLOpenSSL,
  Web.HTTPApp,
  NetEncoding;

type

  TReturnFormat = (rfJSON, rfXML);

  TViaCEP = class(TComponent)
  private
    FReturnFormat: TReturnFormat;
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

    function Get(const AValue: string; var AError: Boolean): string;
    function GetFormat: String;
    function ValidarCEP(const AValue: String): String;
    function ValidarEndereco(const AUF, ACidade, ALogradouro: string): string;

    procedure CriarComponentes;
  protected
    { Protected declarations }
  public
    constructor Create; reintroduce; overload;
    destructor Destroy; override;

    function GetCEP(const ACEP: string; var AError: Boolean): string;
    function GetEndereco(const AUF, ACidade, ALogradouro: string; var AError: Boolean): string;
  published
    property ReturnFormat: TReturnFormat read FReturnFormat write FReturnFormat;
  end;

const
  URL_BASE = 'https://viacep.com.br/ws/%s/%s';
  URL_PARAM_ENDERECO = '%s/%s/%s';

resourcestring
  MSG_ERRO_CEP_NAO_ENCONTRADO = 'O CEP informado não foi encontrado.';
  MSG_ERRO_CEP_DIGITO = 'CEP deve ter 8 dígitos.';
  MSG_ERRO_CEP_INVALIDO = 'Formato de CEP inválido.';
  MSG_ERRO_UF_CARACTER = 'UF deve ter 2 caracteres.';
  MSG_ERRO_LOGRADOURO_CARACTER = 'Logradouro deve ter 3 ou mais caracteres.';
  MSG_ERRO_CIDADE_CARACTER = 'Cidade deve ter 3 ou mais caracteres.';
  MSG_ERRO_CONSULTA = 'Erro ao consultar o CEP. ';

procedure Register;

implementation

uses
  System.SysUtils;

procedure Register;
begin
  RegisterComponents('ViaCEP', [TViaCEP]);
end;

{ TViaCEP }

constructor TViaCEP.Create;
begin
  inherited Create(nil);
end;

procedure TViaCEP.CriarComponentes;
begin
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
end;

destructor TViaCEP.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

function TViaCEP.Get(const AValue: string; var AError: Boolean): string;
var
  LResponse: TStringStream;
begin
  Result := EmptyStr;
  CriarComponentes;
  LResponse := TStringStream.Create;
  try
    try
      FIdHTTP.Get( Format(URL_BASE, [AValue.Trim, GetFormat]), LResponse );

      if FIdHTTP.ResponseCode = 200 then
      begin
        if LResponse.DataString.Contains('"erro": "true"') then
        begin
          AError := True;
          Exit(MSG_ERRO_CEP_NAO_ENCONTRADO);
        end;

        Result := UTF8ToString(AnsiString(LResponse.DataString));
      end
      else
      begin
        AError := True;
        Exit(MSG_ERRO_CONSULTA + FIdHTTP.ResponseCode.ToString);
      end;
    except
      on E: Exception do
        Result :=  MSG_ERRO_CONSULTA + slinebreak + E.Message;
    end;

  finally
    LResponse.Free;
  end;
end;

function TViaCEP.GetCEP(const ACEP: string; var AError: Boolean): string;
begin
  Result := EmptyStr;
  Result := ValidarCEP(ACEP);

  if not(Result.IsEmpty) then
  begin
    AError := True;
    Exit;
  end;

  Result := Get(ACEP, AError);
end;

function TViaCEP.GetEndereco(const AUF, ACidade, ALogradouro: string;
  var AError: Boolean): string;
var
  LEndereco: String;
begin
  Result := EmptyStr;
  Result := ValidarEndereco(AUF, ACidade, ALogradouro);

  if not(Result.IsEmpty) then
  begin
    AError := True;
    Exit;
  end;

  LEndereco := Format(URL_PARAM_ENDERECO, [AUF, ACidade, ALogradouro]);
  LEndereco := TNetEncoding.URL.Encode(LEndereco);

  Result := Get(LEndereco, AError);
end;

function TViaCEP.GetFormat: String;
begin
  Result := 'json';

  if FReturnFormat = rfXML then
    Result := 'xml';

end;

function TViaCEP.ValidarCEP(const AValue: String): String;
const
  INVALID_CHARACTER = -1;
begin
  Result := EmptyStr;

  if AValue.Trim.Length <> 8 then
    Exit(MSG_ERRO_CEP_DIGITO);

  if StrToIntDef(AValue, INVALID_CHARACTER) = INVALID_CHARACTER then
    Exit(MSG_ERRO_CEP_INVALIDO);

end;

function TViaCEP.ValidarEndereco(const AUF, ACidade,
  ALogradouro: string): string;
begin
  Result := EmptyStr;

  if Length(Trim(AUF)) <> 2 then
    Exit(MSG_ERRO_UF_CARACTER);

  if Length(Trim(ACidade)) < 3 then
    Exit(MSG_ERRO_CIDADE_CARACTER);

  if Length(Trim(ALogradouro)) < 3 then
    Exit(MSG_ERRO_LOGRADOURO_CARACTER);

end;

end.
