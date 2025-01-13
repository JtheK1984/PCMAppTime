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
  fmx.dialogs,
  FMX.Forms,
  FMX.ImgList,
  FMX.Types,
  IdBaseComponent,
  IdComponent,
  IdHTTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
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
    con_SQL: TSQLConnection;
    imglst_Frame: TImageList;
    locsens_Location: TLocationSensor;
    physdrvlnk: TFDPhysSQLiteDriverLink;
    qry_timer: TFDQuery;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    RESTResponse2: TRESTResponse;
    sqlSM_HoleBuchungenJahr: TSqlServerMethod;
    sqlSM_HoleFehltage: TSqlServerMethod;
    sqlSM_HoleFehltageKonfiguration: TSqlServerMethod;
    sqlSM_HoleLetzteBuchung: TSqlServerMethod;
    sqlSM_HoleLogin: TSqlServerMethod;
    sqlSM_HoleMonatswerte: TSqlServerMethod;
    sqlSM_HolePersonalDaten: TSqlServerMethod;
    sqlSM_HoleUserID: TSqlServerMethod;
    sqlSM_PruefeLogin: TSqlServerMethod;
    sqlSM_SetzeBuchung: TSqlServerMethod;
    sqlSM_SetzeFehltage: TSqlServerMethod;
    sqlSM_SetzeGeraeteID: TSqlServerMethod;
    sqlSM_SetzeLetzteBuchung: TSqlServerMethod;
    sqlSM_SetzeLogin: TSqlServerMethod;
    stB_0: TStyleBook;
    stB_1: TStyleBook;
    stB_2: TStyleBook;
    stB_3: TStyleBook;
    stB_4: TStyleBook;
    procedure AfterCloseDataset(DataSet: TDataSet);
    procedure con_PCMAfterConnect(Sender: TObject);
    procedure con_PCMBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure locsens_LocationLocationChanged(Sender: TObject; const [Ref] OldLocation, NewLocation: TLocationCoord2D);
    procedure DataModuleDestroy(Sender: TObject);
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
  PCMAPP.Main;
  {$EndRegion Uses}
{$R *.dfm}
////////////////////////////////////////////////////////////////////////////////
// DATAMODUL FUNCTIONS                                                        //
////////////////////////////////////////////////////////////////////////////////
{$Region DATAMODUL FUNCTIONS}
procedure Tdmmain.AfterCloseDataset(DataSet: TDataSet);
begin
  con_SQL.Close;
end;
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
  con_SQL.Connected := False;
  locsens_Location.Active := False;
end;
procedure Tdmmain.locsens_LocationLocationChanged(Sender: TObject; const [Ref] OldLocation, NewLocation: TLocationCoord2D);
begin
  fLat  := NewLocation.Latitude;
  fLon := NewLocation.Longitude;
end;
{$EndRegion DATAMODUL FUNCTIONS}
end.


