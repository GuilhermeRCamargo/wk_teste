unit dProduto;

interface

uses mProduto;

type
  TProdutoDAO = class
  public
    class function Carregar(const ACodigo: integer): TProduto;
  end;

implementation

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, udmMain, System.SysUtils;

class function TProdutoDAO.Carregar(const ACodigo: integer): TProduto;
var Qry: TFDQuery;
begin
  Qry:= dmMain.GetQuery;
  try
    try
      result:= TProduto.Create;
      with Qry, sql do
      begin
        Clear;
        add('SELECT descricao, preco_venda FROM tb_produto WHERE codigo = :codigo');
        ParamByName('codigo').AsInteger:= ACodigo;
        Open;
        if RecordCount > 0 then
        begin
          result.Codigo:= ACodigo;
          result.Descricao:= FieldByName('descricao').AsString;
          result.PrecoVenda:= FieldByName('preco_venda').AsFloat;
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
