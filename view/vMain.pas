unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons;

type
  TFrmMain = class(TForm)
    butConfigBD: TSpeedButton;
    procedure butConfigBDClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses vConfigBD;

procedure TFrmMain.butConfigBDClick(Sender: TObject);
begin
  try
    if Assigned(FrmConfigBD) then
      FreeAndNil(FrmConfigBD);
    FrmConfigBD:= TFrmConfigBD.Create(Application);
    FrmConfigBD.ShowModal;
  except
    on e: exception do
      raise Exception.Create('[butConfigBDClick]'+e.Message);
  end;
end;

end.
