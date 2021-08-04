unit mPedido;

interface

uses System.Generics.Collections, System.SysUtils, mProduto, mCliente, System.Classes,
 Vcl.Forms, Winapi.Windows;

type
  TPedidoItem = class
  strict private
    fCodigo: integer;
    fProduto: TProduto;
    fQuantidade: Double;
    fValorUnitario: Double;
    function GetTotal: Double;
  public
    constructor Create;
    destructor Destroy;
    function ValidarNovoItem: boolean;
    property Codigo: integer read fCodigo write fCodigo;
    property Produto: TProduto read fProduto write fProduto;
    property Quantidade: Double read fQuantidade write fQuantidade;
    property ValorUnitario: Double read fValorUnitario write fValorUnitario;
    property Total: Double read GetTotal;
  end;

  TPedidoItems = class(TObjectList<TPedidoItem>);

  TPedido = class
  strict private
    fNumero: integer;
    fCliente: TCliente;
    fEmissao: TDateTime;
    fItems: TPedidoItems;
    function GetTotal: Double;
  public
    constructor Create;
    destructor Destroy;
    property Numero: integer read fNumero write fNumero;
    property Cliente: TCliente read fCliente write fCliente;
    property Emissao: TDateTime read fEmissao write fEmissao;
    property Items: TPedidoItems read fItems write fItems;
    property Total: Double read GetTotal;
  end;


implementation

{ TPedidoItem }

uses udmMain;

constructor TPedidoItem.Create;
begin
  try
    fCodigo:= 0;
    fProduto:= TProduto.Create;
    fQuantidade:= 0;
    fValorUnitario:= 0;
  except
    on e: exception do
      raise Exception.Create('[Create]'+e.Message);
  end;
end;

destructor TPedidoItem.Destroy;
begin
  FreeAndNil(fProduto);
end;

function TPedidoItem.GetTotal: Double;
begin
  result:= Self.Quantidade*Self.ValorUnitario;
end;

function TPedidoItem.ValidarNovoItem: boolean;
var sl: TStringList;
    s: string;
    i: integer;
begin
  try
    sl:= TStringList.Create;
    try
      if Self.Produto.Codigo <= 0 then
        sl.Add('Produto não informado.');
      if Self.Quantidade <= 0 then
        sl.Add('Quantidade não informada ou inválida.');
      if Self.ValorUnitario <= 0 then
        sl.Add('Valor Unitário não informado ou inválido.');
      result:= sl.Count = 0;
      if not (result) then
      begin
        s:= IntTostr(sl.Count)+' erro(s) impede(m) a continuidade do processo:'+#13;
        for i:= 0 to Pred(sl.Count) do
          s:= s+#13+IntToStr(i+1)+'. '+sl[i];
        Application.MessageBox(PWideChar(s), 'WK', mb_ok+mb_iconinformation);
      end;
    finally
      FReeANdNil(sl);
    end;
  except
    on e: exception do
      raise Exception.Create('[Validar]'+e.Message);
  end;
end;

{ TPedido }



constructor TPedido.Create;
begin
  try
    fNumero:= 0;
    fEmissao:= 0;
    fCliente:= TCliente.Create;
    fItems:= TPedidoItems.Create;
  except
    on e: exception do
      raise Exception.Create('[Create]'+e.Message);
  end;
end;

destructor TPedido.Destroy;
begin
  FreeAndNil(fCliente);
  FreeAndNil(fItems);
end;

function TPedido.GetTotal: Double;
var AItem: TPedidoItem;
begin
  try
    result:= 0;
    for AItem in Self.Items do
      result:= result+AItem.Total;
  except
    on e: exception do
      raise Exception.Create('[GetTotal]'+e.Message);
  end;
end;


end.
