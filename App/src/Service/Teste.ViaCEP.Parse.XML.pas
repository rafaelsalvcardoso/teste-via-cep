unit Teste.ViaCEP.Parse.XML;

interface

uses
  Teste.ViaCEP.Interfaces,
  Teste.Endereco.Model;

type
  TViaCEPParseXML = class(TInterfacedObject, IViaCEP)
  public
    function Deserialize(const AContent: string): TEnderecoModel;
  end;

implementation

uses
  Xml.XMLDoc, Xml.XMLIntf;

function TViaCEPParseXML.Deserialize(const AContent: string): TEnderecoModel;
var
  XMLDoc: TXMLDocument;
  Root: IXMLNode;
begin
  Result := TEnderecoModel.Create;
  XMLDoc := TXMLDocument.Create(nil);
  try
    XMLDoc.LoadFromXML(AContent);
    XMLDoc.Active := True;
    Root := XMLDoc.DocumentElement;
    Result.Cep         := Root.ChildNodes['cep'].Text;
    Result.Logradouro  := Root.ChildNodes['logradouro'].Text;
    Result.Complemento := Root.ChildNodes['complemento'].Text;
    Result.Bairro      := Root.ChildNodes['bairro'].Text;
    Result.Localidade  := Root.ChildNodes['localidade'].Text;
    Result.Estado      := Root.ChildNodes['uf'].Text;
  finally
    XMLDoc.Free;
  end;
end;

end.

