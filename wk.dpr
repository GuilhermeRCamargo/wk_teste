program wk;

uses
  Vcl.Forms,
  vMain in 'view\vMain.pas' {FrmMain},
  udmMain in 'udmMain.pas' {dmMain: TDataModule},
  mConfigBD in 'model\mConfigBD.pas',
  vConfigBD in 'view\vConfigBD.pas' {FrmConfigBD};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
end.
