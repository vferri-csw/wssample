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
begin
  ERPCoreContainer.Resolve<IWebModuleRegistry>.RegisterHook('TestMiddleware',
    procedure(AServer: TMVCEngine)
    begin
      AServer.AddMiddleware(TTestMiddleware.Create);
    end);
end;

class procedure TPackageEvents.OnBeforeUnLoad;
begin
end;

end.
