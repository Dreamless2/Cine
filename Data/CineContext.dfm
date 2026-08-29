object DataModule1: TDataModule1
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
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 368
    Top = 304
  end
end
