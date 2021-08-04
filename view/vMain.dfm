object FrmMain: TFrmMain
  Left = 0
  Top = 0
  ClientHeight = 487
  ClientWidth = 685
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Panel4: TPanel
    Left = 0
    Top = 224
    Width = 685
    Height = 214
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    TabStop = True
    OnEnter = Panel4Enter
    ExplicitTop = 249
    ExplicitHeight = 165
    object Label3: TLabel
      AlignWithMargins = True
      Left = 16
      Top = 8
      Width = 666
      Height = 16
      Margins.Left = 16
      Margins.Top = 8
      Align = alTop
      Caption = 'Itens'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 34
    end
    object DBGrid1: TDBGrid
      AlignWithMargins = True
      Left = 16
      Top = 35
      Width = 661
      Height = 149
      Margins.Left = 16
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alClient
      DataSource = dsItensPedido
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'cod_produto'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'd. Produto'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'desc_produto'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o'
          Width = 297
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Title.Alignment = taCenter
          Title.Caption = 'Qtde'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_unitario'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Un.'
          Width = 86
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'total'
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = 'Total'
          Width = 83
          Visible = True
        end>
    end
    object Panel5: TPanel
      Left = 0
      Top = 184
      Width = 685
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      ExplicitTop = 146
      ExplicitWidth = 690
      object lblTotalPedido: TLabel
        AlignWithMargins = True
        Left = 566
        Top = 3
        Width = 111
        Height = 24
        Margins.Left = 16
        Margins.Right = 8
        Align = alRight
        Alignment = taRightJustify
        Caption = 'Valor Total:  0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        ExplicitHeight = 16
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 57
    Width = 685
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    OnEnter = Panel1Enter
    DesignSize = (
      685
      85)
    object lblCodigo: TLabel
      Left = 17
      Top = 34
      Width = 39
      Height = 16
      Caption = 'C'#243'digo'
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 16
      Top = 8
      Width = 666
      Height = 16
      Margins.Left = 16
      Margins.Top = 8
      Align = alTop
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 17
      ExplicitTop = 9
      ExplicitWidth = 44
    end
    object Label2: TLabel
      Left = 95
      Top = 34
      Width = 33
      Height = 16
      Caption = 'Nome'
    end
    object Label1: TLabel
      Left = 483
      Top = 34
      Width = 67
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Cidade / UF'
    end
    object edtCodigoCliente: TEdit
      Left = 17
      Top = 52
      Width = 72
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnChange = edtCodigoClienteChange
      OnExit = edtCodigoClienteExit
    end
    object edtNomeCliente: TEdit
      Left = 95
      Top = 52
      Width = 382
      Height = 24
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 1
    end
    object edtCidadeUFCliente: TEdit
      Left = 483
      Top = 52
      Width = 194
      Height = 24
      TabStop = False
      Anchors = [akTop, akRight]
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 2
    end
  end
  object pnlProduto: TPanel
    Left = 0
    Top = 142
    Width = 685
    Height = 82
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 3
    TabStop = True
    OnEnter = pnlProdutoEnter
    OnExit = pnlProdutoExit
    ExplicitTop = 145
    DesignSize = (
      685
      82)
    object Label6: TLabel
      Left = 17
      Top = 35
      Width = 39
      Height = 16
      Caption = 'C'#243'digo'
    end
    object lblProduto: TLabel
      AlignWithMargins = True
      Left = 16
      Top = 8
      Width = 666
      Height = 16
      Margins.Left = 16
      Margins.Top = 8
      Align = alTop
      Caption = 'Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 52
    end
    object Label8: TLabel
      Left = 375
      Top = 35
      Width = 65
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Quantidade'
    end
    object Label9: TLabel
      Left = 463
      Top = 35
      Width = 53
      Height = 16
      Anchors = [akTop, akRight]
      Caption = 'Valor Un.'
    end
    object Label10: TLabel
      Left = 95
      Top = 35
      Width = 55
      Height = 16
      Caption = 'Descri'#231#227'o'
    end
    object butSalvarItem: TSpeedButton
      Left = 551
      Top = 48
      Width = 126
      Height = 29
      Action = actSalvarItem
      Anchors = [akTop, akRight]
    end
    object edtValorUnitario: TEdit
      Left = 463
      Top = 53
      Width = 82
      Height = 24
      Anchors = [akTop, akRight]
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      TabOrder = 3
      OnExit = edtQuantidadeExit
    end
    object edtQuantidade: TEdit
      Left = 375
      Top = 53
      Width = 82
      Height = 24
      Anchors = [akTop, akRight]
      BiDiMode = bdRightToLeft
      ParentBiDiMode = False
      TabOrder = 2
      OnExit = edtQuantidadeExit
    end
    object edtCodProduto: TEdit
      Left = 17
      Top = 53
      Width = 72
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodProdutoExit
    end
    object edtDescProduto: TEdit
      Left = 95
      Top = 53
      Width = 274
      Height = 24
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 438
    Width = 685
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 0
    ExplicitWidth = 690
    DesignSize = (
      685
      49)
    object butGravarPedido: TSpeedButton
      Left = 16
      Top = 10
      Width = 133
      Height = 29
      Action = actGravarPedido
      Enabled = False
    end
    object butCarregarPedido: TSpeedButton
      Left = 155
      Top = 10
      Width = 134
      Height = 29
      Action = actCarregarPedido
    end
    object butCancelarPedido: TSpeedButton
      Left = 295
      Top = 10
      Width = 130
      Height = 29
      Action = actCancelarPedido
    end
    object butConfigBD: TSpeedButton
      Left = 554
      Top = 10
      Width = 123
      Height = 29
      Action = actConfiguracoes
      Anchors = [akTop, akRight]
      ExplicitLeft = 558
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 685
    Height = 25
    Align = alTop
    ShowCaption = False
    TabOrder = 0
    object lblBDStatus: TLabel
      AlignWithMargins = True
      Left = 9
      Top = 4
      Width = 672
      Height = 16
      Margins.Left = 8
      Align = alTop
      Caption = 'Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 43
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 25
    Width = 685
    Height = 32
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 5
    object Label4: TLabel
      Left = 17
      Top = 6
      Width = 15
      Height = 16
      Caption = 'N'#186
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNumero: TLabel
      Left = 38
      Top = 6
      Width = 4
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 105
      Top = 6
      Width = 56
      Height = 16
      Caption = 'Emiss'#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDataEmissao: TLabel
      Left = 166
      Top = 6
      Width = 4
      Height = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object mtItensPedido: TFDMemTable
    AfterPost = mtItensPedidoAfterPost
    OnCalcFields = mtItensPedidoCalcFields
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 464
    Top = 257
    object mtItensPedidocodigo: TIntegerField
      FieldName = 'codigo'
    end
    object mtItensPedidocod_produto: TIntegerField
      FieldName = 'cod_produto'
    end
    object mtItensPedidodesc_produto: TStringField
      FieldName = 'desc_produto'
      Size = 120
    end
    object mtItensPedidoquantidade: TFloatField
      FieldName = 'quantidade'
      DisplayFormat = '#,##0.00'
    end
    object mtItensPedidovalor_unitario: TFloatField
      FieldName = 'valor_unitario'
      DisplayFormat = '#,##0.00'
    end
    object mtItensPedidototal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'total'
      DisplayFormat = '#,##0.00'
      Calculated = True
    end
    object mtItensPedidototal_agg: TAggregateField
      FieldName = 'total_agg'
      Visible = True
      Active = True
      DisplayName = ''
      Expression = 'SUM(quantidade*valor_unitario)'
    end
  end
  object dsItensPedido: TDataSource
    DataSet = mtItensPedido
    Left = 504
    Top = 273
  end
  object ActionList1: TActionList
    Left = 376
    Top = 146
    object actGravarPedido: TAction
      Caption = 'Gravar Pedido [F1]'
      ShortCut = 112
      OnExecute = actGravarPedidoExecute
    end
    object actCarregarPedido: TAction
      Caption = 'Carregar Pedido [F2]'
      ShortCut = 113
      OnExecute = actCarregarPedidoExecute
    end
    object actCancelarPedido: TAction
      Caption = 'Cancelar Pedido [F3]'
      ShortCut = 114
      OnExecute = actCancelarPedidoExecute
    end
    object actConfiguracoes: TAction
      Caption = 'Configura'#231#245'es [F4]'
      ShortCut = 115
      OnExecute = actConfiguracoesExecute
    end
    object actSalvarItem: TAction
      Caption = 'Inserir Item [F5]'
      ShortCut = 116
      OnExecute = actSalvarItemExecute
    end
  end
end
