object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 230
  Width = 505
  object FdConn: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Left = 16
    Top = 16
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 168
    Top = 16
  end
  object FDQueryInsert: TFDQuery
    Connection = FdConn
    SQL.Strings = (
      
        '     INSERT INTO CEP (CEP, RUA, CIDADE, BAIRRO, ESTADO) VALUES (' +
        ':CEP, :RUA, :CIDADE, :BAIRRO, :ESTADO)')
    Left = 312
    Top = 16
    ParamData = <
      item
        Name = 'CEP'
        ParamType = ptInput
      end
      item
        Name = 'RUA'
        ParamType = ptInput
      end
      item
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        Name = 'BAIRRO'
        ParamType = ptInput
      end
      item
        Name = 'ESTADO'
        ParamType = ptInput
      end>
  end
end
