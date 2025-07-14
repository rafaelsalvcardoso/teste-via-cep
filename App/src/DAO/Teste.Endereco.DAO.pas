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
    function ListarEnderecos: TObjectList<TEnderecoModel>;
    function ListarPorCEP(const ACep: string): TEnderecoModel;
    function ListarPorEndereco(const AUF, ACidade, ALogradouro: string): TObjectList<TEnderecoModel>;
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
    Qry.SQL.Text := 'INSERT INTO enderecos (cep, logradouro, complemento, bairro, cidade, estado) ' +
                    'VALUES (:cep, :logradouro, :complemento, :bairro, :cidade, :estado)';
    Qry.ParamByName('cep').AsString         := StringReplace(AEndereco.Cep, '-', EmptyStr, [rfReplaceAll, rfIgnoreCase]);;
    Qry.ParamByName('logradouro').AsString  := AEndereco.Logradouro;
    Qry.ParamByName('complemento').AsString := AEndereco.Complemento;
    Qry.ParamByName('bairro').AsString      := AEndereco.Bairro;
    Qry.ParamByName('cidade').AsString      := AEndereco.Localidade;
    Qry.ParamByName('estado').AsString      := AEndereco.Estado;
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
                    'complemento = :complemento, bairro = :bairro, cidade = :cidade, '+
                    'estado = :estado ' +
                    'WHERE id = :id';

    Qry.ParamByName('id').AsInteger := AEndereco.Id;
    Qry.ParamByName('cep').AsString := AEndereco.Cep;
    Qry.ParamByName('logradouro').AsString := AEndereco.Logradouro;
    Qry.ParamByName('complemento').AsString := AEndereco.Complemento;
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

function TEnderecoDAO.ListarPorCEP(const ACep: string): TEnderecoModel;
var
  Qry: TFDQuery;
  Endereco: TEnderecoModel;
begin
  Result := nil;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Text := 'SELECT * FROM enderecos WHERE cep = :cep';
    Qry.ParamByName('cep').AsString := ACep;
    Qry.Open;

    if Qry.RecordCount > 0 then
    begin
      Endereco := TEnderecoModel.Create;
      Endereco.Id          := Qry.FieldByName('id').AsInteger;
      Endereco.Cep         := Qry.FieldByName('cep').AsString;
      Endereco.Logradouro  := Qry.FieldByName('logradouro').AsString;
      Endereco.Complemento := Qry.FieldByName('complemento').AsString;
      Endereco.Bairro      := Qry.FieldByName('bairro').AsString;
      Endereco.Localidade  := Qry.FieldByName('cidade').AsString;
      Endereco.Estado      := Qry.FieldByName('estado').AsString;

      Result := Endereco;
    end;
  finally
    Qry.Free;
  end;
end;

function TEnderecoDAO.ListarPorEndereco(const AUF, ACidade,
  ALogradouro: string): TObjectList<TEnderecoModel>;
var
  Qry: TFDQuery;
  E: TEnderecoModel;
begin
  Result := TObjectList<TEnderecoModel>.Create;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConn;
    Qry.SQL.Add('SELECT * FROM enderecos');
    Qry.SQL.Add('WHERE estado = :UF');
    Qry.SQL.Add('AND cidade LIKE :CIDADE');
    Qry.SQL.Add(' AND logradouro LIKE :LOGRADOURO');
    Qry.ParamByName('UF').AsString := AUF;
    Qry.ParamByName('CIDADE').AsString := '%'+ACidade+'%';
    Qry.ParamByName('LOGRADOURO').AsString := '%'+ALogradouro+'%';
    Qry.Open;
    while not Qry.Eof do
    begin
      E := TEnderecoModel.Create;

      E.Id          := Qry.FieldByName('id').AsInteger;
      E.Cep         := Qry.FieldByName('cep').AsString;
      E.Logradouro  := Qry.FieldByName('logradouro').AsString;
      E.Complemento := Qry.FieldByName('complemento').AsString;
      E.Bairro      := Qry.FieldByName('bairro').AsString;
      E.Localidade  := Qry.FieldByName('cidade').AsString;
      E.Estado      := Qry.FieldByName('estado').AsString;
      Result.Add(E);
      Qry.Next;
    end;
  finally
    Qry.Free;
  end;
end;

function TEnderecoDAO.ListarEnderecos: TObjectList<TEnderecoModel>;
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

      E.Id          := Qry.FieldByName('id').AsInteger;
      E.Cep         := Qry.FieldByName('cep').AsString;
      E.Logradouro  := Qry.FieldByName('logradouro').AsString;
      E.Complemento := Qry.FieldByName('complemento').AsString;
      E.Bairro      := Qry.FieldByName('bairro').AsString;
      E.Localidade  := Qry.FieldByName('cidade').AsString;
      E.Estado      := Qry.FieldByName('estado').AsString;
      Result.Add(E);
      Qry.Next;
    end;
  finally
    Qry.Free;
  end;
end;

end.

