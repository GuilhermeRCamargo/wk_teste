unit vConfigBD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, mConfigBD,
  udmMain;

type
  TFrmConfigBD = class(TForm)
    edtUsuario: TEdit;
    lblUsuario: TLabel;
    lblPorta: TLabel;
    edtPorta: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    butSalvar: TSpeedButton;
    butTestar: TSpeedButton;
    edtHost: TEdit;
    lblHost: TLabel;
    procedure butSalvarClick(Sender: TObject);
    procedure butTestarClick(Sender: TObject);
  strict private
    fConfigBD: TConfigBD;
    procedure RefreshUI;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  FrmConfigBD: TFrmConfigBD;

implementation

{$R *.dfm}


{ TFrmConfigBD }

constructor TFrmConfigBD.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  try
    fConfigBD:= TConfigBD.Create;
    fConfigBD.CarregarConfig;
    RefreshUI;
  except
    on e: exception do
      raise Exception.Create('[Create]'+e.Message);
  end;
end;

procedure TFrmConfigBD.RefreshUI;
begin
  try
    edtHost.Text:= fConfigBD.Host;
    edtPorta.Text:= IntToStr(fConfigBD.Porta);
    edtUsuario.Text:= fConfigBD.Usuario;
    edtSenha.Text:= fConfigBD.Senha;
  except
    on e: exception do
      raise Exception.Create('[RefreshUI]'+e.Message);
  end;
end;

procedure TFrmConfigBD.butTestarClick(Sender: TObject);
begin
  try
    if dmMain.Conectar(fConfigBD) then
      Application.MessageBox('Conectado!', 'WK', mb_ok+mb_iconinformation)
    else
      Application.MessageBox('Não foi possível conectar.', 'WK', mb_ok+mb_iconinformation);
  except
    on e: exception do
      raise Exception.Create('[butTestarClick]'+e.Message);
  end;
end;

procedure TFrmConfigBD.butSalvarClick(Sender: TObject);
begin
  try
    fConfigBD.Porta:= StrToIntDef(edtPorta.Text, 0);
    fConfigBD.Host:= edtHost.Text;
    fConfigBD.Usuario:= edtUsuario.Text;
    fConfigBD.Senha:= edtSenha.Text;
    fConfigBD.SalvarConfig;
    Application.MessageBox('Configurações salvas com sucesso!', 'WK', mb_ok+mb_iconinformation);
  except
    on e: exception do
      raise Exception.Create('[butSalvarClick]'+e.Message);
  end;
end;

end.
