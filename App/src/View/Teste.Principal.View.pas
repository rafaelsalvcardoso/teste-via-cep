unit Teste.Principal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Teste.Endereco.Interfaces.Controller,
  Teste.Endereco.Controller,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  System.Generics.Collections,
  Teste.Endereco.Model, Vcl.ComCtrls;

type
  TTesteViaCeEPForm = class(TForm)
    PageControl: TPageControl;
    TSConsultarEnderecos: TTabSheet;
    TSListarEnderecos: TTabSheet;
    Panel: TPanel;
    ConsultarButton: TButton;
    StringGrid: TStringGrid;
    Memo: TMemo;
    topPanel: TPanel;
    FormatoComboBox: TComboBox;
    EnderecoGroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditUF: TEdit;
    EditCidade: TEdit;
    EditLogradouro: TEdit;
    ExecutarEnderecoButton: TButton;
    CEPGroupBox: TGroupBox;
    Label4: TLabel;
    CepEdit: TEdit;
    ExecutarCepButton: TButton;
    ConsultaPanel: TPanel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ConsultarButtonClick(Sender: TObject);
    procedure ExecutarCepButtonClick(Sender: TObject);
    procedure ExecutarEnderecoButtonClick(Sender: TObject);
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
  Teste.Connection.Factory, Teste.ViaCEP.Service;

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

procedure TTesteViaCeEPForm.ExecutarCepButtonClick(Sender: TObject);
var
  lEndereco: TEnderecoModel;
begin
  lEndereco := TViaCEPService.ConsultarPorCEP(CepEdit.Text, TViaCEPFormato(FormatoComboBox.ItemIndex));
  try
    try
      FEnderecoController.Salvar(lEndereco);
    except
      raise Exception.Create('Erro ao salvar endereço');
    end;
    Memo.Lines.Clear;
    Memo.Lines.Add( lEndereco.toString );
  finally
    lEndereco.Free;
  end;
end;

procedure TTesteViaCeEPForm.ExecutarEnderecoButtonClick(Sender: TObject);
var
  lEndereco: TEnderecoModel;
begin
  lEndereco := TViaCEPService.ConsultarPorEndereco(EditUF.Text, EditCidade.Text, EditLogradouro.Text,
                 TViaCEPFormato(FormatoComboBox.ItemIndex) );
  try
    Memo.Lines.Clear;
    Memo.Lines.Add( lEndereco.toString );
  finally
    lEndereco.Free;
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
