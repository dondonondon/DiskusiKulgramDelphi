object DM: TDM
  Height = 420
  Width = 526
  object Con: TSSQLConnection
    TunnelUrl = 'https://blangkonesia.xyz/entunnel.php'
    Token = '53713'
    Host = 'localhost'
    User = 'didikulgram'
    Password = 'didikulgram'
    Database = 'didi_1'
    Left = 80
    Top = 32
  end
  object QProduct: TK2SQL
    MemDataSet = memProduct
    Connection = Con
    Left = 128
    Top = 136
  end
  object memProduct: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 248
    Top = 160
  end
end
