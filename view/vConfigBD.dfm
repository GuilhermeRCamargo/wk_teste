object FrmConfigBD: TFrmConfigBD
  Left = 0
  Top = 0
  ActiveControl = edtHost
  BorderIcons = [biSystemMenu]
  Caption = 'Configura'#231#227'o do Banco de Dados MySQL'
  ClientHeight = 129
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblUsuario: TLabel
    Left = 7
    Top = 43
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object lblPorta: TLabel
    Left = 261
    Top = 5
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object lblSenha: TLabel
    Left = 158
    Top = 43
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object butSalvar: TSpeedButton
    Left = 47
    Top = 85
    Width = 105
    Height = 41
    Caption = 'Salvar'
    OnClick = butSalvarClick
  end
  object butConectar: TSpeedButton
    Left = 158
    Top = 85
    Width = 105
    Height = 41
    Caption = 'Conectar'
    OnClick = butConectarClick
  end
  object lblHost: TLabel
    Left = 7
    Top = 5
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object edtUsuario: TEdit
    Left = 7
    Top = 58
    Width = 145
    Height = 21
    TabOrder = 2
  end
  object edtPorta: TEdit
    Left = 261
    Top = 20
    Width = 41
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    Text = '3306'
  end
  object edtSenha: TEdit
    Left = 158
    Top = 58
    Width = 144
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object edtHost: TEdit
    Left = 7
    Top = 20
    Width = 248
    Height = 21
    TabOrder = 0
  end
end
