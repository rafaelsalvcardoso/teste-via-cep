program TesteViaCEP;

uses
  Vcl.Forms,
  Teste.Principal.View in 'src\View\Teste.Principal.View.pas' {TesteViaCeEPForm},
  Teste.Endereco.Model in 'src\Model\Teste.Endereco.Model.pas',
  Teste.Endereco.DAO in 'src\DAO\Teste.Endereco.DAO.pas',
  Teste.Endereco.Interfaces.DAO in 'src\DAO\Teste.Endereco.Interfaces.DAO.pas',
  Teste.Endereco.Controller in 'src\Controller\Teste.Endereco.Controller.pas',
  Teste.Endereco.Interfaces.Controller in 'src\Controller\Teste.Endereco.Interfaces.Controller.pas',
  Teste.Connection.Factory in 'src\Factory\Teste.Connection.Factory.pas',
  Teste.ViaCEP.Interfaces in 'src\Service\Teste.ViaCEP.Interfaces.pas',
  Teste.ViaCEP.Parse.Json in 'src\Service\Teste.ViaCEP.Parse.Json.pas',
  Teste.ViaCEP.Parse.XML in 'src\Service\Teste.ViaCEP.Parse.XML.pas',
  Teste.ViaCEP.Context in 'src\Service\Teste.ViaCEP.Context.pas',
  Teste.ViaCEP.Service in 'src\Service\Teste.ViaCEP.Service.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTesteViaCeEPForm, TesteViaCeEPForm);
  Application.Run;
end.
