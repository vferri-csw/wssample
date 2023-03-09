unit TestWS.PackageEvents;

interface

type
  TPackageEvents = class
  public
    class procedure OnAfterLoad;
    class procedure OnBeforeUnLoad;
  end;


implementation

uses
  MVCFramework,
  TestWS.Middleware,
  CSWebFramework.Interfaces,
  CSCore.Globals;


{ TPackageEvents }


class procedure TPackageEvents.OnAfterLoad;
var
  LRegistry: IWebModuleRegistry;
begin
  LRegistry := ERPCoreContainer.Resolve<IWebModuleRegistry>;
  LRegistry.RegisterHook('TestMiddleware',
    procedure(AServer: TMVCEngine)
    begin
      AServer.AddMiddleware(TTestMiddleware.Create);
    end);
end;

class procedure TPackageEvents.OnBeforeUnLoad;
var
  LRegistry: IWebModuleRegistry;
begin
  LRegistry := ERPCoreContainer.Resolve<IWebModuleRegistry>;
  LRegistry.UnregisterHook('TestMiddleware');
end;

end.
