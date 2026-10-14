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
  PCMAPP.WaitForm, System.Net.URLClient, System.Net.HttpClient;
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
    bServerAvailable: boolean;
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
  Client: TRESTClient;
  Auth: THTTPBasicAuthenticator;
  Request: TRESTRequest;
  Query: TFDQuery;
  Connection: TFDConnection;
  UserName, Password, Host, Port: string;
  JSON: TJSONValue;
begin
  Result := nil;
  Host := sHostname;
  Port := sPort;
  if Host = '' then raise Exception.Create('REST: kein Server konfiguriert');
  UserName := '';
  Password := '';
  Connection := TFDConnection.Create(nil);
  Query := TFDQuery.Create(nil);
  try
    Connection.Params.Assign(con_PCM.Params);
    Connection.LoginPrompt := False;
    Connection.Connected := True;
    Query.Connection := Connection;
    Query.SQL.Text := sSQL_SEL_All_AUtologin;
    Query.Open;
    if not Query.IsEmpty then
    begin
      UserName := Query.FieldByName('Benutzername').AsString;
      Password := Query.FieldByName('Passwort').AsString;
    end
    else begin
      UserName := frm_PCM_Main.edt_Benutzername.Text;
      Password := frm_PCM_Main.edt_Passwort.Text;
    end;
  finally
    Query.Free;
    Connection.Free;
  end;
  // A fresh login must use the entered credentials, not an older auto-login.
  if SameText(AResource, 'CheckLoginTime') and
    (Trim(frm_PCM_Main.edt_Benutzername.Text) <> '') then
  begin
    UserName := frm_PCM_Main.edt_Benutzername.Text;
    Password := frm_PCM_Main.edt_Passwort.Text;
  end
  else if UserName = '' then
  begin
    UserName := frm_PCM_Main.edt_Benutzername.Text;
    Password := frm_PCM_Main.edt_Passwort.Text;
  end;
  if UserName = '' then raise Exception.Create('REST: kein Benutzername vorhanden');
  Client := TRESTClient.Create(nil);
  Auth := THTTPBasicAuthenticator.Create(nil);
  Request := TRESTRequest.Create(nil);
  try
    Auth.Username := UserName;
    Auth.Password := Password;
    Client.Authenticator := Auth;
    Client.BaseURL := 'https://' + Host + ':' + Port + '/PCM/api/v1/';
    Request.Client := Client;
    Request.Timeout := 30000;
    Request.AcceptEncoding := 'gzip, deflate';
    Request.Method := AGETPOST;
    Request.Resource := AResource;
    if ARequestBody <> nil then
      Request.Body.Add(ARequestBody.ToJSON, ctAPPLICATION_JSON);
    Request.Execute;
    if (Request.Response.StatusCode < 200) or (Request.Response.StatusCode >= 300) then
      raise Exception.CreateFmt('REST %s: HTTP %d', [AResource, Request.Response.StatusCode]);
    JSON := TJSONObject.ParseJSONValue(Request.Response.JSONText);
    if not (JSON is TJSONObject) then
    begin
      JSON.Free;
      raise Exception.Create('REST ' + AResource + ': ungueltige JSON-Antwort');
    end;
    Result := TJSONObject(JSON);
  finally
    Request.Free;
    Client.Free;
    Auth.Free;
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


