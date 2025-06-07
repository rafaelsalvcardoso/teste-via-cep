unit Teste.Endereco.Model;

interface

type
  TEnderecoModel = class
  private
    FLogradouro: string;
    FRegiao: string;
    FIbge: string;
    FBairro: string;
    FDdd: string;
    FUf: string;
    FCep: string;
    FSiafi: string;
    FLocalidade: string;
    FUnidade: string;
    FComplemento: string;
    FGia: string;
    FEstado: string;
    FId: Integer;
  public
    property Id: Integer read FId write FId;
    property Cep: string read FCep write FCep;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Complemento: string read FComplemento write FComplemento;
    property Unidade: string read FUnidade write FUnidade;
    property Bairro: string read FBairro write FBairro;
    property Localidade: string read FLocalidade write FLocalidade;
    property Uf: string read FUf write FUf;
    property Estado: string read FEstado write FEstado;
    property Regiao: string read FRegiao write FRegiao;
    property Ibge: string read FIbge write FIbge;
    property Gia: string read FGia write FGia;
    property Ddd: string read FDdd write FDdd;
    property Siafi: string read FSiafi write FSiafi;

    function toString: String;
  end;

implementation

{ TEnderecoModel }

function TEnderecoModel.toString: String;
begin
  Result := FCep +sLineBreak+ FLogradouro +' - '+ FComplemento +sLineBreak+
    FBairro +sLineBreak+ FLocalidade +sLineBreak+ FUf;
end;

end.
