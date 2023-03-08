unit TestWS.Middleware;

interface

uses
  MVCFramework;

type
  TTestMiddleware = class(TInterfacedObject, IMVCMiddleware)
  public
    procedure OnBeforeRouting(AContext: TWebContext; var AHandled: Boolean);
    procedure OnBeforeControllerAction(AContext: TWebContext;
      const AControllerQualifiedClassName: string; const AActionName: string;
      var AHandled: Boolean);
    procedure OnAfterControllerAction(AContext: TWebContext; const AActionName: string;
      const AHandled: Boolean);
    procedure OnAfterRouting(AContext: TWebContext; const AHandled: Boolean);
  end;

implementation


{ TTestMiddleware }

procedure TTestMiddleware.OnAfterControllerAction(AContext: TWebContext;
  const AActionName: string; const AHandled: Boolean);
begin

end;

procedure TTestMiddleware.OnAfterRouting(AContext: TWebContext;
  const AHandled: Boolean);
begin
  AContext.Response.SetCustomHeader('X-PROUD-HEADER', 'Proudly served by DelphiMVCFramework');
end;

procedure TTestMiddleware.OnBeforeControllerAction(AContext: TWebContext;
  const AControllerQualifiedClassName, AActionName: string;
  var AHandled: Boolean);
begin

end;

procedure TTestMiddleware.OnBeforeRouting(AContext: TWebContext;
  var AHandled: Boolean);
begin

end;

end.
