object wmPrincipal: TwmPrincipal
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'wacDefault'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = '0'
      PathInfo = '/AbreMenu'
      OnAction = wmPrincipalwacAbreMenuAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 230
  Width = 415
end
