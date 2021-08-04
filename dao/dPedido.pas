unit dPedido;

interface

uses mPedido;

type
  TPedidoDAO = class
  public
    class function Carregar(const ANumero: integer): TPedido;
    class function Excluir(const ANumero: integer): boolean;
    class function PedidoExiste(const ANumero: integer): boolean;
    class function Salvar(const APedido: TPedido): boolean;
  end;

implementation

uses FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, udmMain, System.SysUtils;

{ TPedidoDAO }

class function TPedidoDAO.Carregar(const ANumero: integer): TPedido;
var Qry: TFDQuery;
begin
  result:= TPedido.Create;
  Qry:= dmMain.GetQuery;
  try
    try
      with Qry, sql do
      begin
        Clear;
        add('SELECT tb_pedido.numero, tb_pedido.data_emissao,');
        add('tb_pedido.codigo_cliente, tb_cliente.nome AS cliente_nome,');
        add('tb_cliente.cidade AS cliente_cidade, tb_cliente.uf AS cliente_uf');
        add('FROM tb_pedido');
        add('JOIN tb_cliente ON tb_cliente.codigo = tb_pedido.codigo_cliente');
        add('WHERE tb_pedido.numero = :numero');
        ParamByName('numero').AsInteger:= ANumero;
        Open;
        if RecordCount > 0 then
        begin
          Result.Numero:= FieldByName('numero').AsInteger;
          Result.Emissao:= FieldByName('data_emissao').AsDaTeTime;
          Result.Cliente.Codigo:= FieldByName('codigo_cliente').AsInteger;
          Result.Cliente.Nome:= FieldByName('cliente_nome').ASString;
          Result.Cliente.Cidade:= FieldByName('cliente_cidade').ASString;
          Result.Cliente.UF:= FieldByName('cliente_uf').ASString;
          Clear;
          add('SELECT tb_pedido_item.codigo, tb_pedido_item.codigo_produto,');
          add('tb_pedido_item.quantidade, tb_pedido_item.valor_unitario,');
          add('tb_produto.descricao AS produto_descricao');
          add('FROM tb_pedido_item');
          add('JOIN tb_produto ON tb_produto.codigo = tb_pedido_item.codigo_produto');
          add('WHERE tb_pedido_item.numero_pedido = :numero_pedido');
          ParamByName('numero_pedido').AsInteger:= ANumero;
          Open;
          while not (Eof) do
          begin
            Result.Items.Add(TPedidoItem.Create);
            Result.Items.Last.Codigo:= FieldByName('codigo').AsInteger;
            Result.Items.Last.Produto.Codigo:= FieldByName('codigo_produto').ASInteger;
            Result.Items.Last.Produto.Descricao:= FieldByName('produto_descricao').AsString;
            Result.Items.Last.Quantidade:= FieldByName('quantidade').AsFloat;
            Result.Items.Last.ValorUnitario:= FieldByName('valor_unitario').AsFloat;
            Qry.Next;
          end;
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

class function TPedidoDAO.Excluir(const ANumero: integer): boolean;
var Qry: TFDQuery;
begin
  result:= False;
  if ANumero > 0 then
  begin
    Qry:= dmMain.GetQuery;
    dmMain.FDConnection1.StartTransaction;
    try
      try
        with Qry, sql do
        begin
          Clear;
          add('DELETE FROM tb_pedido_item WHERE numero_pedido = :numero_pedido');
          ParamByName('numero_pedido').AsInteger:= ANumero;
          ExecSQL;
          Clear;
          add('DELETE FROM tb_pedido WHERE numero = :numero');
          ParamByName('numero').AsInteger:= ANumero;
          ExecSQL;
          dmMain.FDConnection1.Commit;
          result:= True;
        end;
      except
        on e: exception do
        begin
          if dmMain.FDConnection1.InTransaction then
            dmMain.FDConnection1.Rollback;
          raise Exception.Create('[Excluir]'+e.Message);
        end;
      end;
    finally
      FreeAndNil(Qry);
    end;
  end;
end;

class function TPedidoDAO.PedidoExiste(const ANumero: integer): boolean;
var Qry: TFDQuery;
begin
  result:= False;
  if ANumero > 0 then
  begin
    Qry:= dmMain.GetQuery;
    try
      try
        with Qry, sql do
        begin
          Clear;
          add('SELECT 1 FROM tb_pedido WHERE numero = :numero');
          ParamByName('numero').AsInteger:= ANumero;
          Open;
          result:= RecordCOunt > 0;
        end;
      except
        on e: exception do
          raise Exception.Create('[PedidoExiste]'+e.Message);
      end;
    finally
      FreeAndNil(Qry);
    end;
  end;
end;

class function TPedidoDAO.Salvar(const APedido: TPedido): boolean;
var Qry: TFDQuery;
    AItem: TPedidoItem;
begin
  result:= False;
  Qry:= dmMain.GetQuery;
  dmMain.FDConnection1.StartTransaction;
  try
    try
      with Qry, sql do
      begin
        if APedido.Numero <= 0 then
        begin
          Clear;
          add('INSERT INTO tb_pedido (data_emissao, codigo_cliente, valor_total)');
          add('VALUES (NOW(), :codigo_cliente, :valor_total)');
        end
        else
        begin
          Clear;
          add('UPDATE tb_pedido SET codigo_cliente = :codigo_cliente,');
          add('valor_total = :valor_total');
          Add('WHERE numero = :numero');
          ParamByName('numero').AsInteger:= APedido.Numero;
        end;
        ParamByName('codigo_cliente').AsInteger:= APedido.Cliente.Codigo;
        ParamByName('valor_total').AsFloat:= APedido.Total;
        ExecSQL;
        if APedido.Numero <= 0 then
        begin
          Clear;
          Add('SELECT LAST_INSERT_ID() AS numero;');
          Open;
          APedido.Numero:= FieldByName('numero').AsInteger;
        end
        else
        begin
          Clear;
          add('DELETE FROM tb_pedido_item WHERE numero_pedido = :numero_pedido');
          ParamByName('numero_pedido').AsInteger:= APedido.Numero;
          ExecSQL;
        end;
        for AItem in APedido.Items do
        begin
          Clear;
          add('INSERT INTO tb_pedido_item (numero_pedido, codigo_produto,');
          add('quantidade, valor_unitario, valor_total)');
          add('VALUES (:numero_pedido, :codigo_produto,');
          add(':quantidade, :valor_unitario, :valor_total)');
          ParamByName('numero_pedido').AsInteger:= APedido.Numero;
          ParamByName('codigo_produto').AsInteger:= AItem.Produto.Codigo;
          ParamByName('quantidade').AsFloat:= AItem.Quantidade;
          ParamByName('valor_unitario').AsFloat:= AItem.ValorUnitario;
          ParamByName('valor_total').AsFloat:= AItem.Total;
          ExecSQL;
        end;
        dmMain.FDConnection1.Commit;
        result:= True;
      end;
    except
      on e: exception do
      begin
        if dmMain.FDConnection1.InTransaction then
          dmMain.FDConnection1.Rollback;
        raise Exception.Create('[Salvar]'+e.Message);
      end;
    end;
  finally
    FreeAndNil(Qry);
  end;
end;

end.
