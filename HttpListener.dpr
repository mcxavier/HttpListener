program HttpListener;
{$APPTYPE GUI}







uses
  Vcl.Forms, Windows,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uwmPrincipal in 'uwmPrincipal.pas' {wmPrincipal: TWebModule};

{$R *.res}

var
  ExtendedStyle : Integer;
begin

  Application.MainFormOnTaskbar := False;

  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleResidente;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
