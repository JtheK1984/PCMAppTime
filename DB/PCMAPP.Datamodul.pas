unit PCMAPP.Datamodul;

interface

uses
  {$Region Uses}
  {$IFDEF ANDROID}
  Posix.Unistd,
  {$ENDIF ANDROID}
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Data.DB,
  Data.DBXCommon,
  Data.DBXDataSnap,
  Data.DbxHTTPLayer,
  Data.FMTBcd,
  Data.SqlExpr,
  DBXCompressionFilter,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Pool,
  FireDAC.UI.Intf,
  FMX.Controls,
  FMX.dialogs,
  FMX.Forms,
  FMX.ImgList,
  FMX.Types,
  IdIPAddress,
  IdSSLOpenSSL,
  IdGlobal,
  IdHTTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdStack,
  IdTCPClient,
  IdTCPConnection,
  IniFiles,
  IPPeerClient,
  REST.Authenticator.Basic,
  REST.Backend.BindSource,
  REST.Backend.KinveyProvider,
  REST.Backend.PushTypes,
  REST.Client,
  REST.Types,
  System.Beacon,
  System.Beacon.Components,
  System.Bluetooth,
  System.Bluetooth.Components,
  System.Classes,
  System.ImageList,
  System.IOUtils,
  System.JSON,
  System.Notification,
  System.PushNotification,
  System.Sensors,
  System.Sensors.Components,
  System.SysUtils,
  PCMAPP.WaitForm;
  {$EndRegion Uses}
type
  {$Region Types}
  Tdmmain = class(TDataModule)
    con_PCM: TFDConnection;
    con_Restore: TFDConnection;
    imglst_Frame: TImageList;
    locsens_Location: TLocationSensor;
    physdrvlnk: TFDPhysSQLiteDriverLink;
    qry_timer: TFDQuery;
    stB_0: TStyleBook;
    stB_1: TStyleBook;
    stB_2: TStyleBook;
    stB_3: TStyleBook;
    stB_4: TStyleBook;
    RestRequestGoogle: TRESTRequest;
    RESTClientPCM: TRESTClient;
    HTTPBasicAuthenticatorPCM: THTTPBasicAuthenticator;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    procedure con_PCMAfterConnect(Sender: TObject);
    procedure con_PCMBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure locsens_LocationLocationChanged(Sender: TObject; const [Ref] OldLocation, NewLocation: TLocationCoord2D);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    fLat, fLon: Double;
    iUserID: Integer;
    sDeviceId: string;
    sDeviceToken: string;
    sHostname, sPort: String;
    wfWaitFrame: TWaitForm;
    function RestRequest(ARequestBody: TJSONObject; AResource: String; AGETPOST: TRESTRequestMethod = rmPOST): TJSONObject;
  end;
  {$EndRegion Types}
var
  {$Region Var}
  dmmain: Tdmmain;
  {$EndRegion Var}
implementation
{%CLASSGROUP 'FMX.Controls.TControl'}
uses
  {$Region Uses}
  PCMAPP.Funktionen,
  PCMAPP.Main,
  PCMAPP.SQL;
  {$EndRegion Uses}
{$R *.dfm}
function Tdmmain.RestRequest(ARequestBody: TJSONObject; AResource: String; AGETPOST: TRESTRequestMethod = rmPOST): TJSONObject;
var
  RestRequest: TRESTRequest;
  qry_Work: TFDQuery;
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= con_PCM;
  qry_Work.SQL.Text := sSQL_SEL_All_AUtologin;
  qry_Work.Open;
  HTTPBasicAuthenticatorPCM.Username:= qry_Work.FieldByName('Benutzername').AsString;
  HTTPBasicAuthenticatorPCM.Password:= qry_Work.FieldByName('Passwort').AsString;
  if HTTPBasicAuthenticatorPCM.Username = '' then
  begin
    HTTPBasicAuthenticatorPCM.Username:= frm_PCM_main.edt_Benutzername.Text;
    HTTPBasicAuthenticatorPCM.Password:= frm_PCM_main.edt_Passwort.Text;
  end;
  qry_Work.Close;
  FreeAndNil(qry_Work);
  if dmMain.sHostname <> '' then
  begin
    RestClientPCM.BaseURL:= 'https://' +  dmMain.sHostname +':' + dmmain.sPort + '/PCM/api/v1/';
  end
  else begin
    RestClientPCM.BaseURL:= 'https://' +  GStack.ResolveHost(dmMain.sHostname, Id_IPv4) +':' + dmmain.sPort + '/PCM/api/v1/';
//    RestClient1.BaseURL:= 'https://pcmapps.ddns.net:5443/PCM/api/v1/';
  end;
  RESTClientPCM.ContentType.Empty;

  RestRequest := TRESTRequest.Create(nil);
  try
    RestRequest.Timeout:= 30000;
    RESTRequest.AcceptEncoding := 'gzip, deflate, br';
    RestRequest.Client := RestClientPCM;
    RestRequest.Method := AGETPOST;
    RestRequest.Resource := AResource;
    if ARequestBody <> nil then
    begin
      RestRequest.Body.Add(ARequestBody);
    end;
    RestRequest.Execute;
    Result:= TJSonObject.ParseJSONValue(RestRequest.Response.JSONText) as TJSONObject;
  finally
    RestRequest.Free;
  end;
end;
////////////////////////////////////////////////////////////////////////////////
// DATAMODUL FUNCTIONS                                                        //
////////////////////////////////////////////////////////////////////////////////
{$Region DATAMODUL FUNCTIONS}
procedure Tdmmain.con_PCMAfterConnect(Sender: TObject);
begin
  CreateDatabase;
end;
procedure Tdmmain.con_PCMBeforeConnect(Sender: TObject);
begin
  con_PCM.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'PCMTime.s3db');
end;
procedure Tdmmain.DataModuleCreate(Sender: TObject);
begin
  con_PCM.Connected := True;
end;
procedure Tdmmain.DataModuleDestroy(Sender: TObject);
begin
  con_PCM.Connected := False;
  con_Restore.Connected := False;
  locsens_Location.Active := False;
end;
procedure Tdmmain.locsens_LocationLocationChanged(Sender: TObject; const [Ref] OldLocation, NewLocation: TLocationCoord2D);
begin
  fLat  := NewLocation.Latitude;
  fLon := NewLocation.Longitude;
end;
{$EndRegion DATAMODUL FUNCTIONS}
end.


