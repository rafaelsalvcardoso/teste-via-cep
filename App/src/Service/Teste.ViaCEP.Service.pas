unit Teste.ViaCEP.Service;

interface

uses
  System.Generics.Collections,
  Teste.Endereco.Model,
  ViaCEP.Core;

type
  TViaCEPFormato = (vcJSON, vcXML);

  TViaCEPService = class
  public
    class function ConsultarPorCEP(const ACep: string; AFormato: TViaCEPFormato): TEnderecoModel;
    class function ConsultarPorEndereco(const AUF, ACidade, ALogradouro: string; AFormato: TViaCEPFormato): TObjectList<TEnderecoModel>;
  end;

implementation

uses
  System.SysUtils,
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
  LError: Boolean;
begin
  LViaCEP := TViaCEP.Create;
  try
    LError := False;
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

    Response := LViaCEP.GetCEP(ACep, LError);

    if LError then
      raise Exception.Create(Response);

    Context := TViaCEPContext.Create(Strategy);
    Result := Context.Executar(Response);

  finally
    LViaCEP.Free;
  end;
end;

class function TViaCEPService.ConsultarPorEndereco(const AUF, ACidade,
  ALogradouro: string; AFormato: TViaCEPFormato): TObjectList<TEnderecoModel>;
var
  LViaCEP: TViaCEP;
  Response: string;
  Context: TViaCEPContext;
  Strategy: IViaCEP;
  LError: Boolean;
begin
  LViaCEP := TViaCEP.Create;
  try
    LError := False;
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

    Response := LViaCEP.GetEndereco(AUF, ACidade, ALogradouro, LError);

    if LError then
      raise Exception.Create(Response);

    Context := TViaCEPContext.Create(Strategy);
    Result := Context.ExecutarLista(Response);

  finally
    LViaCEP.Free;
  end;
end;

end.

