unit uPrincipal;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp, Vcl.ExtCtrls,
  IdContext, IdCustomHTTPServer, IdHeaderList, IniFiles, Vcl.DBCtrls;

type
  TfrmPrincipal = class(TForm)
    EditPorta: TEdit;
    Label1: TLabel;
    ApplicationEvents1: TApplicationEvents;
    trycn1: TTrayIcon;
    EditPath: TEdit;
    Label2: TLabel;
    EditStatus: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    chkIniciarWindows: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
//    procedure ButtonStartClick(Sender: TObject);
//    procedure ButtonStopClick(Sender: TObject);
    procedure ButtonOpenBrowserClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure trycn1Click(Sender: TObject);
    function  RunOnStartup(sProgTitle, sCmdLine: string):Boolean;
    procedure ApplicationEvents1Minimize(Sender: TObject);
  private
    FServer: TIdHTTPWebBrokerBridge;
    procedure DoParseAuthentication(AContext: TIdContext; const AAuthType, AAuthData: String; var VUsername, VPassword: String; var VHandled: Boolean);
    procedure StartServer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  WinApi.Windows, Winapi.ShellApi, Registry, uwmPrincipal;


procedure TfrmPrincipal.DoParseAuthentication(AContext: TIdContext; const AAuthType, AAuthData: String; var VUsername, VPassword: String; var VHandled: Boolean);
begin
   try
     VHandled := AAuthType.Equals('Bearer');
     webToken := AAuthData;
   finally
     VHandled := True;
   end;
end;




function TfrmPrincipal.RunOnStartup(sProgTitle, sCmdLine: string):Boolean;
var
  reg : TRegIniFile;
  retorno : Boolean;
begin
  retorno := False;
  reg := TRegIniFile.Create('');

  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.WriteString('Software\Microsoft\Windows\CurrentVersion\Run', sProgTitle, sCmdLine);
    if (reg.ReadString('Software\Microsoft\Windows\CurrentVersion\Run', sProgTitle, '').Length > 0) then
       retorno := True;
    reg.Free;
  except
    if (reg.InstanceSize > 0) then
       reg.Free;
    retorno := False;
  end;

  Result := retorno;
end;



procedure TfrmPrincipal.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;

  trycn1.Visible := True;
  trycn1.Animate := True;
  trycn1.ShowBalloonHint;
end;


procedure TfrmPrincipal.ButtonOpenBrowserClick(Sender: TObject);
var
  LURL: string;
begin
  StartServer;
  LURL := Format('http://localhost:%s', [EditPorta.Text]);
  ShellExecute(0,
        nil,
        PChar(LURL), nil, nil, SW_SHOWNOACTIVATE);
end;



procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  self.Hide();
  Abort;
end;


procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  ArquivoINI: TIniFile;
  sArquIni: string;
  arq: TextFile;
begin
  FServer := TIdHTTPWebBrokerBridge.Create(Self);
  FServer.OnParseAuthentication := DoParseAuthentication;



  sArquIni := ExtractFilePath(Application.ExeName) + 'HttpListener.Ini';

  if not(FileExists(sArquIni)) then
  begin
    //CreateFile(sArquIni);
    AssignFile(arq, sArquIni);
    Rewrite(arq);
    Writeln(arq, '[CONFIG]');
    Writeln(arq, 'PORT=8072');
    Writeln(arq, 'PATH=' + Copy(ExtractFilePath(Application.ExeName), 0,
          (Length(ExtractFilePath(Application.ExeName))-1)));
    CloseFile(arq);
  end;

  ArquivoINI := TIniFile.Create(sArquIni);


  trycn1.Hint := 'Http Listener';
  trycn1.AnimateInterval := 200;
  trycn1.BalloonFlags := bfInfo;
  self.StartServer;

  Self.EditPorta.Text := ArquivoINI.ReadString('CONFIG', 'PORT', '8072');
  Self.EditPath.Text := ArquivoINI.ReadString('CONFIG', 'PATH',  Copy(ExtractFilePath(Application.ExeName), 0,
          (Length(ExtractFilePath(Application.ExeName))-1)));

  ArquivoINI.Free;

  Self.chkIniciarWindows.Checked := self.RunOnStartup('Http Listener', Self.EditPath.Text + '\HttpListener.Exe');

  Hide();
  WindowState := wsMinimized;

  trycn1.Visible := True;
  trycn1.Animate := True;
  trycn1.ShowBalloonHint;
end;




procedure TfrmPrincipal.StartServer;
begin

  if not FServer.Active then
  begin
    FServer.Bindings.Clear;
    FServer.DefaultPort := StrToInt(EditPorta.Text);
    FServer.Active := True;
    self.EditStatus.Text := 'Listening...(ON)';
  end;
end;

procedure TfrmPrincipal.trycn1Click(Sender: TObject);
begin
  trycn1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
