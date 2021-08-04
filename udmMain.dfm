object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 169
  Width = 240
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=root'
      'DriverID=MySQL')
    Left = 56
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 152
    Top = 56
  end
end
