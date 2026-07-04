object ClientesResource1: TClientesResource1
  Height = 300
  Width = 600
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=D:\Fontes\Formacao-Delphi-Embarcadero-2026\Datasnap\Aul' +
        'a 3\RadServer\db\CadTemplete.db'
      'ConnectionDef=SQLite_Demo')
    Connected = True
    LoginPrompt = False
    Left = 30
    Top = 16
  end
  object qryClientes: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from tab_clientes')
    Left = 130
    Top = 16
  end
  object dsClientes: TEMSDataSetResource
    AllowedActions = [List, Get, Post, Put, Delete]
    DataSet = qryClientes
    Left = 130
    Top = 64
  end
end
