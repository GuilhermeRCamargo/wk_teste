unit cPedido;

interface

uses mPedido;

type
  TPedidoController = class
  public
    class function Salvar(const APedido: TPedido): boolean;
  end;

implementation

{ TPedidoController }

uses dPedido, System.Classes, SysUtils, Vcl.Forms, Winapi.Windows;

class function TPedidoController.Salvar(const APedido: TPedido): boolean;
  function Validar: boolean;
  var sl: TStringList;
      s: string;
      i: integer;
  begin
    try
      sl:= TStringList.Create;
      try
        if APedido.Cliente.Codigo <= 0 then
          sl.Add('Cliente não informado.');
        if APedido.Items.Count = 0 then
          sl.Add('Nenhum item informado');
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
begin
  try
    if Validar then
      result:= TPedidoDAO.Salvar(APedido);
  except
    on e: exception do
      raise Exception.Create('[Salvar]'+e.Message);
  end;

end;

end.
