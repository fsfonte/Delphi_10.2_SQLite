object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 251
  Width = 346
  object FDConnection: TFDConnection
    Params.Strings = (
      
        'Database=d:\Users\Fernando\Desktop\Delphi_10.2_SQLite\ProdutosDe' +
        'lphi.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 88
    Top = 8
  end
  object FDQuery_Categoria: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM Categoria')
    Left = 168
    Top = 8
  end
  object FDQuery_Produtos: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM Produtos')
    Left = 272
    Top = 8
    object FDQuery_ProdutosCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQuery_ProdutosDescricao: TWideStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Size = 50
    end
    object FDQuery_ProdutosPrecoCusto: TFloatField
      FieldName = 'PrecoCusto'
      Origin = 'PrecoCusto'
      currency = True
    end
    object FDQuery_ProdutosPrecoVenda: TFloatField
      FieldName = 'PrecoVenda'
      Origin = 'PrecoVenda'
      currency = True
    end
    object FDQuery_ProdutosCodigoCategoria: TIntegerField
      FieldName = 'CodigoCategoria'
      Origin = 'CodigoCategoria'
    end
  end
end
