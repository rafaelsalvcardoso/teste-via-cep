unit Teste.ViaCEP.Service;

interface

uses
  Teste.Endereco.Model,
  ViaCEP.Core;

type
  TViaCEPFormato = (vcJSON, vcXML);

  TViaCEPService = class
  public
    class function ConsultarPorCEP(const ACep: string; AFormato: TViaCEPFormato): TEnderecoModel;
    class function ConsultarPorEndereco(const AUF, ACidade, ALogradouro: string; AFormato: TViaCEPFormato): TEnderecoModel;
  end;

implementation

uses
  System.Net.HttpClient,
  Teste.ViaCEP.Context,
  Teste.ViaCEP.Interfaces,
  Teste.ViaCEP.Parse.JSON,
  Teste.ViaCEP.Parse.XML;

class function TViaCEPService.ConsultarPorCEP(const ACep: string; AFormato: TViaCEPFormato): TEnderecoModel;
var
  LViaCEP: TViaCEP;
  Response: string;
  Context: TViaCEPContext;
  Strategy: IViaCEP;
begin
  LViaCEP := TViaCEP.Create;
  try
    case AFormato of
      vcJSON:
        begin
          LViaCEP.ReturnFormat := rfJSON;
          Strategy := TViaCEPParseJSON.Create;
        end;
      vcXML:
        begin
          LViaCEP.ReturnFormat := rfXML;
          Strategy := TViaCEPParseXML.Create;
        end;
    end;

    Response := LViaCEP.GetCEP(ACep);
    Context := TViaCEPContext.Create(Strategy);
    Result := Context.Executar(Response);

  finally
    LViaCEP.Free;
  end;
end;

class function TViaCEPService.ConsultarPorEndereco(const AUF, ACidade,
  ALogradouro: string; AFormato: TViaCEPFormato): TEnderecoModel;
var
  LViaCEP: TViaCEP;
  Response: string;
  Context: TViaCEPContext;
  Strategy: IViaCEP;
begin
  LViaCEP := TViaCEP.Create;
  try
    case AFormato of
      vcJSON:
        begin
          LViaCEP.ReturnFormat := rfJSON;
          Strategy := TViaCEPParseJSON.Create;
        end;
      vcXML:
        begin
          LViaCEP.ReturnFormat := rfXML;
          Strategy := TViaCEPParseXML.Create;
        end;
    end;

    Response := LViaCEP.GetEndereco(AUF, ACidade, ALogradouro);
    Context := TViaCEPContext.Create(Strategy);
    Result := Context.Executar(Response);

  finally
    LViaCEP.Free;
  end;
end;

end.

