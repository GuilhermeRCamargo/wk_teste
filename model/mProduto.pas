unit mProduto;

interface

type
  TProduto = class
  strict private
    fCodigo: integer;
    fDescricao: string;
    fPrecoVenda: Double;
  public
    constructor Create;
    property Codigo: integer read fCodigo write fCodigo;
    property Descricao: string read fDescricao write fDescricao;
    property PrecoVenda: Double read fPrecoVenda write fPrecoVenda;
  end;

implementation

uses System.SysUtils, udmMain, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

{ TProduto }

constructor TProduto.Create;
begin
  try
    fCodigo:= 0;
    fPrecoVenda:= 0;
  except
    on e: exception do
      raise Exception.Create('[Create]'+e.Message);
  end;

end;



end.
