object DataModule1: TDataModule1
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Projects\SrPolezi\Formacao-Delphi-Embarcadero-2026\E' +
        'ssentials\Aula_02\OFFTopicGenericsOrm\Database.db'
      'DriverID=SQLite')
    Left = 32
    Top = 32
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 128
    Top = 32
  end
end
