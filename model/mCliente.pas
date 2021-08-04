unit mCliente;

interface

type
  TCliente = class
  strict private
    fCodigo: integer;
    fNome: string;
    fCidade: string;
    fUF: string;
  public
    constructor Create;
    property Codigo: integer read fCodigo write fCodigo;
    property Nome: string read fNome write fNome;
    property Cidade: string read fCidade write fCidade;
    property UF: string read fUF write fUF;
  end;

implementation

{ TCliente }

uses udmMain, System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

constructor TCliente.Create;
begin
  try
    fCodigo:= 0;
  except
    on e: exception do
      raise Exception.Create('[Create]'+e.Message);
  end;
end;


end.
