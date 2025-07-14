unit Teste.ViaCEP.Parse.Json;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  Teste.ViaCEP.Interfaces,
  Teste.Endereco.Model;

type
  TViaCEPParseJSON = class(TInterfacedObject, IViaCEP)
  private
    function CriarEndereco(AJSON: TJSonValue): TEnderecoModel;
  public
    function Deserialize(const AContent: string): TEnderecoModel;
    function DeserializeList(const AContent: string): TObjectList<TEnderecoModel>;
  end;

implementation

function TViaCEPParseJSON.CriarEndereco(AJSON: TJSonValue): TEnderecoModel;
begin
  Result := TEnderecoModel.Create;
  Result.Cep         := AJSON.GetValue<string>('cep');
  Result.Logradouro  := AJSON.GetValue<string>('logradouro');
  Result.Complemento := AJSON.GetValue<string>('complemento');
  Result.Bairro      := AJSON.GetValue<string>('bairro');
  Result.Localidade  := AJSON.GetValue<string>('localidade');
  Result.Estado      := AJSON.GetValue<string>('uf');
end;

function TViaCEPParseJSON.Deserialize(const AContent: string): TEnderecoModel;
var
  JSONValue: TJSonValue;
begin
  Result := nil;

  JSONValue := TJSONObject.ParseJSONValue(AContent);
  try
    Result := CriarEndereco(JSONValue);
  finally
    JSONValue.Free;
  end;
end;

function TViaCEPParseJSON.DeserializeList(
  const AContent: string): TObjectList<TEnderecoModel>;
var
  JSONArray: TJSONArray;
  I: Integer;
begin
  Result := TObjectList<TEnderecoModel>.Create(True);
  JSONArray := TJSONObject.ParseJSONValue(AContent) as TJSONArray;
  try
    for I := 0 to JSONArray.Count - 1 do
    begin
      Result.Add( CriarEndereco(JSONArray.Items[I]) );
    end;
  finally
    JSONArray.Free;
  end;
end;

end.

