unit TestWS.Middleware;

interface

uses
  MVCFramework,
  CSCore.Interfaces,
  CSWebFramework.Classes;

type
  TTestMiddleware = class(TCSMiddleware)
  private
    FActivateMyLogic: boolean;
  public
    /// <summary>
    /// Procedure is called before the MVCEngine routes the request to a specific controller/method.
    /// </summary>
    /// <param name="AContext">Webcontext which contains the complete request and response of the actual call.</param>
    /// <param name="AHandled">If set to True the Request would finished. Response must be set by the implementor. Default value is False.</param>
    procedure OnBeforeRouting(AContext: TWebContext; var AHandled: Boolean); override;

    /// <summary>
    /// Procedure is called before the specific controller method is called.
    /// </summary>
    /// <param name="AContext">Webcontext which contains the complete request and response of the actual call.</param>
    /// <param name="AControllerQualifiedClassName">Qualified classname of the matching controller.</param>
    /// <param name="AActionName">Method name of the matching controller method.</param>
    /// <param name="AHandled">If set to True the Request would finished. Response must be set by the implementor. Default value is False.</param>    procedure OnBeforeControllerAction(AContext: TWebContext;
    procedure OnBeforeControllerAction(AContext: TWebContext; const AControllerQualifiedClassName: string;
      const AActionName: string; var AHandled: Boolean); override;

    /// <summary>
    /// Procedure is called after the specific controller method was called.
    /// It is still possible to cancel or to completly modifiy the request.
    /// </summary>
    /// <param name="AContext">Webcontext which contains the complete request and response of the actual call.</param>
    /// <param name="AActionName">Method name of the matching controller method.</param>
    /// <param name="AHandled">If set to True the Request would finished. Response must be set by the implementor. Default value is False.</param>
    procedure OnAfterControllerAction(AContext: TWebContext;
      const AControllerQualifiedClassName: string; const AActionName: string;
      const AHandled: Boolean); override;

    /// <summary>
    /// Procedure is called after the MVCEngine routes the request to a specific controller/method.
    /// </summary>
    /// <param name="AContext">Webcontext which contains the complete request and response of the actual call.</param>
    /// <param name="AHandled">If set to True the Request would finished. Response must be set by the implementor. Default value is False.</param>
    procedure OnAfterRouting(AContext: TWebContext; const AHandled: Boolean); override;
  end;

  TCodiceDescrModel = class
  private
    Fcodice: string;
    Fdescr: string;
  public
    property codice: string read Fcodice write Fcodice;
    property descr: string read Fdescr write Fdescr;
  end;

implementation

uses
  IBaseRT,
  JsonDataObjects,
  CSResources.Globals,
  MVCFramework.Commons,
  CSCore.Globals,
  CSWebFramework.Interfaces,
  MVCFramework.Serializer.JsonDataObjects,
  MVCFramework.Serializer.Commons, System.SysUtils, System.Classes;

{ TTestMiddleware }

procedure TTestMiddleware.OnAfterControllerAction(AContext: TWebContext;
      const AControllerQualifiedClassName: string; const AActionName: string;
      const AHandled: Boolean);
var
  LModel: TCodiceDescrModel;
  LArtCla: IArtCla1RT;
begin
    if FActivateMyLogic then
    begin
      if not FCurrentSession.GetInterfOggetto('objArtCla1', 'ArtCla1', IArtCla1RT, LArtCla) then
      begin
        raise Exception.Create('Errore durante il reperimento dell''oggetto ArtCla1');
      end;

      LModel := AContext.Request.BodyAs<TCodiceDescrModel>;
      LModel.descr := LModel.descr + ' altered';
      LArtCla.Seek('codice', LModel.codice);
      LArtCla.CampiObj['descr'] := LModel.descr;
      LArtCla.Modifica;
    end;
end;

procedure TTestMiddleware.OnAfterRouting(AContext: TWebContext;
  const AHandled: Boolean);
begin
  AContext.Response.SetCustomHeader('X-PROUD-HEADER', 'Proudly served by Centro Software');
end;

procedure TTestMiddleware.OnBeforeControllerAction(AContext: TWebContext;
  const AControllerQualifiedClassName, AActionName: string;
  var AHandled: Boolean);
begin
  FActivateMyLogic := False;

  if (AControllerQualifiedClassName = 'BaseWS.ArtCla1.Controller.TArtCla1Controller') and
    (AContext.Request.HTTPMethod = httpPOST) then
  begin
    FActivateMyLogic := True;
  end;
end;

procedure TTestMiddleware.OnBeforeRouting(AContext: TWebContext;
  var AHandled: Boolean);
begin
  if AHandled then
  begin

  end;
end;

end.
