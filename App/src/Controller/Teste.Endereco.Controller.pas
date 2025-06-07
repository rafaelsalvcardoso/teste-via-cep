unit Teste.Endereco.Controller;

interface

uses
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Teste.Endereco.Model,
  Teste.Endereco.Interfaces.Controller,
  Teste.Endereco.Interfaces.DAO,
  Teste.Endereco.DAO;

type
  TEnderecoController = class(TInterfacedObject, IEnderecoController)
  private
    FDAO: IEnderecoDAO;
  public
    constructor Create(AConnection: TFDConnection);
    procedure Salvar(AEndereco: TEnderecoModel);
    procedure Excluir(Id: Integer);
    function Listar: TObjectList<TEnderecoModel>;
  end;

implementation

constructor TEnderecoController.Create(AConnection: TFDConnection);
begin
  FDAO := TEnderecoDAO.Create(AConnection);
end;

procedure TEnderecoController.Salvar(AEndereco: TEnderecoModel);
begin
  if AEndereco.Id = 0 then
    FDAO.Inserir(AEndereco)
  else
    FDAO.Atualizar(AEndereco);
end;

procedure TEnderecoController.Excluir(Id: Integer);
begin
  FDAO.Excluir(Id);
end;

function TEnderecoController.Listar: TObjectList<TEnderecoModel>;
begin
  Result := FDAO.Listar;
end;

end.

