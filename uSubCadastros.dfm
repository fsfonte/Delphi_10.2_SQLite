object frmSubCadastros: TfrmSubCadastros
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Sub Cadastros'
  ClientHeight = 327
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox8: TGroupBox
    Left = 407
    Top = 8
    Width = 66
    Height = 243
    TabOrder = 1
    object btNovo: TButton
      Left = 11
      Top = 10
      Width = 45
      Height = 45
      Hint = 'Cria um novo registro'
      ImageAlignment = iaCenter
      ImageIndex = 3
      Images = frmPrincipal.botoesImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btNovoClick
    end
    object btSalvar: TButton
      Left = 11
      Top = 54
      Width = 45
      Height = 45
      Hint = 'Salva o registro atual'
      Enabled = False
      ImageAlignment = iaCenter
      ImageIndex = 5
      Images = frmPrincipal.botoesImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btSalvarClick
    end
    object brImprimir: TButton
      Left = 11
      Top = 142
      Width = 45
      Height = 45
      Hint = 'Imprime os dados do profissional'
      Enabled = False
      ImageAlignment = iaCenter
      ImageIndex = 7
      Images = frmPrincipal.botoesImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object btExcluir: TButton
      Left = 11
      Top = 186
      Width = 45
      Height = 45
      Hint = 'Exclui o registro atual'
      Enabled = False
      ImageAlignment = iaCenter
      ImageIndex = 8
      Images = frmPrincipal.botoesImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btExcluirClick
    end
    object btLimpar: TButton
      Left = 11
      Top = 98
      Width = 45
      Height = 45
      Hint = 'Limpa os campos para um novo registro ou consulta'
      Enabled = False
      ImageAlignment = iaCenter
      ImageIndex = 9
      Images = frmPrincipal.botoesImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btLimparClick
    end
  end
  object GroupBox9: TGroupBox
    Left = 407
    Top = 257
    Width = 66
    Height = 65
    TabOrder = 2
    object btSair: TButton
      Left = 11
      Top = 10
      Width = 45
      Height = 45
      Hint = 'Fecha a janela'
      ImageAlignment = iaCenter
      ImageIndex = 6
      Images = frmPrincipal.botoesImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btSairClick
    end
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 393
    Height = 314
    ActivePage = TabSheet1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'Dados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      object gbNome: TGroupBox
        Left = 74
        Top = 3
        Width = 306
        Height = 65
        Enabled = False
        TabOrder = 0
        object Label2: TLabel
          Left = 11
          Top = 11
          Width = 58
          Height = 13
          Caption = 'Descri'#231#227'o:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtDescricao: TEdit
          Left = 11
          Top = 30
          Width = 284
          Height = 21
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
      object gbCodigo: TGroupBox
        Left = 3
        Top = 3
        Width = 65
        Height = 65
        TabOrder = 1
        object Label1: TLabel
          Left = 11
          Top = 11
          Width = 41
          Height = 13
          Caption = 'C'#243'digo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCodigo: TEdit
          Left = 11
          Top = 30
          Width = 41
          Height = 21
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 0
          OnExit = edtCodigoExit
          OnKeyPress = edtCodigoKeyPress
        end
      end
      object TGroupBox
        Left = 3
        Top = 74
        Width = 377
        Height = 206
        TabOrder = 2
        DesignSize = (
          377
          206)
        object gridCategoria: TDBGrid
          Left = 8
          Top = 8
          Width = 361
          Height = 188
          Hint = 'Clique 2 vezes em cima de um registro para alter'#225'-lo'
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsCategoria
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = [fsBold]
          OnDblClick = gridCategoriaDblClick
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Codigo'
              Title.Alignment = taCenter
              Title.Caption = 'C'#243'digo'
              Width = 45
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              Title.Alignment = taCenter
              Title.Caption = 'Descri'#231#227'o'
              Width = 280
              Visible = True
            end>
        end
      end
    end
  end
  object dsCategoria: TDataSource
    DataSet = DM.FDQuery_Categoria
    Left = 324
    Top = 282
  end
end
