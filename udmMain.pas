unit udmMain;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  mConfigBD;

type
  TdmMain = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
  strict private
    const DATABASE_NAME: string = 'wk_test';
  public
    function Conectar(AConfigBD: TConfigBD = nil): boolean;
  end;

var
  dmMain: TdmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmMain }

function TdmMain.Conectar(AConfigBD: TConfigBD): boolean;
begin
  try
    result:= false;
    if FDConnection1.Connected then
      FDConnection1.Connected:= false;
    with FDConnection1.Params do
    begin
      Clear;
      Add('DriverID=MySQL');
      Add('Server='+AConfigBD.Host);
      Add('Port='+IntToStr(AConfigBD.Porta));
      Add('Database='+DATABASE_NAME);
      Add('User_Name='+AConfigBD.Usuario);
      Add('Password='+AConfigBD.Senha);
      FDConnection1.Connected:= True;
      result:= FDConnection1.Connected;
    end;
  except
    on e: exception do
      raise Exception.Create('[Conectar]'+e.Message);
  end;
end;

end.
