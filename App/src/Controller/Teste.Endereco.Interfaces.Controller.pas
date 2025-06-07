unit Teste.Endereco.Interfaces.Controller;

interface

uses
  System.Generics.Collections,
  Teste.Endereco.Model;

type
  IEnderecoController = interface
    ['{37BA1673-EA53-4D30-9D52-C125E8B03181}']
    procedure Salvar(AEndereco: TEnderecoModel);
    procedure Excluir(Id: Integer);
    function Listar: TObjectList<TEnderecoModel>;
  end;

implementation

end.

