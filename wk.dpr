program wk;

uses
  Vcl.Forms,
  vMain in 'view\vMain.pas' {FrmMain},
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  mConfigBD in 'model\mConfigBD.pas',
  vConfigBD in 'view\vConfigBD.pas' {FrmConfigBD},
  mCliente in 'model\mCliente.pas',
  mProduto in 'model\mProduto.pas',
  mPedido in 'model\mPedido.pas',
  cPedido in 'controller\cPedido.pas',
  dPedido in 'dao\dPedido.pas',
  vGetCodigoPedido in 'view\vGetCodigoPedido.pas' {FrmGetCodigoPedido},
  dCliente in 'dao\dCliente.pas',
  dProduto in 'dao\dProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
