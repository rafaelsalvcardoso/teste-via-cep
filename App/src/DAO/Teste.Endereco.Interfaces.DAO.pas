unit Teste.Endereco.Interfaces.DAO;

interface

uses
  System.Generics.Collections,
  Teste.Endereco.Model;

type
  IEnderecoDAO = interface
    ['{EEA78CF0-36A7-47B1-A6D2-623B40E41FE2}']
    procedure Inserir(AEndereco: TEnderecoModel);
    procedure Atualizar(AEndereco: TEnderecoModel);
    procedure Excluir(AId: Integer);
    function Listar: TObjectList<TEnderecoModel>;
  end;

implementation

end.

