unit mConfigBD;

interface

uses System.SysUtils;

type
  TConfigBD = class
  strict private
    fHost: string;
    fPorta: Word;
    fSenha: string;
    fUsuario: string;
    const CONFIG_INI_FILENAME: string = 'config.ini';
    const INI_BD_SECTION: string = 'BD';
    function GetIniFileName: string;
  public
    constructor Create;
    procedure SalvarConfig;
    procedure CarregarConfig;
    property Host: string read fHost write fHost;
    property Porta: Word read fPorta write fPorta;
    property Senha: string read fSenha write fSenha;
    property Usuario: string read fUsuario write fUsuario;
  end;

implementation

uses IniFiles;

{ TConfigBD }

procedure TConfigBD.CarregarConfig;
var AIni: TIniFile;
    AFileName: string;
begin
  try
    AFileName:= GetIniFileName;
    if FileExists(AFileName) then
    begin
      AIni := TIniFile.Create(AFileName);
      try
        Self.Porta:= AIni.ReadInteger(INI_BD_SECTION, 'Porta', 3306);
        Self.Host:= AIni.ReadString(INI_BD_SECTION, 'Host', '127.0.0.1');
        Self.Senha:= AIni.ReadString(INI_BD_SECTION, 'Senha', '');
        Self.Usuario:= AIni.ReadString(INI_BD_SECTION, 'Usuario', '');
      finally
        FreeAndNil(AIni);
      end;
    end;
  except
    on e: exception do
      raise Exception.Create('[SalvarConfig]'+e.Message);
  end;
end;

constructor TConfigBD.Create;
begin
  fPorta:= 0;
end;

function TConfigBD.GetIniFileName: string;
begin
  try
    result:= ExtractFilePath(ParamStr(0))+CONFIG_INI_FILENAME;
  except
    on e: exception do
      raise Exception.Create('[GetIniFileName]'+e.Message);
  end;
end;

procedure TConfigBD.SalvarConfig;
var AIni: TIniFile;
begin
  try
    AIni := TIniFile.Create(GetIniFileName);
    try
      AIni.WriteInteger(INI_BD_SECTION, 'Porta', Self.Porta);
      AIni.WriteString(INI_BD_SECTION, 'Host', Self.Host);
      AIni.WriteString(INI_BD_SECTION, 'Senha', Self.Senha);
      AIni.WriteString(INI_BD_SECTION, 'Usuario', Self.Usuario);
    finally
      FreeAndNil(AIni);
    end;
  except
    on e: exception do
      raise Exception.Create('[SalvarConfig]'+e.Message);
  end;
end;

end.
