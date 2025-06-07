unit Teste.Endereco.DAO;

interface

uses
  System.Generics.Collections,
  Teste.Endereco.Interfaces.DAO,
  Teste.Endereco.Model,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TEnderecoDAO = class(TInterfacedObject, IEnderecoDAO)
  private
    FConn: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure Inserir(AEndereco: TEnderecoModel);
    procedure Atualizar(AEndereco: TEnderecoModel);
    procedure Excluir(AId: Integer);
    function Listar: TObjectList<TEnderecoModel>;
  end;

implementation

uses
  System.SysUtils;

constructor TEnderecoDAO.Create(AConnection: TFDConnection);
begin
  FConn := AConnection;
end;

procedure TEnderecoDAO.Inserir(AEndereco: TEnderecoModel);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text := 'INSERT INTO enderecos (cep, logradouro, bairro, cidade, estado) ' +
                    'VALUES (:cep, :logradouro, :bairro, :cidade, :estado)';
    Qry.ParamByName('cep').AsString := AEndereco.Cep;
    Qry.ParamByName('logradouro').AsString := AEndereco.Logradouro;
    Qry.ParamByName('bairro').AsString := AEndereco.Bairro;
    Qry.ParamByName('cidade').AsString := AEndereco.Localidade;
    Qry.ParamByName('estado').AsString := AEndereco.Estado;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TEnderecoDAO.Atualizar(AEndereco: TEnderecoModel);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text := 'UPDATE enderecos SET cep = :cep, logradouro = :logradouro, ' +
                    'bairro = :bairro, cidade = :cidade, estado = :estado ' +
                    'WHERE id = :id';
    Qry.ParamByName('id').AsInteger := AEndereco.Id;
    Qry.ParamByName('cep').AsString := AEndereco.Cep;
    Qry.ParamByName('logradouro').AsString := AEndereco.Logradouro;
    Qry.ParamByName('bairro').AsString := AEndereco.Bairro;
    Qry.ParamByName('cidade').AsString := AEndereco.Localidade;
    Qry.ParamByName('estado').AsString := AEndereco.Estado;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TEnderecoDAO.Excluir(AId: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text := 'DELETE FROM enderecos WHERE id = :id';
    Qry.ParamByName('id').AsInteger := AId;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

function TEnderecoDAO.Listar: TObjectList<TEnderecoModel>;
var
  Qry: TFDQuery;
  E: TEnderecoModel;
begin
  Result := TObjectList<TEnderecoModel>.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text := 'SELECT * FROM enderecos';
    Qry.Open;
    while not Qry.Eof do
    begin
      E := TEnderecoModel.Create;
      E.Id := Qry.FieldByName('id').AsInteger;
      E.Cep := Qry.FieldByName('cep').AsString;
      E.Logradouro := Qry.FieldByName('logradouro').AsString;
      E.Bairro := Qry.FieldByName('bairro').AsString;
      E.Localidade := Qry.FieldByName('cidade').AsString;
      E.Estado := Qry.FieldByName('estado').AsString;
      Result.Add(E);
      Qry.Next;
    end;
  finally
    Qry.Free;
  end;
end;

end.

