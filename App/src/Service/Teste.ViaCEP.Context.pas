unit Teste.ViaCEP.Context;

interface

uses
  Teste.ViaCEP.Interfaces,
  Teste.Endereco.Model;

type
  TViaCEPContext = class
  private
    FStrategy: IViaCEP;
  public
    constructor Create(AStrategy: IViaCEP);
    function Executar(const AContent: string): TEnderecoModel;
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

end.

