unit vGetCodigoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TFrmGetCodigoPedido = class(TForm)
    edtNumero: TEdit;
    Label1: TLabel;
    butConfirmar: TSpeedButton;
    procedure butConfirmarClick(Sender: TObject);
    procedure edtNumeroKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGetCodigoPedido: TFrmGetCodigoPedido;
  GetNumeroPedidoResult: integer;
  function GetNumeroPedido(): integer;

implementation

{$R *.dfm}

{Global}
function GetNumeroPedido(): integer;
begin
  try
    if ASsigned(FrmGetCodigoPedido) then
      FreeANdNil(FrmGetCodigoPedido);
    FrmGetCodigoPedido:= TFrmGetCodigoPedido.Create(Application);
    if FrmGetCodigoPedido.ShowModal = mrOk then
      result:= GetNumeroPedidoResult
    else
      result:= 0;

  except
    on e: exception do
      raise Exception.Create('[GetCodigoPedido]'+e.Message);
  end;
end;

{TFrmGetCodigoPedido}

procedure TFrmGetCodigoPedido.butConfirmarClick(Sender: TObject);
begin
  GetNumeroPedidoResult:= StrToIntDef(edtNumero.Text, 0);
  ModalResult:= mrOk;
end;

procedure TFrmGetCodigoPedido.edtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    butConfirmarClick(edtNumero);
end;

end.
