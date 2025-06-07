unit Teste.ViaCEP.Interfaces;

interface

uses
  Teste.Endereco.Model;

type
  iViaCEP = interface
  ['{7B340602-791A-4000-894A-BE59FB97D3F4}']
    function Deserialize(const AContent: string): TEnderecoModel;
  end;

implementation

end.
