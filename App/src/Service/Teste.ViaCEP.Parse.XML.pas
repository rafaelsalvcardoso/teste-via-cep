unit Teste.ViaCEP.Parse.XML;

interface

uses
  System.Generics.Collections,
  Xml.XMLDoc,
  Xml.XMLIntf,
  Teste.ViaCEP.Interfaces,
  Teste.Endereco.Model;

type
  TViaCEPParseXML = class(TInterfacedObject, IViaCEP)
  private
    function CriarEndereco(AXMLNode: IXMLNode): TEnderecoModel;
  public
    function Deserialize(const AContent: string): TEnderecoModel;
    function DeserializeList(const AContent: string): TObjectList<TEnderecoModel>;
  end;

implementation

function TViaCEPParseXML.CriarEndereco(AXMLNode: IXMLNode): TEnderecoModel;
begin
  Result := TEnderecoModel.Create;
  Result.Cep         := AXMLNode.ChildNodes['cep'].Text;
  Result.Logradouro  := AXMLNode.ChildNodes['logradouro'].Text;
  Result.Complemento := AXMLNode.ChildNodes['complemento'].Text;
  Result.Bairro      := AXMLNode.ChildNodes['bairro'].Text;
  Result.Localidade  := AXMLNode.ChildNodes['localidade'].Text;
  Result.Estado      := AXMLNode.ChildNodes['uf'].Text;
end;

function TViaCEPParseXML.Deserialize(const AContent: string): TEnderecoModel;
var
  XMLDoc: IXMLDocument;
  Root: IXMLNode;
begin
  Result := nil;

  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.LoadFromXML(AContent);
  Root := XMLDoc.ChildNodes.FindNode('xmlcep');

  Result := CriarEndereco(Root);
end;

function TViaCEPParseXML.DeserializeList(
  const AContent: string): TObjectList<TEnderecoModel>;
var
  XMLDoc: IXMLDocument;
  RootNode, EnderecosNode, EnderecoNode: IXMLNode;
  I: Integer;
begin
  Result := TObjectList<TEnderecoModel>.Create(True);

  XMLDoc := TXMLDocument.Create(nil);
  XMLDoc.LoadFromXML(AContent);

  RootNode := XMLDoc.ChildNodes.FindNode('xmlcep');
  EnderecosNode := RootNode.ChildNodes.FindNode('enderecos');

  for I := 0 to Pred(EnderecosNode.ChildNodes.Count) do
  begin
    EnderecoNode := EnderecosNode.ChildNodes[I];
    Result.Add(CriarEndereco(EnderecoNode));
  end;
end;

end.

