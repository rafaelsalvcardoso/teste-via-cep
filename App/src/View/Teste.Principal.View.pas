unit Teste.Principal.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Teste.Endereco.Interfaces.Controller,
  Teste.Endereco.Controller,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  System.Generics.Collections,
  Teste.Endereco.Model, Vcl.ComCtrls, Data.DB, Datasnap.DBClient, Vcl.DBGrids;

type
  TTesteViaCeEPForm = class(TForm)
    PageControl: TPageControl;
    TSConsultarEnderecos: TTabSheet;
    TSListarEnderecos: TTabSheet;
    Panel: TPanel;
    ConsultarButton: TButton;
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
    DBGrid1: TDBGrid;
    dsEnderecos: TDataSource;
    CdsEnderecos: TClientDataSet;
    CdsEnderecosId: TIntegerField;
    CdsEnderecosCEP: TStringField;
    CdsEnderecosLogradouro: TStringField;
    CdsEnderecosComplemento: TStringField;
    CdsEnderecosBairro: TStringField;
    CdsEnderecosCidade: TStringField;
    CdsEnderecosUF: TStringField;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ConsultarButtonClick(Sender: TObject);
    procedure ExecutarCepButtonClick(Sender: TObject);
    procedure ExecutarEnderecoButtonClick(Sender: TObject);
  private
    FConnection: TFDConnection;
    FEnderecoController: IEnderecoController;
    FCdsEnderecos: TClientDataSet;

    function AtualizarEndereco: Boolean;
    procedure AtualizarGrid;
    procedure AtualizarGridCEP(AEndereco: TEnderecoModel);
    procedure InserirCdsEndereco(AEndereco: TEnderecoModel);
  public
    { Public declarations }
  end;

var
  TesteViaCeEPForm: TTesteViaCeEPForm;

implementation

uses
  Teste.Connection.Factory, Teste.ViaCEP.Service;

{$R *.dfm}

function TTesteViaCeEPForm.AtualizarEndereco: Boolean;
begin
  Result :=  MessageDlg('Endereço encontrado na base!'+ sLineBreak +'Deseja executar uma nova consulta para atualizar?',
               TMsgDlgType.mtConfirmation, mbYesNo, 0) = mrYes;
end;

procedure TTesteViaCeEPForm.AtualizarGrid;
var
  Lista: TObjectList<TEnderecoModel>;
  lEndereco: TEnderecoModel;
begin

  CdsEnderecos.DisableControls;
  try
    CdsEnderecos.EmptyDataSet;
    Lista := FEnderecoController.ListarEnderecos;
    try
      for LEndereco in Lista do
      begin
        InserirCdsEndereco(LEndereco);
      end;
    finally
      Lista.Free;
    end;

  finally
    CdsEnderecos.EnableControls;
  end;
end;

procedure TTesteViaCeEPForm.AtualizarGridCEP(AEndereco: TEnderecoModel);
begin
  CdsEnderecos.DisableControls;
  try
    CdsEnderecos.EmptyDataSet;
    InserirCdsEndereco(AEndereco);
  finally
    CdsEnderecos.EnableControls;
  end;
end;

procedure TTesteViaCeEPForm.ConsultarButtonClick(Sender: TObject);
begin
  AtualizarGrid;
end;

procedure TTesteViaCeEPForm.ExecutarCepButtonClick(Sender: TObject);
var
  lEndereco: TEnderecoModel;
  lCEP: String;
begin
  lCEP := StringReplace(CepEdit.Text, '-', EmptyStr, [rfReplaceAll, rfIgnoreCase]);;

  lEndereco := FEnderecoController.ListarPorCEP(lCEP);
  try

    if Assigned(lEndereco) then
    begin
      if AtualizarEndereco then
      begin
        lEndereco := TViaCEPService.ConsultarPorCEP(lCEP, TViaCEPFormato(FormatoComboBox.ItemIndex));
        try
          FEnderecoController.Salvar(lEndereco);
          Memo.Lines.Clear;
          Memo.Lines.Add( lEndereco.toString );
          Abort;
        except
          raise Exception.Create('Erro ao atualizar endereço');
        end;
      end
      else
      begin
        AtualizarGridCEP(lEndereco);
        PageControl.ActivePage := TSListarEnderecos;
      end;
    end;

    lEndereco := TViaCEPService.ConsultarPorCEP(lCEP, TViaCEPFormato(FormatoComboBox.ItemIndex));
    try
      FEnderecoController.Salvar(lEndereco);
      Memo.Lines.Clear;
      Memo.Lines.Add( lEndereco.toString );
    except
      raise Exception.Create('Erro ao salvar endereço');
    end;

  finally
    lEndereco.Free;
  end;
end;

procedure TTesteViaCeEPForm.ExecutarEnderecoButtonClick(Sender: TObject);
var
  lEndereco: TEnderecoModel;
  lListaEnderecos: TObjectList<TEnderecoModel>;
begin
  lListaEnderecos := TViaCEPService.ConsultarPorEndereco(EditUF.Text, EditCidade.Text, EditLogradouro.Text,
                       TViaCEPFormato(FormatoComboBox.ItemIndex) );
  try
    Memo.Lines.Clear;
    for lEndereco in lListaEnderecos do
    begin

      try
        FEnderecoController.Salvar(lEndereco);
      except
        raise Exception.Create('Erro ao salvar endereço');
      end;

      Memo.Lines.Add( lEndereco.toString );
      Memo.Lines.Add('<---------------->');
    end;
  finally
    lListaEnderecos.Free;
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

procedure TTesteViaCeEPForm.InserirCdsEndereco(AEndereco: TEnderecoModel);
begin
  CdsEnderecos.Append;
  CdsEnderecos.FieldByName('id').AsInteger := AEndereco.Id;
  CdsEnderecos.FieldByName('cep').AsString := AEndereco.Cep;
  CdsEnderecos.FieldByName('logradouro').AsString := AEndereco.Logradouro;
  CdsEnderecos.FieldByName('complemento').AsString := AEndereco.Complemento;
  CdsEnderecos.FieldByName('bairro').AsString := AEndereco.Bairro;
  CdsEnderecos.FieldByName('cidade').AsString := AEndereco.Localidade;
  CdsEnderecos.FieldByName('uf').AsString := AEndereco.Estado;
  CdsEnderecos.Post;
end;

end.
