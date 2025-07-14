unit Teste.ViaCEP.Context;

interface

uses
  System.Generics.Collections,
  Teste.ViaCEP.Interfaces,
  Teste.Endereco.Model;

type
  TViaCEPContext = class
  private
    FStrategy: IViaCEP;
  public
    constructor Create(AStrategy: IViaCEP);
    function Executar(const AContent: string): TEnderecoModel;
    function ExecutarLista(const AContent: string): TObjectList<TEnderecoModel>;
  end;

implementation

constructor TViaCEPContext.Create(AStrategy: IViaCEP);
begin
  FStrategy := AStrategy;
end;

function TViaCEPContext.Executar(const AContent: string): TEnderecoModel;
begin
  Result := FStrategy.Deserialize(AContent);
end;

function TViaCEPContext.ExecutarLista(
  const AContent: string): TObjectList<TEnderecoModel>;
begin
  Result := FStrategy.DeserializeList(AContent);
end;

end.

