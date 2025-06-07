unit Teste.ViaCEP.Parse.Json;

interface

uses
  System.SysUtils,
  System.JSON,
  Teste.ViaCEP.Interfaces,
  Teste.Endereco.Model;

type
  TViaCEPParseJSON = class(TInterfacedObject, IViaCEP)
  public
    function Deserialize(const AContent: string): TEnderecoModel;
  end;

implementation

function TViaCEPParseJSON.Deserialize(const AContent: string): TEnderecoModel;
var
  JSON: TJSONObject;
begin
  Result := TEnderecoModel.Create;
  JSON := TJSONObject.ParseJSONValue(AContent) as TJSONObject;
  try
    Result.Cep         := JSON.GetValue<string>('cep');
    Result.Logradouro  := JSON.GetValue<string>('logradouro');
    Result.Complemento := JSON.GetValue<string>('complemento');
    Result.Bairro      := JSON.GetValue<string>('bairro');
    Result.Localidade  := JSON.GetValue<string>('localidade');
    Result.Estado      := JSON.GetValue<string>('uf');
  finally
    JSON.Free;
  end;
end;

end.

