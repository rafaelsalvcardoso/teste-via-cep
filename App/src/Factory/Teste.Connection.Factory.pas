unit Teste.Connection.Factory;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client;

type
  TConnectionFactory = class
  private
    class var FConnection: TFDConnection;

    procedure ConfigureConnection;

    constructor Create;
    destructor Destroy; override;
 public
    function GetConnection: TFDConnection;

    class function CreatePostgreConnection(const AHost, APort, AUser, APassword, ADatabase: string): TFDConnection;
    class function New: TConnectionFactory;
  end;

implementation

procedure TConnectionFactory.ConfigureConnection;
begin
  try
    FConnection.ConnectionName := 'ConnectionObj';
    FConnection.DriverName := 'MSSQL';
    FConnection.LoginPrompt := False;
    FConnection.Connected := False;
    FConnection.Params.Values['DataBase'] := 'TesteDB';
    FConnection.Params.Values['User_Name'] := 'sa';
    FConnection.Params.Values['Password'] := 'SuperPassword@25';
    FConnection.Params.Values['Server'] := 'localhost';
    FConnection.Params.Values['DriverID'] := 'MSSQL';
    FConnection.Connected := True;
  except
    raise Exception.Create('Erro ao conectar o banco de dados!');
  end;
end;

constructor TConnectionFactory.Create;
begin
  FConnection := TFDConnection.Create(nil);
  ConfigureConnection;
end;

class function TConnectionFactory.CreatePostgreConnection(const AHost, APort, AUser, APassword, ADatabase: string): TFDConnection;
var
  Conn: TFDConnection;
begin
  Conn := TFDConnection.Create(nil);
  Conn.LoginPrompt := False;
  Conn.DriverName := 'PG';
  Conn.Params.DriverID := 'PG';
  Conn.Params.Database := ADatabase;
  Conn.Params.UserName := AUser;
  Conn.Params.Password := APassword;
  Conn.Params.Add('Server=' + AHost);
  Conn.Params.Add('Port=' + APort);
  Conn.Connected := True;
  Result := Conn;
end;

destructor TConnectionFactory.Destroy;
begin
  FConnection.Free;
  inherited;
end;

function TConnectionFactory.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

class function TConnectionFactory.New: TConnectionFactory;
begin
  Result := Self.Create;
end;

end.

