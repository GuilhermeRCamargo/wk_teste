unit dCliente;

interface

uses mCliente;
type
  TClienteDAO = class
  public
    class function Carregar(const ACodigo: integer): TCliente;
  end;
implementation

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, udmMain, System.SysUtils;

class function TClienteDAO.Carregar(const ACodigo: integer): TCliente;
var Qry: TFDQuery;
begin
  Qry:= dmMain.GetQuery;
  try
    try
      result:= TCliente.Create;
      with Qry, sql do
      begin
        Clear;
        add('SELECT nome, cidade, uf FROM tb_cliente WHERE codigo = :codigo');
        ParamByName('codigo').AsInteger:= ACodigo;
        Open;
        if RecordCount > 0 then
        begin
          result.Codigo:= ACodigo;
          result.Nome:= FieldByName('nome').AsString;
          result.Cidade:= FieldByName('cidade').AsString;
          result.UF:= FieldByName('uf').AsString;
        end;
      end;
    except
      on e: exception do
        raise Exception.Create('[Carregar]'+e.Message);
    end;
  finally
    FreeAndNil(Qry);
  end;
end;


end.
