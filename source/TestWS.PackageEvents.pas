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
  TestWS.Middleware,
  CSWebFramework.Globals;

{ TPackageEvents }


class procedure TPackageEvents.OnAfterLoad;
begin
  RegisterWebServiceMiddleware('TestMiddleware', TTestMiddleware.Create);
end;

class procedure TPackageEvents.OnBeforeUnLoad;
begin
  UnRegisterWebServiceMiddleware('TestMiddleware');
end;

end.
