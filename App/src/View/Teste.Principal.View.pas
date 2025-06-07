unit Teste.Principal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Teste.Endereco.Interfaces.Controller,
  Teste.Endereco.Controller,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  System.Generics.Collections,
  Teste.Endereco.Model;

type
  TTesteViaCeEPForm = class(TForm)
    StringGrid: TStringGrid;
    Panel1: TPanel;
    ConsultarButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ConsultarButtonClick(Sender: TObject);
  private
    FConnection: TFDConnection;
    FEnderecoController: IEnderecoController;
  public
    { Public declarations }
  end;

var
  TesteViaCeEPForm: TTesteViaCeEPForm;

implementation

uses
  Teste.Connection.Factory;

{$R *.dfm}

procedure TTesteViaCeEPForm.ConsultarButtonClick(Sender: TObject);
var
  Lista: TObjectList<TEnderecoModel>;
  lEndereco: TEnderecoModel;
  LRow: Integer;
begin
  Lista := FEnderecoController.Listar;
  try
    StringGrid.RowCount := Lista.Count + 1;
    StringGrid.ColCount := 5;

    // Cabeçalho
    StringGrid.Cells[0, 0] := 'CEP';
    StringGrid.Cells[1, 0] := 'Logradouro';
    StringGrid.Cells[2, 0] := 'Bairro';
    StringGrid.Cells[3, 0] := 'Cidade';
    StringGrid.Cells[4, 0] := 'Estado';

    LRow := 0;
    for LEndereco in Lista do
    begin
      StringGrid.Cells[0, LRow+1] := LEndereco.Cep;
      StringGrid.Cells[1, LRow+1] := LEndereco.Logradouro;
      StringGrid.Cells[2, LRow+1] := LEndereco.Bairro;
      StringGrid.Cells[3, LRow+1] := LEndereco.Logradouro;
      StringGrid.Cells[4, LRow+1] := LEndereco.Estado;
      Inc(LRow);
    end;
  finally
    Lista.Free;
  end;

end;

procedure TTesteViaCeEPForm.FormCreate(Sender: TObject);
begin
  FConnection := TConnectionFactory.New.GetConnection;
  FEnderecoController := TEnderecoController.Create(FConnection);
end;

procedure TTesteViaCeEPForm.FormDestroy(Sender: TObject);
begin
  FConnection.Free;
end;

end.
