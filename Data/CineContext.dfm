object HistoricoDataModule: THistoricoDataModule
  Height = 480
  Width = 640
  object HistoricoTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 152
    Top = 80
  end
  object FConexao: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Left = 352
    Top = 280
  end
  object FHistoricoTable: TFDTable
    Connection = FConexao
    Left = 184
    Top = 248
  end
end
