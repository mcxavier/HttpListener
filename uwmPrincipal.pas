unit uwmPrincipal;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, IdHTTPWebBrokerBridge,
  superobject, Menus, Vcl.Forms, Vcl.Controls,
  IdContext, IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdCustomHTTPServer, IdHTTPServer, Web.HTTPProd;

type
  TRequestAbreMenu = class
  public
    empresa : integer;
    usuario: integer;
    menu : integer;
    login : string;
  end;

  TwmPrincipal = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmPrincipalwacAbreMenuAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    procedure ExecuteExternProgram(sNomeExe, sParams, sPath:string);
  public
    { Public declarations }
  end;

var
  WebModuleResidente: TComponentClass = TwmPrincipal;
  webToken: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
   ShellApi, uPrincipal;



procedure TwmPrincipal.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin

  Response.StatusCode := 200;

  Response.Content :=
    '<html>' +
    '<head><title>Web Server Application</title></head>' +
    '<body>Http Listener</body>' +
    '</html>';

  Response.SendResponse;
end;



procedure TwmPrincipal.WebModuleBeforeDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.SetCustomHeader('Access-Control-Allow-Origin','*');

  Response.SetCustomHeader('Access-Control-Allow-Headers', 'Content-Type');

  if Trim(Request.GetFieldByName('Access-Control-Request-Headers')) <> '' then
  begin
    Response.SetCustomHeader('Access-Control-Allow-Headers', Request.GetFieldByName('Access-Control-Request-Headers'));
    Handled := True;
  end;
end;




procedure TwmPrincipal.ExecuteExternProgram(sNomeExe, sParams, sPath:string);
begin
    ShellExecute(0, nil, PWideChar(sNomeExe), PWideChar(sParams), PWideChar(sPath), 0);
end;






procedure TwmPrincipal.wmPrincipalwacAbreMenuAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  rAbreMenu : TRequestAbreMenu;
  sParams: string;
begin
   try
      rAbreMenu := TRequestAbreMenu.Create;
      if Request.Content <> '' then
      begin
         rAbreMenu := TRequestAbreMenu.FromJson(Request.Content);

         sParams := ' /EMP=' + IntToStr(rAbreMenu.empresa) +
             ' /USU=' + rAbreMenu.login +
             ' /MEN=' + IntToStr(rAbreMenu.menu) +
             ' /ORIGEM=WEB' +
             ' /TKN=' + webToken;

         self.ExecuteExternProgram('MeuCliente.Exe', sParams, frmPrincipal.EditPath.Text)
      end;


      Response.StatusCode := 200;
      Response.Content := 'OK [' + sParams + ']';
   Except
      Response.StatusCode := 200;
      Response.Content := 'Erro';
   end;
end;


end.
