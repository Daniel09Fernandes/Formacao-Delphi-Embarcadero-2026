object DMConnection: TDMConnection
  Height = 275
  Width = 252
  object FDCon: TFDConnection
    Params.Strings = (
      
        'Database=D:\Fontes\Formacao-Delphi-Embarcadero-2026\Win32\Aula 3' +
        '\CadastroTemplente\db\CadTemplete.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 48
  end
  object QryRTTI: TFDQuery
    Connection = FDCon
    Left = 128
    Top = 48
  end
  object QryPersistencia: TFDQuery
    Connection = FDCon
    Transaction = FDTransaction1
    Left = 64
    Top = 112
  end
  object FDTransaction1: TFDTransaction
    Connection = FDCon
    Left = 64
    Top = 176
  end
end
