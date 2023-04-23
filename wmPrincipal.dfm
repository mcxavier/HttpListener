object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'wacDefault'
      PathInfo = '/'
      OnAction = WebModule1DefaultHandlerAction
    end
    item
      Name = 'wacAbreMenu'
      PathInfo = '/AbreMenu'
    end>
  Height = 230
  Width = 415
end
