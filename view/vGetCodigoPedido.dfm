object FrmGetCodigoPedido: TFrmGetCodigoPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Informe o N'#250'mero do Pedido'
  ClientHeight = 67
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 12
    Width = 45
    Height = 16
    Caption = 'N'#250'mero'
  end
  object butConfirmar: TSpeedButton
    Left = 136
    Top = 12
    Width = 121
    Height = 42
    Caption = 'Confirmar (Enter)'
    OnClick = butConfirmarClick
  end
  object edtNumero: TEdit
    Left = 16
    Top = 30
    Width = 105
    Height = 24
    NumbersOnly = True
    TabOrder = 0
    OnKeyPress = edtNumeroKeyPress
  end
end
