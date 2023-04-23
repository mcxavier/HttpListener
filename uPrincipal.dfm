object frmPrincipal: TfrmPrincipal
  Left = 271
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Http Listener'
  ClientHeight = 111
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object Label2: TLabel
    Left = 8
    Top = 49
    Width = 43
    Height = 13
    Caption = 'Path Exe'
  end
  object lbl1: TLabel
    Left = 95
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object lbl2: TLabel
    Left = 25
    Top = 93
    Width = 136
    Height = 13
    Caption = 'Iniciar Junto com o Windows'
  end
  object EditPorta: TEdit
    Left = 8
    Top = 21
    Width = 76
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = '8072'
  end
  object EditPath: TEdit
    Left = 8
    Top = 63
    Width = 281
    Height = 21
    ReadOnly = True
    TabOrder = 1
    Text = '8072'
  end
  object EditStatus: TEdit
    Left = 95
    Top = 21
    Width = 194
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    Text = '8072'
  end
  object chkIniciarWindows: TDBCheckBox
    Left = 8
    Top = 91
    Width = 19
    Height = 17
    ReadOnly = True
    TabOrder = 3
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 256
    Top = 32
  end
  object trycn1: TTrayIcon
    OnClick = trycn1Click
    Left = 248
    Top = 65528
  end
end
