object frmCall_XBF: TfrmCall_XBF
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20351#29992'XBF'#24211
  ClientHeight = 363
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 160
    Top = 288
    Width = 46
    Height = 13
    AutoSize = False
  end
  object Label2: TLabel
    Left = 214
    Top = 288
    Width = 17
    Height = 13
    AutoSize = False
  end
  object Label3: TLabel
    Left = 235
    Top = 288
    Width = 17
    Height = 13
    AutoSize = False
  end
  object Label4: TLabel
    Left = 160
    Top = 320
    Width = 105
    Height = 13
    AutoSize = False
  end
  object btnGetDate: TButton
    Left = 48
    Top = 280
    Width = 75
    Height = 25
    Caption = 'datetime'
    TabOrder = 0
    OnClick = btnGetDateClick
  end
  object btnWriteSQL2k: TButton
    Left = 48
    Top = 16
    Width = 75
    Height = 25
    Caption = #20889'XBF'#25991#20214'1'
    TabOrder = 1
    OnClick = btnWriteSQL2kClick
  end
  object btnWriteMDB: TButton
    Left = 176
    Top = 16
    Width = 75
    Height = 25
    Caption = #20889'XBF'#25991#20214'2'
    TabOrder = 2
    OnClick = btnWriteMDBClick
  end
  object btnReadSQL2k: TButton
    Left = 48
    Top = 72
    Width = 75
    Height = 25
    Caption = #35835'XBF'#25991#20214'1'
    TabOrder = 3
    OnClick = btnReadSQL2kClick
  end
  object btnReadMDB: TButton
    Left = 176
    Top = 72
    Width = 75
    Height = 25
    Caption = #35835'XBF'#25991#20214'2'
    TabOrder = 4
    OnClick = btnReadMDBClick
  end
  object gboxSerice: TGroupBox
    Left = 256
    Top = 104
    Width = 201
    Height = 169
    Caption = 'System Service Control'
    TabOrder = 5
    object btnServiceState: TButton
      Left = 48
      Top = 32
      Width = 113
      Height = 25
      Caption = 'getServiceState'
      TabOrder = 0
      OnClick = btnServiceStateClick
    end
    object btnStartSerice: TButton
      Left = 48
      Top = 72
      Width = 113
      Height = 25
      Caption = 'startSerice'
      TabOrder = 1
      OnClick = btnStartSericeClick
    end
    object btnStopService: TButton
      Left = 48
      Top = 112
      Width = 113
      Height = 25
      Caption = 'stopSerice'
      TabOrder = 2
      OnClick = btnStopServiceClick
    end
  end
  object edtServiceName: TEdit
    Left = 472
    Top = 112
    Width = 177
    Height = 21
    Hint = #26381#21153#21517#31216
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = 'MSSQLSERVER'
  end
  object ComboBox1: TComboBox
    Left = 48
    Top = 112
    Width = 73
    Height = 21
    ItemHeight = 13
    TabOrder = 7
  end
end
