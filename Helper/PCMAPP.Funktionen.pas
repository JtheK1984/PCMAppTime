unit PCMAPP.Funktionen;

interface

uses
  {$Region Uses}
  {$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.app,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  FMX.Helpers.Android,
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
  FMX.Graphics,
  FMX.Platform,
  Rest.Types,
  Soap.EncdDecd,
  System.Classes,
  System.DateUtils,
  System.Devices,
  System.IOUtils,
  System.JSON,
  System.Math,
  System.Net.HttpClientComponent,
  System.NetEncoding,
  System.Net.HttpClient,
  System.SysUtils,
  System.Types,
  System.UITypes,
  PCMAPP.Datamodul,
  PCMAPP.SQL,
  PCMAPP.WaitForm;
  {$EndRegion Uses}
// Deklarationen Functions
{$Region Functions}
function CheckLogin: Boolean;
function CheckServerConnection: Boolean;
function GetBuchungsart(ATyp: integer; AVon,ABis: TDate) : integer;
function GetCountFromTableAuto_Login: integer;
function GetCountFromTableLogin: integer;
function GetCountFromTableServer: integer;
function GetDeviceType: string;
function GetFehltagSum(AFeiertag, ATyp, ABezahlt: integer;AVon,ABis:TDate) : double;
function GetFeiertage(AVon,ABis: TDate) : double;
function GetTimeValue(AValue: integer) : String;
{$EndRegion Functions}
// Deklarationen Procedures
{$Region Procedures}
procedure UpdateFieldValues_String(AField, ATable, AValue: String; AID:Integer);
procedure UpdateFieldValues_Ansistring(AField, ATable: String; AValue: Ansistring; AID:Integer);
procedure UpdateFieldValues_TTime(AField, ATable: String; AValue: TTime; AID:Integer);
procedure UpdateFieldValues_TDateTime(AField, ATable: String; AValue: TDateTime; AID:Integer);
procedure UpdateFieldValues_TDate(AField, ATable: String; AValue: TDate; AID:Integer);
procedure UpdateFieldValues_Boolean(AField, ATable: String; AValue: Boolean; AID:Integer);
procedure UpdateFieldValues_Integer(AField, ATable: String; AValue: Integer; AID:Integer);
procedure UpdateFieldValues_Float(AField, ATable: String; AValue: Double; AID:Integer);
procedure BerechneMonat(AMonat,AJahr: integer);
procedure BerechneTage(ATag,AMonat,AJahr: integer);
procedure CreateDatabase;
procedure DeleteAllTables;
procedure ClearAllTablesByID(AID: Integer; AColumnName: String);
procedure SaveLogin(AUsername, APassword: String; AUserID, AServerID: Integer;AFirstStart: Boolean);
procedure SyncConfig_ToServer(const AUserID: Integer; AWaitFrame: TWaitForm);


procedure SynchAbsence_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchAbsence_ToServer(AID: integer; ADelete: boolean);
procedure SynchAbsenceConfig_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchBooking_ToServer(AID: integer);
procedure SynchBookingYear_FromServer(const AUserID, AServerID, AJahr: Integer; AWaitFrame: TWaitForm);
procedure SyncKontakte_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchLastBooking_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchLastBooking_toServer(const AUserID: integer; AWaitFrame: TWaitForm; bALL: Boolean);
//procedure SynchMonthView(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchOnlineBooking_ToServer(const AUserID: integer; ADate: TDate; ATime: TTime; ABookingType,AHOOffice:Integer; AWaitFrame: TWaitForm; bALL: Boolean);
procedure Synchronisation(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm; bALL: Boolean);
procedure WriteLog(AMessage: String; ATyp: Integer; ANewFile: boolean);
{$EndRegion Procedures}
var
  {$Region uses}
  joResponseJSON: TJSONObject;
  joResponseJSONData: TJSONObject;
  JSONResult: TJSONObject;
  jaDetails: TJSonArray;
  icode: integer;
  sMessage: String;
  bHasError: boolean;
  {$EndRegion uses}
implementation
// Functions
{$Region Functions}
// Restfunction
function CheckLogin: Boolean;
begin
  Result:= False;
  JSONResult := dmmain.RestRequest(nil,'CheckloginTime',rmGET) as TJSONObject;
  bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
  if not bHasError then
  begin
    jaDetails :=  JSONResult.GetValue<TJSONArray>('Login');
    for var JSonValue in jaDetails do
    begin
      JSonValue.TryGetValue<boolean>('Allowed',Result);
      JSonValue.TryGetValue<Integer>('ID_User',dmmain.iUserID);
    end;
  end;
end;
function CheckServerConnection: Boolean;
var
  Client: THTTPClient;
  Response: IHTTPResponse;
begin
  Client := THTTPClient.Create;
  try
    Client.ConnectionTimeout := 5000;  // 10 Sekunden für Verbindung
    Client.ResponseTimeout := 10000;    // 15 Sekunden auf Antwort warten
    Response := Client.Head('https://' +  dmMain.sHostname +':' + dmmain.sPort + '/PCM/api/v1/');
    Result := (Response.StatusCode = 200) or (Response.StatusCode = 500);
  except
    Result := False;
  end;
  Client.Free;
end;
//function CheckServerConnection: Boolean;
//begin
//  Result:= False;
//  try
//    JSONResult := dmmain.RestRequest(nil,'CheckServer',rmGET) as TJSONObject;
//    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
//    if not bHasError then
//    begin
//      Result:= True;
//    end;
//  except
//  end;
//end;
function GetBuchungsart(ATyp: integer; AVon,ABis: TDate) : integer;
var
  qry_BA: TFDQuery;
begin
  qry_BA:= TFDQuery.Create(nil);
  qry_BA.Connection:= dmmain.con_PCM;

  qry_BA.SQL.Text:=  'SELECT Count(*) as Anzahl ' +
                              'FROM buchungen zeb ' +
                              'LEFT OUTER JOIN Fehltag zeft ON zeft.Kuerzel = zeb.Fehltag ' +
                              'WHERE Kommen <> ''00:00'' and  zeb.Datum >= :Von and zeb.Datum <= :Bis AND Buchungsart = :Typ';
  qry_BA.ParamByName('Von').asDate:= AVon;
  qry_BA.ParamByName('Bis').asDate:= ABis;
  qry_BA.ParamByName('Typ').asInteger:= ATyp;
  qry_BA.open;
  Result:= qry_BA.FieldByName('Anzahl').AsInteger;
  qry_BA.close;
  FreeAndNil(qry_BA);
end;
function GetCountFromTableAuto_Login: integer;
var
  qry_Work: TFDQuery;
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text:= sSQL_SELECT_COUNT_AUTOLOGIN;
  qry_Work.open;
  Result:= qry_Work.FieldByName('Anzahl').AsInteger;
  qry_Work.Close;
  Freeandnil(qry_Work);
end;
function GetCountFromTableLogin: integer;
var
  qry_Work: TFDQuery;
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text:= sSQL_SELECT_COUNT_LOGIN;
  qry_Work.open;
  Result:= qry_Work.FieldByName('Anzahl').AsInteger;
  qry_Work.Close;
  Freeandnil(qry_Work);
end;
function GetCountFromTableServer: integer;
var
  qry_Work: TFDQuery;
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text:= sSQL_SELECT_COUNT_Server;
  qry_Work.open;
  Result:= qry_Work.FieldByName('Anzahl').AsInteger;
  qry_Work.Close;
  Freeandnil(qry_Work);
end;
function GetDeviceType: string;
var
  DeviceService: IFMXDeviceService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXDeviceService, IInterface(DeviceService)) then
  begin
    case DeviceService.GetDeviceClass of
      TDeviceInfo.TDeviceClass.Phone: Result := 'Phone';
      TDeviceInfo.TDeviceClass.Tablet: Result := 'Tablet';
      TDeviceInfo.TDeviceClass.Desktop: Result := 'Desktop';
      TDeviceInfo.TDeviceClass.Unknown: Result := 'unbekanntes Gerät';
    else
      Result := 'unbekanntes Gerät';
    end;
  end
  else
    Result := 'Dieses Gerät wird nicht unterstützt';
end;
function GetFehltagSum(AFeiertag, ATyp, ABezahlt: integer;AVon,ABis:TDate) : double;
var
  qry_FT: TFDQuery;
begin
  qry_FT:= TFDQuery.Create(nil);
  qry_FT.Connection:= dmmain.con_PCM;
  qry_FT.SQL.Text:=  'SELECT IFNULL(SUM((Zeb.SollstundenI / zeft.faktor)),0) as Anzahl ' +
                     'FROM buchungen zeb ' +
                     'LEFT OUTER JOIN Fehltag zeft ON zeft.Kuerzel = zeb.Fehltag ' +
                     'WHERE  zeb.Feiertag <> :Feiertag AND zeb.Sollstunden = :Zeit and zeb.Datum >= :Von and zeb.Datum <= :Bis AND zeft.Typ = :Typ AND zeft.Bezahlt = :Bezahlt';
  qry_FT.ParamByName('Zeit').AsTime:= StrToTime('08:00');
  qry_FT.ParamByName('Von').asDate:= AVon;
  qry_FT.ParamByName('Bis').asDate:= ABis;
  qry_FT.ParamByName('Feiertag').AsInteger:= AFeiertag;
  qry_FT.ParamByName('Typ').AsInteger:= ATyp;
  qry_FT.ParamByName('Bezahlt').AsInteger:= ABezahlt;
  qry_FT.open;
  result:= qry_FT.FieldByName('Anzahl').AsFloat / 480;
  qry_FT.close;
  Freeandnil(qry_FT);
end;
function GetFeiertage(AVon,ABis: TDate) : double;
var
  qry_FT: TFDQuery;
begin
  qry_FT:= TFDQuery.Create(nil);
  qry_FT.Connection:= dmmain.con_PCM;
  qry_FT.SQL.Text:= 'SELECT IFNULL(Sum(if(Feiertag = 2, 0.5,1)),0) AS Anzahl ' +
                    'FROM buchungen zeb ' +
                    'WHERE zeb.Sollstunden = :Zeit and zeb.Datum >= :Von and zeb.Datum <= :Bis AND zeb.feiertag > 0';
  qry_FT.ParamByName('Zeit').AsTime:= StrToTime('08:00');
  qry_FT.ParamByName('Von').asDate:= AVon;
  qry_FT.ParamByName('Bis').asDate:= ABis;
  qry_FT.open;
  Result:= qry_FT.FieldByName('Anzahl').AsFloat;
  qry_FT.close;
  Freeandnil(qry_FT);
end;
function GetTimeValue(AValue: integer) : String;
var
  iHour,iMin: integer;
  sHour,sMin: String;
begin
  iHour:= AValue div 60;
  iMin:= AValue mod 60;
  sHour:= IntToStr(iHour);
  if iMin < 10 then
    sMin:= '0' + IntToStr(iMin)
  else
    sMin:= IntToStr(iMin);
  if Length(sHour) = 1 then
    sHour:= '0' + sHour;
  result:= sHour + ':' + sMin
end;
{$EndRegion Functions}
// procedures
{$Region procedures}
procedure UpdateFieldValues_String(AField, ATable, AValue: String; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').AsString:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure UpdateFieldValues_Ansistring(AField, ATable: String; AValue: Ansistring; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').asMemo:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure UpdateFieldValues_TTime(AField, ATable: String; AValue: TTime; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').AsTime:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure UpdateFieldValues_TDateTime(AField, ATable: String; AValue: TDateTime; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').AsDateTime:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure UpdateFieldValues_TDate(AField, ATable: String; AValue: TDate; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').AsDate:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure UpdateFieldValues_Boolean(AField, ATable: String; AValue: Boolean; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').AsBoolean:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure UpdateFieldValues_Integer(AField, ATable: String; AValue: Integer; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').AsInteger:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure UpdateFieldValues_Float(AField, ATable: String; AValue: Double; AID:Integer);
var
  qry_Update: TFDQuery;
begin
  qry_Update:= TFDQuery.Create(nil);
  qry_Update.Connection:= dmmain.con_PCM;
  qry_Update.SQL.Text:= 'Update ' + ATable + ' Set ' + AField + '=:AValue Where ID = :ID';
  qry_Update.ParamByName('Avalue').AsFloat:= AValue;
  qry_Update.ParamByName('ID').AsInteger:= AID;
  qry_Update.ExecSQL;
  FreeAndNil(qry_Update);
end;
procedure BerechneMonat(AMonat,AJahr: integer);
	procedure WriteMonatswert(ARest: Double;AaktGLZ,AMonat,AJahr,ASollzeit,AIStzeit,AMehrarbeit,APausen,AFeiertag: integer; AUrlaub_bezahlt,AUrlaub_unbezahlt,AKrank_bezahlt,AKrank_unbezahlt: double);
	var
  	iAnzahl: integer;
  	qry_MW: TFDQuery;
	begin
    qry_MW:= TFDQuery.Create(nil);
    qry_MW.Connection:= dmmain.con_PCM;
    qry_MW.SQL.Text:= 'SELECT Count(*) as Anzahl From Monatswerte Where Monat = :Monat and Jahr = :Jahr and ID_Benutzer = :ID';
    qry_MW.ParamByName('monat').AsInteger:= AMonat;
    qry_MW.ParamByName('jahr').AsInteger:= AJahr;
    qry_MW.ParamByName('ID').AsInteger:= dmmain.iUserID;
    qry_MW.open;
    iAnzahl:= qry_MW.FieldByName('Anzahl').AsInteger;
    qry_MW.Close;
    if iAnzahl > 0 then
    begin
      qry_MW.SQL.Text:= 'Update Monatswerte ' +
                    'Set Sollzeit = :Sollzeit, ' +
                    'aktuelleMehrarbeit = :aktuelleMehrarbeit,'+
                    'IStzeit = :IStzeit, ' +
                    'Mehrarbeit = :Mehrarbeit, ' +
                    'Pausen = :Pausen, ' +
                    'Feiertag = :Feiertag, ' +
                    'Urlaub_bezahlt = :Urlaub_bezahlt, ' +
                    'Urlaub_unbezahlt = :Urlaub_unbezahlt, ' +
                    'Krank_bezahlt = :Krank_bezahlt, ' +
                    'Krank_unbezahlt = :Krank_unbezahlt, ' +
                    'Resturlaub = :Resturlaub ' +
                    'Where Monat = :Monat and Jahr = :Jahr and ID_Benutzer = :ID';
      qry_MW.ParamByName('aktuelleMehrarbeit').AsInteger:= AaktGLZ + AMehrarbeit;
      qry_MW.ParamByName('Sollzeit').AsInteger:= ASollzeit;
      qry_MW.ParamByName('IStzeit').AsInteger:= AIStzeit;
      qry_MW.ParamByName('Mehrarbeit').AsInteger:= AMehrarbeit;
      qry_MW.ParamByName('Pausen').AsInteger:= APausen;
      qry_MW.ParamByName('Feiertag').AsInteger:= AFeiertag;
      qry_MW.ParamByName('Urlaub_bezahlt').AsFloat:= AUrlaub_bezahlt;
      qry_MW.ParamByName('Urlaub_unbezahlt').AsFloat:= AUrlaub_unbezahlt;
      qry_MW.ParamByName('Krank_bezahlt').AsFloat:= AKrank_bezahlt;
      qry_MW.ParamByName('Krank_unbezahlt').AsFloat:= AKrank_unbezahlt;
      qry_MW.ParamByName('Resturlaub').AsFloat:= ARest;
      qry_MW.ParamByName('monat').AsInteger:= AMonat;
      qry_MW.ParamByName('jahr').AsInteger:= AJahr;
      qry_MW.ParamByName('ID').AsInteger:= dmmain.iUserID;
      qry_MW.ExecSQL;
    end
    else begin
      qry_MW.SQL.Text:= 'Insert into Monatswerte ' +
                    '(aktuelleMehrarbeit,Resturlaub,Sollzeit,IStzeit,Mehrarbeit,Pausen,Feiertag,Urlaub_bezahlt,Urlaub_unbezahlt,Krank_bezahlt,Krank_unbezahlt,Monat,Jahr,ID_Benutzer) Values ' +
                    '(:aktuelleMehrarbeit,:Resturlaub,:Sollzeit,:IStzeit,:Mehrarbeit,:Pausen,:Feiertag,:Urlaub_bezahlt,:Urlaub_unbezahlt,:Krank_bezahlt,:Krank_unbezahlt,:Monat,:Jahr,:ID)';
      qry_MW.ParamByName('aktuelleMehrarbeit').AsInteger:= AaktGLZ + AMehrarbeit;
      qry_MW.ParamByName('Resturlaub').AsFloat:= ARest;
      qry_MW.ParamByName('Sollzeit').AsInteger:= ASollzeit;
      qry_MW.ParamByName('IStzeit').AsInteger:= AIStzeit;
      qry_MW.ParamByName('Mehrarbeit').AsInteger:= AMehrarbeit;
      qry_MW.ParamByName('Pausen').AsInteger:= APausen;
      qry_MW.ParamByName('Feiertag').AsInteger:= AFeiertag;
      qry_MW.ParamByName('Urlaub_bezahlt').AsFloat:= AUrlaub_bezahlt;
      qry_MW.ParamByName('Urlaub_unbezahlt').AsFloat:= AUrlaub_unbezahlt;
      qry_MW.ParamByName('Krank_bezahlt').AsFloat:= AKrank_bezahlt;
      qry_MW.ParamByName('Krank_unbezahlt').AsFloat:= AKrank_unbezahlt;
      qry_MW.ParamByName('monat').AsInteger:= AMonat;
      qry_MW.ParamByName('jahr').AsInteger:= AJahr;
      qry_MW.ParamByName('ID').AsInteger:= dmmain.iUserID;
      qry_MW.ExecSQL;
    end;
    Freeandnil(qry_MW);
  end;
  function GetMehrarbeitVorMonat(AJahr,AMonat: integer): integer;
	var
	  qry_MA: TFDQuery;
	begin
    qry_MA:= TFDQuery.Create(nil);
    qry_MA.Connection:= dmmain.con_PCM;
    qry_MA.SQL.Text:= 'Select aktuelleMehrarbeit From Monatswerte Where ID_Benutzer = :ID and Jahr = :Jahr and Monat = :Monat';
    qry_MA.ParamByName('ID').AsInteger:= dmmain.iUserID;
    qry_MA.ParamByName('Jahr').AsInteger:= AJahr;
    qry_MA.ParamByName('Monat').AsInteger:= AMonat;
    qry_MA.open;
    result:= qry_MA.FieldByName('aktuelleMehrarbeit').AsInteger;
    qry_MA.close;
    Freeandnil(qry_MA);
	end;
  function GetULVorjahr(AJahr,AMonat: integer) : double;
	var
	  qry_UL: TFDQuery;
	begin
    qry_UL:= TFDQuery.Create(nil);
    qry_UL.Connection:= dmmain.con_PCM;
    qry_UL.SQL.Text:= 'Select Resturlaub From Monatswerte Where ID_Benutzer = :ID and Jahr = :Jahr and Monat = :Monat';
    qry_UL.ParamByName('ID').AsInteger:= dmmain.iUserID;
    qry_UL.ParamByName('Jahr').AsInteger:= AJahr;
    qry_UL.ParamByName('Monat').AsInteger:= AMonat;
    qry_UL.open;
    result:= qry_UL.FieldByName('Resturlaub').AsFloat;
    qry_UL.Close;
    FreeAndNil(qry_UL);
	end;
	function GetULVormonat(AJahr,AMonat: integer) : double;
	var
  	qry_UL: TFDQuery;
	begin
    qry_UL:= TFDQuery.Create(nil);
    qry_UL.Connection:= dmmain.con_PCM;
    qry_UL.SQL.Text:= 'Select Resturlaub From Monatswerte Where ID_Benutzer = :ID and Jahr = :Jahr and Monat = :Monat';
    qry_UL.ParamByName('ID').AsInteger:= dmmain.iUserID;
    qry_UL.ParamByName('Jahr').AsInteger:= AJahr;
    qry_UL.ParamByName('Monat').AsInteger:= AMonat;
    qry_UL.open;
    result:= qry_UL.FieldByName('Resturlaub').AsFloat;
    qry_UL.Close;
    FreeAndNil(qry_UL);
	end;
var
  iSollzeit: integer;
  iIStzeit: integer;
  iMehrarbeit: integer;
  iFeiertag: integer;
  iPausen: integer;
  iUrlaub_bezahlt: double;
  iUrlaub_unbezahlt: double;
  iKrank_bezahlt: double;
  iKrank_unbezahlt: double;
  fULges: double;
  fResturlaub: double;
  fULgen: double;
  fJahresAnspruch: double;
  iaktGLZ: integer;
  iVMonat: integer;
  ivJahr: integer;
  fOffsetResturlaub: double;
  iOffsetResturlaubJahr: integer;
  qry_Work1: TFDQuery;
begin
  iVMonat := AMonat -1;
  iVJahr:= Ajahr;
  if iVMonat = 0 then
  begin
    iVMonat := 12;
    iVJahr:= Ajahr-1;
  end;
  fResturlaub:= GetULVorMonat(iVJahr,iVMonat);
  iaktGLZ:= GetMehrarbeitVorMonat(iVJahr,iVMonat);
  fULgen:= GetFehltagSum(1,1,1,StartOfAMonth(AJahr,AMonat) ,EndOfAMonth(AJahr,AMonat));
  fJahresAnspruch:= 30;
  qry_Work1:= TFDQuery.Create(nil);
  qry_Work1.Connection:= dmmain.con_PCM;
  qry_Work1.SQL.Text:= 'SELECT OffsetResturlaubJahr,OffsetResturlaub From kontakte';
  qry_Work1.Open;
  fOffsetResturlaub:= qry_Work1.FieldByName('OffsetResturlaub').AsFloat;
  iOffsetResturlaubJahr:= qry_Work1.FieldByName('OffsetResturlaubJahr').AsInteger;
  qry_Work1.Close;
  if (iOffsetResturlaubJahr = iVJahr) and (iVMonat = 12) then
  begin
    fResturlaub:= fOffsetResturlaub;
  end;
  qry_Work1.SQL.Text:= 'SELECT IFNULL(SUM(SollstundenI),0) AS Sollstunden,' +
                       'IFNULL(SUM(ArbeitszeitI),0) AS Arbeitszeit,' +
                       'IFNULL(SUM(MehrarbeitI),0) AS Mehrarbeit,' +
                       'IFNULL(SUM(PausenI),0) AS Pausen,' +
                       'IFNULL(SUM(FeiertagI),0) AS Feiertag ' +
                       'FROM buchungen ' +
                       'WHERE Datum BETWEEN :Von AND :Bis';

  qry_Work1.ParamByName('Von').AsDate:= StartofAMonth(Ajahr,AMonat);
  qry_Work1.ParamByName('Bis').AsDate:= EndofAMonth(Ajahr,AMonat);
  qry_Work1.Open;
  iSollzeit:= qry_Work1.FieldByName('Sollstunden').AsInteger;
  iIStzeit:= qry_Work1.FieldByName('Arbeitszeit').AsInteger;
  iMehrarbeit:= qry_Work1.FieldByName('Mehrarbeit').AsInteger;
  iPausen:= qry_Work1.FieldByName('Pausen').AsInteger;
  iFeiertag:= qry_Work1.FieldByName('Feiertag').AsInteger;
  qry_Work1.Close;
  iUrlaub_bezahlt:= GetFehltagSum(1,1,1,StartOfAMonth(AJahr,AMonat) ,EndOfAMonth(AJahr,AMonat));
  iUrlaub_unbezahlt:= GetFehltagSum(1,1,2,StartOfAMonth(AJahr,AMonat) ,EndOfAMonth(AJahr,AMonat));
  iKrank_bezahlt:= GetFehltagSum(1,2,1,StartOfAMonth(AJahr,AMonat) ,EndOfAMonth(AJahr,AMonat));
  iKrank_unbezahlt:= GetFehltagSum(1,2,2,StartOfAMonth(AJahr,AMonat) ,EndOfAMonth(AJahr,AMonat));
  qry_Work1.close;
  Freeandnil(qry_Work1);
  if AMonat = 1 then
    fULges:=  fResturlaub - fULgen + fJahresAnspruch
  else
    fULges:=  fResturlaub - fULgen;
  WriteMonatswert(fUlges,iaktGLZ, AMonat,AJahr,iSollzeit,iIStzeit,iMehrarbeit,iPausen,iFeiertag,iUrlaub_bezahlt,iUrlaub_unbezahlt,iKrank_bezahlt,iKrank_unbezahlt);
end;
procedure BerechneTage(ATag,AMonat,AJahr: integer);
  procedure GetKorrekturAssistent(AKommen,AGehen,Pause1Beginn,Pause1Ende,Pause2Beginn,Pause2Ende,ASollStunden:TTime);
  begin
    if ASollStunden <> StrToTime('00:00') then
    begin
    end;
  end;
var
  iArbeitszeit: integer;
  iFehltag: integer;
  iFeiertag: integer;
  iMehrarbeit: integer;
  iPause1: integer;
  iPause2: integer;
  iSollstunden: integer;
  qry_Calc,qry_Calc2: TFDQuery;
begin
  qry_Calc:= TFDQuery.Create(nil);
  qry_Calc.Connection:= dmmain.con_PCM;
  qry_Calc2:= TFDQuery.Create(nil);
  qry_Calc2.Connection:= dmmain.con_PCM;
  if ATag = 0 then
  begin
    qry_Calc.SQL.Text:= 'SELECT ze_b.*, ze_FT.* FROM buchungen ze_B ' +
                        'LEFT OUTER  JOIN Fehltag ze_ft ON ze_ft.Kuerzel = ze_B.Fehltag ' +
                        'WHERE Year(ze_B.Datum) = :Jahr and Month(ze_B.Datum) = :Monat order by ze_B.Datum';
    qry_Calc.ParamByName('Monat').AsInteger:= AMonat;
    qry_Calc.ParamByName('jahr').AsInteger:= AJahr;
  end
  else begin
    qry_Calc.SQL.Text:= 'SELECT ze_b.*, ze_FT.* FROM buchungen ze_B ' +
                        'LEFT OUTER  JOIN Fehltag ze_ft ON ze_ft.Kuerzel = ze_B.Fehltag ' +
                        'WHERE ze_B.Datum = :Datum order by ze_B.Datum';
    qry_Calc.ParamByName('Datum').AsDate:= EncodeDate(AJahr,AMonat,ATag);
  end;
  qry_Calc.open;
  while not qry_Calc.eof do
  begin
     iFehltag:= 0;
    iFeiertag:= 0;
    iSollstunden:= 0;
    if qry_Calc.FieldByName('Datum').asDateTime < Date then
    begin
      iSollstunden:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
      if ((qry_Calc.FieldByName('Bezahlt').AsInteger = 1) and  (qry_Calc.FieldByName('Faktor').AsInteger = 1))  then
      begin
        iFehltag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
         if qry_Calc.FieldByName('SollAbziehen').AsInteger = 1 then
          iFehltag:= 0;
      end;
       if ((qry_Calc.FieldByName('Bezahlt').AsInteger = 0) and  (qry_Calc.FieldByName('SollAbziehen').AsInteger = 1))  then
        iSollstunden:= 0;
      if  ((qry_Calc.FieldByName('Bezahlt').AsInteger = 1) and  (qry_Calc.FieldByName('Faktor').AsInteger = 2)) then
        iFehltag:= Round(MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00')) / 2);
      if (qry_Calc.FieldByName('Feiertag').AsInteger = 2) then
        iFeiertag:= Round(MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00')) / 2);
      if (qry_Calc.FieldByName('Feiertag').AsInteger = 1) then
        iFeiertag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
      if (iFeiertag = iFehltag) and (iFeiertag = 480) then
        iFehltag := 0;
      iArbeitszeit:= MinutesBetween(qry_Calc.FieldByName('Gehen').asDateTime,qry_Calc.FieldByName('Kommen').asDateTime);
      iPause1:= MinutesBetween(qry_Calc.FieldByName('Pause1Ende').asDateTime,qry_Calc.FieldByName('Pause1Beginn').asDateTime);
      iPause2:= MinutesBetween(qry_Calc.FieldByName('Pause2Ende').asDateTime,qry_Calc.FieldByName('Pause2Beginn').asDateTime);
//      GetKorrekturAssistent(qry_Calc.FieldByName('Kommen').asDateTime,qry_Calc.FieldByName('Gehen').asDateTime,
//                            qry_Calc.FieldByName('Pause1Beginn').asDateTime,qry_Calc.FieldByName('Pause1Ende').asDateTime,
//                            qry_Calc.FieldByName('Pause2Beginn').asDateTime,qry_Calc.FieldByName('Pause2Ende').asDateTime,
//                            qry_Calc.FieldByName('Sollstunden').asDateTime);
    end
    else begin
      if qry_Calc.FieldByName('Datum').asDateTime = Date then
      begin
        iSollstunden:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').AsDateTime,StrToTime('00:00'));
        // Bezahlte Abwesenheit ganzer Tag
        if ((qry_Calc.FieldByName('Bezahlt').AsInteger = 1) and  (qry_Calc.FieldByName('Faktor').AsInteger = 1))  then
          iFehltag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
        // Bezahlte Abwesenheit halber Tag
        if  ((qry_Calc.FieldByName('Bezahlt').AsInteger = 1) and  (qry_Calc.FieldByName('Faktor').AsInteger = 2)) then
          iFehltag:= Round(MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00')) / 2);
        if (qry_Calc.FieldByName('Feiertag').AsInteger = 2) then
          iFeiertag:= Round(MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00')) / 2);
        if (qry_Calc.FieldByName('Feiertag').AsInteger = 1) then
          iFeiertag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
        if (iFeiertag = iFehltag) and (iFeiertag = 480) then
          iFehltag := 0;
      end;
      if (qry_Calc.FieldByName('Bezahlt').AsInteger > 0 ) or ((qry_Calc.FieldByName('Feiertag').AsInteger > 0 ) and (qry_Calc.FieldByName('Sollstunden').AsDateTime <> StrToTime('00:00:00'))) then
      begin
        iSollstunden:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
        // Bezahlte Abwesenheit ganzer Tag
        if ((qry_Calc.FieldByName('Bezahlt').AsInteger = 1) and  (qry_Calc.FieldByName('Faktor').AsInteger = 1))  then
          iFehltag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
        // Bezahlte Abwesenheit halber Tag
        if  ((qry_Calc.FieldByName('Bezahlt').AsInteger = 1) and  (qry_Calc.FieldByName('Faktor').AsInteger = 2)) then
          iFehltag:= Round(MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00')) / 2);
        if (qry_Calc.FieldByName('Feiertag').AsInteger = 2) then
          iFeiertag:= Round(MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00')) / 2);
        if (qry_Calc.FieldByName('Feiertag').AsInteger = 1) then
          iFeiertag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
        if (iFeiertag = iFehltag) and (iFeiertag = 480) then
          iFehltag := 0;
      end;



















      // Arbeitszeit
      if (qry_Calc.FieldByName('Kommen').asDateTime <> StrToTime('00:00:00')) and (qry_Calc.FieldByName('Gehen').asDateTime = StrToTime('00:00:00')) then
      begin
        iArbeitszeit:= MinutesBetween(TimeOf(Now),qry_Calc.FieldByName('Kommen').asDateTime);
      end
      else begin
        iArbeitszeit:= MinutesBetween(qry_Calc.FieldByName('Gehen').asDateTime,qry_Calc.FieldByName('Kommen').asDateTime);
      end;
      // Pause 1
      if (qry_Calc.FieldByName('Pause1Beginn').asDateTime <> StrToTime('00:00:00')) and (qry_Calc.FieldByName('Pause1Ende').asDateTime = StrToTime('00:00:00')) then
      begin
        iPause1:= 0
      end
      else begin
        iPause1:= MinutesBetween(qry_Calc.FieldByName('Pause1Ende').asDateTime,qry_Calc.FieldByName('Pause1Beginn').asDateTime);
      end;
      // Pause 2
      if (qry_Calc.FieldByName('Pause2Beginn').asDateTime <> StrToTime('00:00:00')) and (qry_Calc.FieldByName('Pause2Ende').asDateTime = StrToTime('00:00:00')) then
      begin
        iPause2:= 0
      end
      else begin
        iPause2:= MinutesBetween(qry_Calc.FieldByName('Pause2Ende').asDateTime,qry_Calc.FieldByName('Pause2Beginn').asDateTime);
      end;
    end;
    iMehrarbeit:= iArbeitszeit - iSollstunden - iPause1 - iPause2 + iFehltag + iFeiertag;
    qry_Calc2.SQL.Text:= 'Update buchungen set ' +
                              'SollstundenI = :SollstundenI,' +
                              'ArbeitszeitI = :ArbeitszeitI,' +
                              'Arbeitszeit = :Arbeitszeit,' +
                              'MehrarbeitI = :MehrarbeitI,' +
                              'Mehrarbeit = :Mehrarbeit,' +
                              'PausenI = :PausenI,' +
                              'FeiertagI = :FeiertagI ' +
                              'Where Datum = :Datum';
    qry_Calc2.ParamByname('SollstundenI').AsInteger:= iSollstunden;
    qry_Calc2.ParamByname('ArbeitszeitI').AsInteger:= iArbeitszeit - iPause1 - iPause2 + iFehltag + iFeiertag;
    if (iArbeitszeit - iPause1 - iPause2 + iFehltag + iFeiertag) < 0 then
    begin
      qry_Calc2.ParamByname('Arbeitszeit').asString:= '-' + GetTimeValue((iArbeitszeit - iPause1 - iPause2 + iFehltag + iFeiertag) * -1);
    end
    else begin
      qry_Calc2.ParamByname('Arbeitszeit').asString:= GetTimeValue(iArbeitszeit - iPause1 - iPause2 + iFehltag + iFeiertag);
    end;
    qry_Calc2.ParamByname('MehrarbeitI').AsInteger:= iMehrarbeit;
    if iMehrarbeit < 0  then
      qry_Calc2.ParamByname('Mehrarbeit').asString:= '-' + GetTimeValue(iMehrarbeit *-1)
    else
      qry_Calc2.ParamByname('Mehrarbeit').asString:= GetTimeValue(iMehrarbeit);
    qry_Calc2.ParamByname('PausenI').AsInteger:= iPause1 + iPause2;
    qry_Calc2.ParamByname('FeiertagI').AsInteger:= iFeiertag;
    qry_Calc2.ParamByname('Datum').AsDate:= qry_Calc.FieldByName('Datum').AsDateTime;
    qry_Calc2.execsql;
    qry_Calc.next;
  end;
  qry_Calc.close;
  FreeAndNil(qry_Calc2);
  FreeAndNil(qry_Calc);
end;
procedure ClearAllTablesByID(AID: Integer; AColumnName: String);
var
  bLoescheTabelle: Boolean;
  qry_TabellenInfo,
  qry_LoescheTabelle: TFDQuery;
  sTabellenName: String;
begin
  qry_TabellenInfo := TFDQuery.Create(nil);
  try
    qry_TabellenInfo.Connection := dmmain.con_PCM;
    qry_LoescheTabelle := TFDQuery.Create(nil);
    try
      qry_LoescheTabelle.Connection := dmmain.con_PCM;
      qry_TabellenInfo.Open('SELECT name FROM sqlite_master WHERE type = ''table''');
      while not qry_TabellenInfo.Eof do
      begin
        bLoescheTabelle := False;
        sTabellenName := qry_TabellenInfo.FieldByName('name').AsString;
        qry_LoescheTabelle.Open('PRAGMA table_info(' + QuotedStr(sTabellenName) + ')');
        while not qry_LoescheTabelle.Eof do
        begin
          if qry_LoescheTabelle.FieldByName('name').AsString = AColumnName then
          begin
            bLoescheTabelle := True;
            Break;
          end;
          qry_LoescheTabelle.Next;
        end;
        qry_LoescheTabelle.Close;
        if bLoescheTabelle then
          qry_LoescheTabelle.ExecSQL('DELETE FROM ' + sTabellenName + ' WHERE ' + AColumnName + ' = ' + IntToStr(AID));
        qry_TabellenInfo.Next;
      end;
    finally
      qry_LoescheTabelle.Close;
      FreeAndNil(qry_LoescheTabelle);
    end;

  finally
    qry_TabellenInfo.Close;
    FreeAndNil(qry_TabellenInfo);
  end;

end;
procedure CreateDatabase;
var
  iDatenBankVersion: integer;
  qry_ErzeugeTabelle: TFDQuery;
begin
  qry_ErzeugeTabelle:= TFDQuery.Create(nil);
  qry_ErzeugeTabelle.Connection:= dmmain.con_PCM;
  qry_ErzeugeTabelle.SQL.text:= sSQL_SELECT_USERVERSION_PRAGMASYSTEM;
  qry_ErzeugeTabelle.Open;
  iDatenBankVersion := qry_ErzeugeTabelle.FieldByName('user_Version').AsInteger;
  qry_ErzeugeTabelle.Close;
  FreeAndNil(qry_ErzeugeTabelle);
  if iDatenBankVersion < 1 then
  begin
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_SERVER);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_Login);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_Autologin);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_LastBooking);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_SynchBooking);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_Buchungen);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_Fehltag);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_Fehltage);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_Monatswerte);
    dmmain.con_PCM.ExecSQL(sSQL_CREATE_TABLE_Kontakte);
    dmmain.con_PCM.ExecSQL(sSQL_UPDATE_USERVERSION_PRAGMASYSTEM + IntToStr(iDatenBankVersion + 1));
  end;
end;
procedure DeleteAllTables;
begin
  dmmain.con_PCM.ExecSQL(sSQL_UPDATE_WRITABLE_SCHEMA_PRAGMASYSTEM + '1');
  dmmain.con_PCM.ExecSQL(sSQL_DELETE_ALL_TABLES_SYSTEM);
  dmmain.con_PCM.ExecSQL(sSQL_UPDATE_WRITABLE_SCHEMA_PRAGMASYSTEM + '0');
  dmmain.con_PCM.ExecSQL(sSQL_UPDATE_USERVERSION_PRAGMASYSTEM + '0');
  dmmain.con_PCM.Connected := False;
  dmmain.con_PCM.Connected := True;
end;
procedure SaveLogin(AUsername, APassword: String; AUserID, AServerID: Integer;AFirstStart: Boolean);
var
  iCount: integer;
  qry_Sync: TFDQuery;
begin
  qry_Sync:= TFDQuery.Create(nil);
  qry_Sync.Connection:= dmmain.con_PCM;
  qry_Sync.SQL.Text:= sSQL_SEL_COUNT_login;
  qry_Sync.Open;
  iCount:= qry_Sync.FieldByName('Anzahl').AsInteger;
  qry_Sync.Close;
  if (AFirstStart) and (iCount = 0)  then
  begin
    qry_Sync.SQL.Text := sSQL_INS_All_login;
    qry_Sync.ParamByName('ID_Benutzer').AsInteger := AUserID;
    qry_Sync.ParamByName('Benutzername').AsString := AUsername;
    qry_Sync.ParamByName('Passwort').AsString := APassword;
    qry_Sync.ParamByName('FirstStart').AsBoolean := True;
    qry_Sync.ParamByName('ID_Server').AsInteger := AServerID;
    qry_Sync.ExecSQL;
  end else
  begin
    qry_Sync.SQL.Text := sSQL_UPD_ALL_login;
    qry_Sync.ParamByName('ID_Benutzer').AsInteger := AUSerID;
    qry_Sync.ParamByName('Benutzername').AsString := AUsername;
    qry_Sync.ParamByName('Passwort').AsString := APassword;
    qry_Sync.ParamByName('FirstStart').AsBoolean := False;
    qry_Sync.ParamByName('ID_Server').AsInteger := AServerID;
    qry_Sync.ExecSQL;
  end;
  FreeandNil(qry_Sync);
end;
procedure SyncConfig_ToServer(const AUserID: Integer; AWaitFrame: TWaitForm);
var
  qry_SyncConfig_ToServer: TFDQuery;
begin
  joResponseJSON:= nil;
  joResponseJSONData:= nil;
  jaDetails:= nil;
  if not Assigned(joResponseJSON) then
    joResponseJSON := TJSONObject.Create;
  qry_SyncConfig_ToServer:= TFDQuery.Create(nil);
  qry_SyncConfig_ToServer.Connection:= dmmain.con_PCM;
  qry_SyncConfig_ToServer.FetchOptions.Mode:= fmall;
  qry_SyncConfig_ToServer.FetchOptions.RecordCountMode:= cmtotal;
  qry_SyncConfig_ToServer.SQL.Text:= 'SELECT DeviceID, DeviceToken FROM Auto_login';
  qry_SyncConfig_ToServer.open;
  if qry_SyncConfig_ToServer.RecordCount > 0 then
  begin
    if not Assigned(jaDetails) then
      jaDetails := TJSONArray.Create;
    while not qry_SyncConfig_ToServer.eof do
    begin
      if not Assigned(joResponseJSONData) then
        joResponseJSONData := TJSONObject.Create;
      joResponseJSONData.AddPair(TJSONPair.Create('ID_Benutzer', TJSONNumber.Create(AUSerID)));
      joResponseJSONData.AddPair(TJSONPair.Create('DeviceToken', TJSONString.Create(qry_SyncConfig_ToServer.FieldByName('DeviceToken').asString)));
      joResponseJSONData.AddPair(TJSONPair.Create('DeviceID', TJSONString.Create(qry_SyncConfig_ToServer.FieldByName('DeviceID').asString)));
      {$IFDEF ANDROID}
      joResponseJSONData.AddPair(TJSONPair.Create('DeviceType', TJSONNumber.Create(0)));
      {$ENDIF ANDROID}
      {$IFDEF IOS}
      joResponseJSONData.AddPair(TJSONPair.Create('DeviceType', TJSONNumber.Create(1)));
      {$ENDIF IOS}

      jaDetails.Add(joResponseJSONData);
      joResponseJSONData:= nil;
      qry_SyncConfig_ToServer.Next;
    end;
    joResponseJSON.AddPair(TJSONPair.Create('Device', jaDetails));
    JSONResult := dmmain.RestRequest(joResponseJSON,'SetDeviceID', rmPUT) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if bHasError then
      WriteLog('nicht Erfolgreich synchronisiert. ErroCode:' + JSONResult.GetValue<TJSONBool>('ErrorCode').ToString,1,false);
  end;
  qry_SyncConfig_ToServer.Close;
  FreeandNil(qry_SyncConfig_ToServer);
end;
procedure SynchAbsence_ToServer(AID: integer; ADelete: boolean);
var
  qry_SynchBooking: TFDQuery;
begin
    qry_SynchBooking:= TFDQuery.Create(nil);
    qry_SynchBooking.Connection:= dmmain.con_PCM;
    qry_SynchBooking.SQL.Text:= 'Select * From Buchungen Where ID = :ID';
    qry_SynchBooking.ParamByName('ID').AsInteger:= AID;
    qry_SynchBooking.open;
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Kommen').AsDateTime,1,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Gehen').AsDateTime,2,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause1Beginn').AsDateTime,3,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause2Ende').AsDateTime,4,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause2Beginn').AsDateTime,5,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause2Ende').AsDateTime,6,1,dmmain.wfWaitFrame,True);
    qry_SynchBooking.Close;
    FreeAndNil(qry_SynchBooking);
    SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
end;
procedure SynchBooking_ToServer(AID: integer);
var
  qry_SynchBooking: TFDQuery;
begin
    qry_SynchBooking:= TFDQuery.Create(nil);
    qry_SynchBooking.Connection:= dmmain.con_PCM;
    qry_SynchBooking.SQL.Text:= 'Select * From Buchungen Where ID = :ID';
    qry_SynchBooking.ParamByName('ID').AsInteger:= AID;
    qry_SynchBooking.open;
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Kommen').AsDateTime,1,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Gehen').AsDateTime,2,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause1Beginn').AsDateTime,3,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause1Ende').AsDateTime,4,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause2Beginn').AsDateTime,5,1,dmmain.wfWaitFrame,True);
    SynchOnlineBooking_ToServer(dmmain.iUserID,qry_SynchBooking.FieldByname('Datum').AsDateTime,qry_SynchBooking.FieldByname('Pause2Ende').AsDateTime,6,1,dmmain.wfWaitFrame,True);
    qry_SynchBooking.Close;
    FreeAndNil(qry_SynchBooking);
    SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
end;
procedure SynchLastBooking_toServer(const AUserID: integer; AWaitFrame: TWaitForm; bALL: Boolean);
var
  qry_SynchConfig: TFDQuery;
begin
  AWaitFrame.SetWaitMessage('Letzte Buchung wird synchronisiert...', 'Synchronisierung');
  joResponseJSON:= nil;
  joResponseJSONData:= nil;
  jaDetails:= nil;
  if not Assigned(joResponseJSON) then
    joResponseJSON := TJSONObject.Create;
  qry_SynchConfig:= TFDQuery.Create(nil);
  qry_SynchConfig.Connection:= dmmain.con_PCM;
  qry_SynchConfig.FetchOptions.Mode:= fmall;
  qry_SynchConfig.FetchOptions.RecordCountMode:= cmtotal;
  qry_SynchConfig.SQL.Text:= sSQL_SELECT_TEXT_LASTBOOKING;
  qry_SynchConfig.open;
  if qry_SynchConfig.RecordCount > 0 then
  begin
    if not Assigned(jaDetails) then
      jaDetails := TJSONArray.Create;
    if not Assigned(joResponseJSONData) then
      joResponseJSONData := TJSONObject.Create;
    joResponseJSONData.AddPair(TJSONPair.Create('LastBooking', TJSONString.Create(qry_SynchConfig.FieldByName('Text').asString)));
    jaDetails.Add(joResponseJSONData);
    joResponseJSONData:= nil;

    joResponseJSON.AddPair(TJSONPair.Create('LastBooking', jaDetails));
    JSONResult := dmmain.RestRequest(joResponseJSON,'SetLastBooking?ID_User='+IntToStr(Auserid), rmPUT) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if bHasError then
      WriteLog('nicht Erfolgreich synchronisiert. ErroCode:' + JSONResult.GetValue<TJSONBool>('ErrorCode').ToString,1,false);
  end;
  qry_SynchConfig.Close;
   FreeandNil(qry_SynchConfig);
  SynchLastBooking_FromServer(AUserID,0,AWaitFrame);
end;

//procedure SynchMonthView(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
//var
//  iCount: integer;
//  qry_SynchConfig: TFDQuery;
//  wJahr,wMonat,wTag: word;
//begin
//  AWaitFrame.SetWaitMessage('Monatswerte werden synchronisiert...', 'Synchronisierung');
//  DecodeDate(Date,wJahr,wMonat,wTag);
//  qry_SynchConfig:= TFDQuery.Create(nil);
//  qry_SynchConfig.Connection:= dmmain.con_PCM;
//
//
//
//
//
//  while not dmMain.sqlSM_HoleMonatswerte.Eof do
//  begin
//    qry_SynchConfig.SQL.Text:= 'Select Count(*) as Anzahl From Monatswerte Where Monat = :Monat and Jahr = :Jahr';
//    qry_SynchConfig.ParamByName('Monat').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Monat').AsInteger;
//    qry_SynchConfig.ParamByName('Jahr').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('jahr').AsInteger;
//
//    qry_SynchConfig.open;
//    iCount:= qry_SynchConfig.FieldByName('Anzahl').AsInteger;
//    qry_SynchConfig.Close;
//    if iCount = 0 then
//    begin
//      qry_SynchConfig.SQL.Text:= 'Insert into Monatswerte ' +
//      '(Monat,Jahr,ID_Benutzer,Sollzeit,IStzeit,Mehrarbeit,aktuelleMehrarbeit,Pausen,Urlaub_bezahlt,Urlaub_unbezahlt,Krank_bezahlt,Krank_unbezahlt,Feiertag,Resturlaub) ' +
//      'Values' +
//      '(:Monat,:Jahr,:ID_Benutzer,:Sollzeit,:IStzeit,:Mehrarbeit,:aktuelleMehrarbeit,:Pausen,:Urlaub_bezahlt,:Urlaub_unbezahlt,:Krank_bezahlt,:Krank_unbezahlt,:Feiertag,:Resturlaub)';
//      qry_SynchConfig.ParamByName('Monat').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Monat').AsInteger;
//      qry_SynchConfig.ParamByName('Jahr').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Jahr').AsInteger;
//      qry_SynchConfig.ParamByName('ID_Benutzer').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('ID_Benutzer').AsInteger;
//      qry_SynchConfig.ParamByName('Sollzeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Sollzeit').AsInteger;
//      qry_SynchConfig.ParamByName('IStzeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('IStzeit').AsInteger;
//      qry_SynchConfig.ParamByName('Mehrarbeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Mehrarbeit').AsInteger;
//      qry_SynchConfig.ParamByName('aktuelleMehrarbeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('aktuelleMehrarbeit').AsInteger;
//      qry_SynchConfig.ParamByName('Pausen').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Pausen').AsInteger;
//      qry_SynchConfig.ParamByName('Urlaub_bezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Urlaub_bezahlt').AsFloat;
//      qry_SynchConfig.ParamByName('Urlaub_unbezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Urlaub_unbezahlt').AsFloat;
//      qry_SynchConfig.ParamByName('Krank_bezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Krank_bezahlt').AsFloat;
//      qry_SynchConfig.ParamByName('Krank_unbezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Krank_unbezahlt').AsFloat;
//      qry_SynchConfig.ParamByName('Feiertag').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Feiertag').AsInteger;
//      qry_SynchConfig.ParamByName('Resturlaub').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Resturlaub').AsFloat;
//      qry_SynchConfig.ExecSQL;
//    end;
//    dmMain.sqlSM_HoleMonatswerte.Next;
//  end;
//  dmMain.sqlSM_HoleMonatswerte.Close;
//  con_SQLConnection.Connected:= false;
//  FreeAndNil(con_SQLConnection);
//  FreeAndNil(qry_SynchConfig);
//end;
procedure SynchOnlineBooking_ToServer(const AUserID: integer; ADate: TDate; ATime: TTime; ABookingType,AHOOffice:Integer; AWaitFrame: TWaitForm; bALL: Boolean);
var
  qry_SynchBookingTel: TFDQuery;
begin
  AWaitFrame.SetWaitMessage('Buchung wird synchronisiert...', 'Synchronisierung');
  joResponseJSON:= nil;
  joResponseJSONData:= nil;
  jaDetails:= nil;
  if not Assigned(joResponseJSON) then
    joResponseJSON := TJSONObject.Create;
  qry_SynchBookingTel:= TFDQuery.Create(nil);
  qry_SynchBookingTel.Connection:= dmmain.con_PCM;
  qry_SynchBookingTel.SQL.Text:= 'Delete From SynchBooking';
  qry_SynchBookingTel.ExecSQL;
  qry_SynchBookingTel.SQL.Text:= 'Insert Into SynchBooking (Datum,Zeit,Typ,Buchungsart) Values (:Datum,:Zeit,:Typ,:Buchungsart)';
  qry_SynchBookingTel.ParamByName('Datum').AsDate:=ADate;
  qry_SynchBookingTel.ParamByName('Zeit').AsTime:=ATime;
  qry_SynchBookingTel.ParamByName('Typ').asInteger:=ABookingType;
  qry_SynchBookingTel.ParamByName('Buchungsart').asInteger:=AHOOffice;
  qry_SynchBookingTel.ExecSQL;

  qry_SynchBookingTel.SQL.Text:= 'Select Datum,Zeit,Typ,Buchungsart From SynchBooking';
  qry_SynchBookingTel.open;
  if qry_SynchBookingTel.RecordCount > 0 then
  begin
    if not Assigned(jaDetails) then
      jaDetails := TJSONArray.Create;
    if not Assigned(joResponseJSONData) then
      joResponseJSONData := TJSONObject.Create;
    joResponseJSONData.AddPair(TJSONPair.Create('Date', TJSONString.Create(DateToStr(qry_SynchBookingTel.FieldByName('Datum').AsDateTime))));
    joResponseJSONData.AddPair(TJSONPair.Create('Time', TJSONString.Create(TimeToStr(qry_SynchBookingTel.FieldByName('Zeit').AsDateTime))));
    joResponseJSONData.AddPair(TJSONPair.Create('Type', TJSONNumber.Create(qry_SynchBookingTel.FieldByName('Typ').AsInteger)));
    joResponseJSONData.AddPair(TJSONPair.Create('Booking_Type', TJSONNumber.Create(qry_SynchBookingTel.FieldByName('Buchungsart').AsInteger)));
    jaDetails.Add(joResponseJSONData);
    joResponseJSONData:= nil;
    joResponseJSON.AddPair(TJSONPair.Create('OnlineBooking', jaDetails));
    JSONResult := dmmain.RestRequest(joResponseJSON,'SetOnlineBooking?ID_User='+ IntToStr(AUserID) , rmPUT) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if bHasError then
      WriteLog('nicht Erfolgreich synchronisiert. ErroCode:' + JSONResult.GetValue<TJSONBool>('ErrorCode').ToString,1,false);
  end;
  qry_SynchBookingTel.Close;
  FreeandNil(qry_SynchBookingTel);
end;
procedure SyncKontakte_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  qry_Sync: TFDQuery;
  iSyncID: Integer;
  iKontakte_ID: integer;
  sSalutation: String;
  sName: String;
  sSurname: String;
  sStreet_private: String;
  sPostalcode_private: String;
  sPlace_private: String;
  sPhone_private: String;
  sMobile_private: String;
  sMail_private: String;
  sBirthday: String;
  sGender: String;
  sMaritalstatus: String;
  sNationality: String;
  sDenomination: String;
  sCompany: String;
  sStreet_business: String;
  sPostalcode_business: String;
  sPlace_business: String;
  sPhone_business: String;
  sMobile_business: String;
  sMail_business: String;
  fVacation: double;
  sEntrance: String;
  fOffsetRemaining_vacation: double;
  iOffsetRemaining_vacation_toYear: integer;
  iPersonnel_number: integer;
  sPlanned_hours: String;
begin
  AWaitFrame.SetWaitMessage('Personaldaten synchronisieren...', 'Synchronisierung');
  qry_Sync:= TFDQuery.Create(nil);
  qry_Sync.Connection:= dmmain.con_PCM;
  try
    JSONResult := dmmain.RestRequest(nil,'GetContactsZE?ID_User='+ IntToStr(AUserID),rmPOST) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if not bHasError then
    begin
      jaDetails :=  JSONResult.GetValue<TJSONArray>('Personal');
      for var JSonValue in jaDetails do
      begin
        JSonValue.TryGetValue<Integer>('ID',iKontakte_ID);
        JSonValue.TryGetValue<String>('Salutation',sSalutation);
        JSonValue.TryGetValue<String>('Name',sName);
        JSonValue.TryGetValue<String>('Surname',sSurname);
        JSonValue.TryGetValue<String>('Street_private', sStreet_private);
        JSonValue.TryGetValue<String>('Postalcode_private',sPostalcode_private);
        JSonValue.TryGetValue<String>('Place_private',sPlace_private);
        JSonValue.TryGetValue<String>('Phone_private',sPhone_private);
        JSonValue.TryGetValue<String>('Mobile_private',sMobile_private);
        JSonValue.TryGetValue<String>('Mail_private',sMail_private);
        JSonValue.TryGetValue<String>('Birthday',sBirthday);
        JSonValue.TryGetValue<String>('Gender',sGender);
        JSonValue.TryGetValue<String>('Maritalstatus',sMaritalstatus);
        JSonValue.TryGetValue<String>('Nationality',sNationality);
        JSonValue.TryGetValue<String>('Denomination',sDenomination);
        JSonValue.TryGetValue<String>('Company',sCompany);
        JSonValue.TryGetValue<String>('Street_business',sStreet_business);
        JSonValue.TryGetValue<String>('Postalcode_business',sPostalcode_business);
        JSonValue.TryGetValue<String>('Place_business',sPlace_business);
        JSonValue.TryGetValue<String>('Phone_business',sPhone_business);
        JSonValue.TryGetValue<String>('Mobile_business',smobile_business);
        JSonValue.TryGetValue<String>('Mail_business',sMail_business);
        JSonValue.TryGetValue<Float64>('Vacation',fVacation);
        JSonValue.TryGetValue<String>('Entrance',sEntrance);
        JSonValue.TryGetValue<Float64>('OffsetRemaining_vacation',fOffsetRemaining_vacation);
        JSonValue.TryGetValue<integer>('OffsetRemaining_vacation_toYear',iOffsetRemaining_vacation_toYear);
        JSonValue.TryGetValue<integer>('Personnel_number',iPersonnel_number);
        JSonValue.TryGetValue<string>('Planned_hours',sPlanned_hours);
        qry_Sync.SQL.Text:= 'SELECT ID FROM Kontakte';
        qry_Sync.open;
        if qry_Sync.RecordCount > 0 then
        begin
          iSyncID:= qry_Sync.FieldByName('ID').AsInteger;
          if sBirthday<> '' then UpdateFieldValues_TDate('Geburtsdatum','Kontakte',StrToDate(sBirthday),iSyncID);
          if sCompany <> '' then UpdateFieldValues_String('Firma','Kontakte',sCompany,iSyncID);
          if sPhone_private <> '' then UpdateFieldValues_String('Telefon','Kontakte',sPhone_private,iSyncID);
          if sMobile_private <> '' then UpdateFieldValues_String('Handy','Kontakte',sMobile_private,iSyncID);
          if sPhone_business <> '' then UpdateFieldValues_String('TelefonFirma','Kontakte',sPhone_business,iSyncID);
          if smobile_business <> '' then UpdateFieldValues_String('HandyFirma','Kontakte',smobile_business,iSyncID);
          if sMail_private <> '' then UpdateFieldValues_String('Email','Kontakte',sMail_private,iSyncID);
          if sMail_business <> '' then UpdateFieldValues_String('EmailFirma','Kontakte',sMail_business,iSyncID);
          if sStreet_private <> '' then	UpdateFieldValues_String('Strasse','Kontakte',sStreet_private,iSyncID);
          if sPostalcode_private <> '' then UpdateFieldValues_String('PLZ','Kontakte',sPostalcode_private,iSyncID);
          if sPlace_private <> '' then UpdateFieldValues_String('Ort','Kontakte',sPlace_private,iSyncID);
          if sStreet_business <> '' then UpdateFieldValues_String('StrasseFirma','Kontakte',sStreet_business,iSyncID);
          if sPostalcode_business <> '' then	UpdateFieldValues_String('PLZFirma','Kontakte',sPostalcode_business,iSyncID);
          if sPlace_business <> '' then	UpdateFieldValues_String('OrtFirma','Kontakte',sPlace_business,iSyncID);
          if sSalutation <> '' then UpdateFieldValues_String('Anrede','Kontakte',sSalutation,iSyncID);
          if sGender <> '' then UpdateFieldValues_String('Geschlecht','Kontakte',sGender,iSyncID);
          if sMaritalstatus<> '' then	UpdateFieldValues_String('Familienstand','Kontakte',sMaritalstatus,iSyncID);
          if sNationality <> '' then UpdateFieldValues_String('Staatsangehoerigkeit','Kontakte',sNationality,iSyncID);
          if sDenomination <> '' then UpdateFieldValues_String('Konfession','Kontakte',sDenomination,iSyncID);
          if sName <> '' then	UpdateFieldValues_String('Vorname','Kontakte',sName,iSyncID);
          if sSurname <> '' then UpdateFieldValues_String('Nachname','Kontakte',sSurname,iSyncID);
          if FloatToStr(fVacation) <> '' then	UpdateFieldValues_Float('Urlaub','Kontakte',fVacation,iSyncID);
          if sEntrance <> '' then	UpdateFieldValues_TDate('Eintritt','Kontakte',StrToDate(sEntrance),iSyncID);
          if FloatToStr(fOffsetRemaining_vacation) <> '' then	UpdateFieldValues_Float('OffsetResturlaub','Kontakte',fOffsetRemaining_vacation,iSyncID);
          if IntToStr(iOffsetRemaining_vacation_toYear) <> '' then	UpdateFieldValues_Float('OffsetResturlaubJahr','Kontakte',iOffsetRemaining_vacation_toYear,iSyncID);
          if IntToStr(iPersonnel_number) <> '' then	UpdateFieldValues_Float('Personalnummer','Kontakte',iPersonnel_number,iSyncID);
          if sPlanned_hours <> '' then	UpdateFieldValues_TTime('Sollstunden','Kontakte',StrToTime(sPlanned_hours),iSyncID);
        end
        else begin
          qry_Sync.SQL.Text := 'INSERT INTO Kontakte (Urlaub,Eintritt,OffsetResturlaub,OffsetResturlaubJahr,Sollstunden,Personalnummer, Anrede,Vorname, Nachname, Strasse, PLZ, Ort, Telefon, Handy, Email, Geburtsdatum,'+
                               'Geschlecht, Familienstand, Staatsangehoerigkeit,Konfession,Firma,StrasseFirma,PLZFirma,OrtFirma,TelefonFirma,HandyFirma,EmailFirma) VALUES ' +
                               '(:Urlaub,:Eintritt,:OffsetResturlaub,:OffsetResturlaubJahr,:Sollstunden,:Personalnummer,:Anrede,:Vorname, :Nachname, :Strasse, :PLZ, :Ort, :Telefon, :Handy, :Email, :Geburtsdatum, :Geschlecht, :Familienstand, :Staatsangehoerigkeit,' +
                               ':Konfession,:Firma,:StrasseFirma,:PLZFirma,:OrtFirma,:TelefonFirma,:HandyFirma,:EmailFirma)';
          qry_Sync.ParamByName('Anrede').AsString := sSalutation;
          qry_Sync.ParamByName('Vorname').AsString := sName;
          qry_Sync.ParamByName('Nachname').AsString := sSurname;
          qry_Sync.ParamByName('Strasse').AsString := sStreet_private;
          qry_Sync.ParamByName('PLZ').AsString := sPostalcode_private;
          qry_Sync.ParamByName('Ort').AsString := sPlace_private;
          qry_Sync.ParamByName('Telefon').AsString := sPhone_private;
          qry_Sync.ParamByName('Handy').AsString := sMobile_private;
          qry_Sync.ParamByName('Email').AsString := sMail_private;
          if sBirthday = '' then
            qry_Sync.ParamByName('Geburtsdatum').AsDate := StrToDate('30.12.1899')
          else
            qry_Sync.ParamByName('Geburtsdatum').AsDate := StrToDate(sBirthday);
          qry_Sync.ParamByName('Geschlecht').AsString := sGender;
          qry_Sync.ParamByName('Familienstand').AsString := sMaritalstatus;
          qry_Sync.ParamByName('Staatsangehoerigkeit').AsString := sNationality;
          qry_Sync.ParamByName('Konfession').AsString := sDenomination;
          qry_Sync.ParamByName('Firma').AsString := sCompany;
          qry_Sync.ParamByName('StrasseFirma').AsString := sStreet_business;
          qry_Sync.ParamByName('PLZFirma').AsString := sPostalcode_business;
          qry_Sync.ParamByName('OrtFirma').AsString := sPlace_business;
          qry_Sync.ParamByName('TelefonFirma').AsString := sPhone_business;
          qry_Sync.ParamByName('HandyFirma').AsString := smobile_business ;
          qry_Sync.ParamByName('EmailFirma').AsString := sMail_business;

          qry_Sync.ParamByName('Urlaub').AsFloat:= fVacation;
          qry_Sync.ParamByName('Eintritt').AsDate := StrToDate(sEntrance);
          qry_Sync.ParamByName('OffsetResturlaub').AsFloat := fOffsetRemaining_vacation;
          qry_Sync.ParamByName('OffsetResturlaubJahr').AsInteger := iOffsetRemaining_vacation_toYear;
          qry_Sync.ParamByName('Sollstunden').AsTime := StrToTime(sPlanned_hours);
          qry_Sync.ParamByName('Personalnummer').asInteger := iPersonnel_number;
          qry_Sync.ExecSQL;
        end;
      end;
    end;
  except
    on e:exception do
    begin
      WriteLog(e.Message,0,false);
    end;
  end;
  qry_Sync.Close;
  qry_Sync.SQL.Text:= 'Update Kontakte set Geburtsdatum = NULL Where Geburtsdatum = :Datum';
  qry_Sync.ParamByName('Datum').AsDate:= StrToDate('30.12.1899');
  qry_Sync.ExecSQL;
  FreeAndNil(qry_Sync);
end;
procedure SynchLastBooking_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  qry_SyncLastBooking: TFDQuery;
  sLastBooking: string;
  iSyncID: integer;
begin
  AWaitFrame.SetWaitMessage('Letzte Buchung wird ermittelt ...', 'Synchronisierung');
  qry_SyncLastBooking:= TFDQuery.Create(nil);
  qry_SyncLastBooking.Connection:= dmmain.con_PCM;
  try
    JSONResult := dmmain.RestRequest(nil,'GetLastBooking?ID_User='+ IntToStr(AUserID),rmPOST) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if not bHasError then
    begin
      jaDetails :=  JSONResult.GetValue<TJSONArray>('LastBooking');
      for var JSonValue in jaDetails do
      begin
        JSonValue.TryGetValue<String>('LastBooking',sLastBooking);
        qry_SyncLastBooking.SQL.Text:= 'SELECT ID FROM LastBooking';
        qry_SyncLastBooking.open;
        if qry_SyncLastBooking.RecordCount > 0 then
        begin
          iSyncID:= qry_SyncLastBooking.FieldByName('ID').AsInteger;
          if sLastBooking <> '' then UpdateFieldValues_String('Text','LastBooking',sLastBooking,iSyncID);
        end
        else begin
          qry_SyncLastBooking.SQL.Text:= 'Insert into LastBooking (Text) Values (:Text)';
          qry_SyncLastBooking.ParamByName('Text').asString := sLastBooking;
          qry_SyncLastBooking.ExecSQL;
        end;
      end;
    end;
  except
    on e:exception do
    begin
      WriteLog(e.Message,0,false);
    end;
  end;
  qry_SyncLastBooking.Close;
  FreeAndNil(qry_SyncLastBooking);
end;
procedure SynchBookingYear_FromServer(const AUserID, AServerID, AJahr: Integer; AWaitFrame: TWaitForm);
var
  iCount: integer;
  qry_SynchConfig: TFDQuery;
  wJahr,wMonat,wTag: word;
  sDate: string;
  sDay: string;
  sWork_begin: string;
  sWork_end: string;
  sBreak1_begin: string;
  sBreak1_end: string;
  sBreak2_begin: string;
  sBreak2_end: string;
  sPlanned_hours_Time: string;
  iPlanned_hours_Integer: integer;
  sWorking_time_Time: string;
  iWorking_time_Integer: integer;
  iHoliday: integer;
  sAbsence_day: String;
  sOvertime_Time: string;
  iOvertime_Integer: integer;
  iBreak_Integer: integer;
  iHoliday_Integer: integer;
  iComplete: integer;
  iBooking_type: integer;
  iID_Absence_day: integer;
begin
  AWaitFrame.SetWaitMessage('Buchungsübersicht wird synchronisiert...', 'Synchronisierung');
  DecodeDate(Date,wJahr,wMonat,wTag);
  qry_SynchConfig:= TFDQuery.Create(nil);
  qry_SynchConfig.Connection:= dmmain.con_PCM;
  try
    JSONResult := dmmain.RestRequest(nil,'GetBookingYear?ID_User='+ IntToStr(AUserID)+'&Year='+IntToStr(AJahr),rmPOST) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if not bHasError then
    begin
      jaDetails :=  JSONResult.GetValue<TJSONArray>('Booking');
      for var JSonValue in jaDetails do
      begin
        JSonValue.TryGetValue<String>('Date',sDate);
        JSonValue.TryGetValue<String>('Day',sDay);
        JSonValue.TryGetValue<String>('Work_begin',sWork_begin);
        JSonValue.TryGetValue<String>('Work_end',sWork_end);
        JSonValue.TryGetValue<String>('Break1_begin',sBreak1_begin);
        JSonValue.TryGetValue<String>('Break1_end',sBreak1_end);
        JSonValue.TryGetValue<String>('Break2_begin',sBreak2_begin);
        JSonValue.TryGetValue<String>('Break2_end',sBreak2_end);
        JSonValue.TryGetValue<String>('Planned_hours_Time',sPlanned_hours_Time);
        JSonValue.TryGetValue<integer>('Planned_hours_Integer',iPlanned_hours_Integer);
        JSonValue.TryGetValue<String>('Working_time_Time',sWorking_time_Time);
        JSonValue.TryGetValue<integer>('Working_time_Integer',iWorking_time_Integer);
        JSonValue.TryGetValue<integer>('Holiday',iHoliday);
        JSonValue.TryGetValue<String>('Absence_day',sAbsence_day);
        JSonValue.TryGetValue<String>('Overtime_Time',sOvertime_Time);
        JSonValue.TryGetValue<integer>('Overtime_Integer',iOvertime_Integer);
        JSonValue.TryGetValue<integer>('Break_Integer',iBreak_Integer);
        JSonValue.TryGetValue<integer>('Holiday_Intger',iHoliday_Integer);
        JSonValue.TryGetValue<integer>('Complete',iComplete);
        JSonValue.TryGetValue<integer>('Booking_type',iBooking_type);
        JSonValue.TryGetValue<integer>('ID_Absence_day',iID_Absence_day);
        qry_SynchConfig.SQL.Text:= 'Select Count(*) as Anzahl From Buchungen Where Datum = :Datum';
        qry_SynchConfig.ParamByName('Datum').AsDate := StrToDate(sDate);
        qry_SynchConfig.open;
        iCount:= qry_SynchConfig.FieldByName('Anzahl').AsInteger;
        qry_SynchConfig.Close;
        if iCount = 0 then
        begin
          qry_SynchConfig.SQL.Text:= 'Insert into Buchungen ' +
          '(Datum,Tag,Kommen,Gehen,Pause1Beginn,Pause1Ende,Pause2Beginn,Pause2Ende,Sollstunden,SollstundenI,Arbeitszeit,ArbeitszeitI,Feiertag,Fehltag,Mehrarbeit,MehrarbeitI,PausenI,FeiertagI,Abgeschlossen,Buchungsart,ID_Fehltage) ' +
          ' Values '+
          '(:Datum,:Tag,:Kommen,:Gehen,:Pause1Beginn,:Pause1Ende,:Pause2Beginn,:Pause2Ende,:Sollstunden,:SollstundenI,:Arbeitszeit,:ArbeitszeitI,:Feiertag,:Fehltag,:Mehrarbeit,:MehrarbeitI,:PausenI,:FeiertagI,:Abgeschlossen,:Buchungsart,:ID_Fehltage)';
          qry_SynchConfig.ParamByName('Datum').AsDate:= StrToDate(sDate);
          qry_SynchConfig.ParamByName('Tag').AsString:= sDay;
          qry_SynchConfig.ParamByName('Kommen').AsTime:= StrToTime(sWork_begin);
          qry_SynchConfig.ParamByName('Gehen').AsTime:= StrToTime(sWork_end);
          qry_SynchConfig.ParamByName('Pause1Beginn').AsTime:= StrToTime(sBreak1_begin);
          qry_SynchConfig.ParamByName('Pause1Ende').AsTime:= StrToTime(sBreak1_end);
          qry_SynchConfig.ParamByName('Pause2Beginn').AsTime:=StrToTime(sBreak2_begin);
          qry_SynchConfig.ParamByName('Pause2Ende').AsTime:= StrToTime(sBreak2_end);
          qry_SynchConfig.ParamByName('Sollstunden').AsTime:= StrToTime(sPlanned_hours_Time);
          qry_SynchConfig.ParamByName('SollstundenI').AsInteger:= iPlanned_hours_Integer;
          qry_SynchConfig.ParamByName('Arbeitszeit').AsTime:= StrToTime(sWorking_time_Time);
          qry_SynchConfig.ParamByName('ArbeitszeitI').AsInteger:= iWorking_time_Integer;
          qry_SynchConfig.ParamByName('Feiertag').AsInteger:= iHoliday;
          qry_SynchConfig.ParamByName('Fehltag').asString:= sAbsence_day;
          qry_SynchConfig.ParamByName('Mehrarbeit').asString:= sOvertime_Time;
          qry_SynchConfig.ParamByName('MehrarbeitI').AsInteger:= iOvertime_Integer;
          qry_SynchConfig.ParamByName('PausenI').AsInteger:= iBreak_Integer;
          qry_SynchConfig.ParamByName('FeiertagI').AsInteger:= iHoliday_Integer;
          qry_SynchConfig.ParamByName('Abgeschlossen').AsInteger:= iComplete;
          qry_SynchConfig.ParamByName('Buchungsart').AsInteger:= iBooking_type;
          qry_SynchConfig.ParamByName('ID_Fehltage').AsInteger:= iID_Absence_day;
          qry_SynchConfig.ExecSQL;
        end
        else begin
          qry_SynchConfig.SQL.Text:= 'Update Buchungen Set Kommen =:Kommen,Gehen =:Gehen, Pause1Beginn =:Pause1Beginn, Pause1Ende =:Pause1Ende,' +
                                     'Pause2Beginn =:Pause2Beginn, Pause2Ende =:Pause2Ende, Sollstunden =:Sollstunden, SollstundenI =:SollstundenI,'+
                                     'Arbeitszeit =:Arbeitszeit, ArbeitszeitI =:ArbeitszeitI,Feiertag =:Feiertag, Fehltag =:Fehltag,'+
                                     'Mehrarbeit =:Mehrarbeit,MehrarbeitI =:MehrarbeitI, PausenI =:PausenI, FeiertagI =:FeiertagI,'+
                                     'Abgeschlossen =:Abgeschlossen, Buchungsart =:Buchungsart, ID_Fehltage =:ID_Fehltage '+
                                     'Where Datum = :Datum';



          qry_SynchConfig.ParamByName('Datum').AsDate:= StrToDate(sDate);
          qry_SynchConfig.ParamByName('Kommen').AsTime:= StrToTime(sWork_begin);
          qry_SynchConfig.ParamByName('Gehen').AsTime:= StrToTime(sWork_end);
          qry_SynchConfig.ParamByName('Pause1Beginn').AsTime:= StrToTime(sBreak1_begin);
          qry_SynchConfig.ParamByName('Pause1Ende').AsTime:= StrToTime(sBreak1_end);
          qry_SynchConfig.ParamByName('Pause2Beginn').AsTime:=StrToTime(sBreak2_begin);
          qry_SynchConfig.ParamByName('Pause2Ende').AsTime:= StrToTime(sBreak2_end);
          qry_SynchConfig.ParamByName('Sollstunden').AsTime:= StrToTime(sPlanned_hours_Time);
          qry_SynchConfig.ParamByName('SollstundenI').AsInteger:= iPlanned_hours_Integer;
          qry_SynchConfig.ParamByName('Arbeitszeit').AsTime:= StrToTime(sWorking_time_Time);
          qry_SynchConfig.ParamByName('ArbeitszeitI').AsInteger:= iWorking_time_Integer;
          qry_SynchConfig.ParamByName('Feiertag').AsInteger:= iHoliday;
          qry_SynchConfig.ParamByName('Fehltag').asString:= sAbsence_day;
          qry_SynchConfig.ParamByName('Mehrarbeit').asString:= sOvertime_Time;
          qry_SynchConfig.ParamByName('MehrarbeitI').AsInteger:= iOvertime_Integer;
          qry_SynchConfig.ParamByName('PausenI').AsInteger:= iBreak_Integer;
          qry_SynchConfig.ParamByName('FeiertagI').AsInteger:= iHoliday_Integer;
          qry_SynchConfig.ParamByName('Abgeschlossen').AsInteger:= iComplete;
          qry_SynchConfig.ParamByName('Buchungsart').AsInteger:= iBooking_type;
          qry_SynchConfig.ParamByName('ID_Fehltage').AsInteger:= iID_Absence_day;
          qry_SynchConfig.ExecSQL;
        end;
      end;
    end;
  except
    on e:exception do
    begin
      WriteLog(e.Message,0,false);
    end;
  end;
  qry_SynchConfig.Close;
  FreeAndNil(qry_SynchConfig);
end;
procedure SynchAbsenceConfig_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  iCount: integer;
  qry_SynchConfig: TFDQuery;
  sCode: string;
  sDescription: string;
  iID: integer;
  iType: integer;
  iFactor: integer;
  iPaid: integer;
  iSubtract: integer;
begin
  AWaitFrame.SetWaitMessage('Fehltagekonfiguration wird synchronisiert...', 'Synchronisierung');
  qry_SynchConfig:= TFDQuery.Create(nil);
  qry_SynchConfig.Connection:= dmmain.con_PCM;
  try
    JSONResult := dmmain.RestRequest(nil,'GetAbsenceconfig?ID_User='+ IntToStr(AUserID),rmPOST) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if not bHasError then
    begin
      jaDetails :=  JSONResult.GetValue<TJSONArray>('Absence_Day_config');
      for var JSonValue in jaDetails do
      begin
        JSonValue.TryGetValue<integer>('ID',iID);
        JSonValue.TryGetValue<String>('Code',sCode);
        JSonValue.TryGetValue<String>('Description',sDescription);
        JSonValue.TryGetValue<integer>('Type',iType);
        JSonValue.TryGetValue<integer>('Factor',iFactor);
        JSonValue.TryGetValue<integer>('Paid',iPaid);
        JSonValue.TryGetValue<integer>('Subtract',iSubtract);
        qry_SynchConfig.SQL.Text:= 'Select Count(*) as Anzahl From Fehltag Where Kuerzel = :Kuerzel and Beschreibung = :Beschreibung and Typ = :Typ and Faktor = :Faktor and Bezahlt = :Bezahlt and SollAbziehen = :SollAbziehen';
        qry_SynchConfig.ParamByName('Kuerzel').asString:= sCode;
        qry_SynchConfig.ParamByName('Beschreibung').asString:= sDescription;
        qry_SynchConfig.ParamByName('Typ').AsInteger:= iType;
        qry_SynchConfig.ParamByName('Faktor').AsInteger:= iFactor;
        qry_SynchConfig.ParamByName('Bezahlt').AsInteger:= iPaid;
        qry_SynchConfig.ParamByName('SollAbziehen').AsInteger:= iSubtract;
        qry_SynchConfig.open;
        iCount:= qry_SynchConfig.FieldByName('Anzahl').AsInteger;
        qry_SynchConfig.Close;
        if iCount = 0 then
        begin
          qry_SynchConfig.SQL.Text:= 'Insert into Fehltag (ID,Kuerzel,Beschreibung,Typ,Faktor,Bezahlt,SollAbziehen)  Values (:ID,:Kuerzel,:Beschreibung,:Typ,:Faktor,:Bezahlt,:SollAbziehen)';
          qry_SynchConfig.ParamByName('ID').AsInteger:= iID;
          qry_SynchConfig.ParamByName('Kuerzel').asString:= sCode;
          qry_SynchConfig.ParamByName('Beschreibung').asString:= sDescription;
          qry_SynchConfig.ParamByName('Typ').AsInteger:= iType;
          qry_SynchConfig.ParamByName('Faktor').AsInteger:= iFactor;
          qry_SynchConfig.ParamByName('Bezahlt').AsInteger:= iPaid;
          qry_SynchConfig.ParamByName('SollAbziehen').AsInteger:= iSubtract;
          qry_SynchConfig.ExecSQL;
        end;
      end;
    end;
  except
    on e:exception do
    begin
      WriteLog(e.Message,0,false);
    end;
  end;
  qry_SynchConfig.Close;
  FreeAndNil(qry_SynchConfig);
end;
procedure SynchAbsence_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  qry_SynchConfig: TFDQuery;
  wJahr,wMonat,wTag: word;
  iID: integer;
  sFrom: string;
  sTo: string;
  sCode: string;
  sDescription: String;
  fDays: double;
begin
  AWaitFrame.SetWaitMessage('Fehltage werden synchronisiert...', 'Synchronisierung');
  try
    DecodeDate(Date,wJahr,wMonat,wTag);
    qry_SynchConfig:= TFDQuery.Create(nil);
    qry_SynchConfig.Connection:= dmmain.con_PCM;
    qry_SynchConfig.SQL.Text:= 'Delete From Fehltage';
    qry_SynchConfig.ExecSQL;
    JSONResult := dmmain.RestRequest(nil,'GetAbsence?ID_User='+ IntToStr(AUserID),rmPOST) as TJSONObject;
    bHasError:= StrToBool(JSONResult.GetValue<TJSONBool>('HasError').ToString);
    if not bHasError then
    begin
      jaDetails :=  JSONResult.GetValue<TJSONArray>('Absence_Day');
      for var JSonValue in jaDetails do
      begin
        JSonValue.TryGetValue<integer>('ID',iID);
        JSonValue.TryGetValue<String>('From',sFrom);
        JSonValue.TryGetValue<String>('To',sTo);
        JSonValue.TryGetValue<String>('Code',sCode);
        JSonValue.TryGetValue<String>('Description',sDescription);
        JSonValue.TryGetValue<Float64>('Days',fDays);
        qry_SynchConfig.SQL.Text:= 'Insert into Fehltage (ID, Von,Bis,Kuerzel,Beschreibung,Tage)  Values (:ID,:Von,:Bis,:Kuerzel,:Beschreibung,:Tage)';
        qry_SynchConfig.ParamByName('ID').AsInteger:= iID;
        qry_SynchConfig.ParamByName('Von').AsDate:= StrToDate(sFrom);
        qry_SynchConfig.ParamByName('Bis').AsDate:= StrToDate(sTo);
        qry_SynchConfig.ParamByName('Kuerzel').asString:= sCode;
        qry_SynchConfig.ParamByName('Beschreibung').asString:= sDescription;
        qry_SynchConfig.ParamByName('Tage').AsFloat:= fDays;
        qry_SynchConfig.ExecSQL;
      end;
    end;
  except
    on e:exception do
    begin
      WriteLog(e.Message,0,false);
    end;
  end;
  qry_SynchConfig.Close;
  FreeAndNil(qry_SynchConfig);
end;
procedure Synchronisation(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm; bALL: Boolean);
begin
  // Login Synchronisieren
  try
    SyncConfig_ToServer(AUserID, AWaitFrame);
  except
  end;
  //Personal Synchronisieren
  try
    SyncKontakte_FromServer(AUserID,0,AWaitFrame);
  except
  end;
  // Letzte Buchung synchronisieren
  try
    SynchLastBooking_FromServer(AUserID, AServerID, AWaitFrame);
  except
  end;
  // Buchungen Jahr synchronisieren
  try
    SynchBookingYear_FromServer(AUserID, 0,YearOf(Date), AWaitFrame);
  except
  end;
  // Abwesenheitskonfiguration synchronisieren
  try
    SynchAbsenceConfig_FromServer(AUserID, AServerID, AWaitFrame);
  except
  end;
  // Abwesenheitskonfiguration synchronisieren
  try
    SynchAbsence_FromServer(AUserID, AServerID, AWaitFrame);
  except
  end;
end;
procedure WriteLog(AMessage: String; ATyp: Integer; ANewFile: boolean);
var
  sTyp: String;
  sTag: String;
  sPath: string;
  {$IFDEF Android}
  slLog: TStringList;
  {$ENDIF Android}
  {$IFDEF MSWINDOWS}
  f: TextFile;
  {$ENDIF MSWINDOWS}
  qry_Log: TFDQuery;
  iLog: integer;
begin
  qry_Log:= TFDQuery.Create(nil);
  qry_Log.Connection:= dmmain.con_PCM;
  qry_Log.SQL.text:= 'Select Log From Auto_login';
  qry_Log.Open;
  iLog := qry_Log.FieldByName('Log').AsInteger;
  qry_Log.Close;
  FreeAndNil(qry_log);
  if iLog = 0 then
  begin
    exit;
  end;
  case ATyp of
  0: sTyp:= ' Hinweis: ';
  1: sTyp:= ' Warnung: ';
  2: sTyp:= ' Fehler: ';
  end;

  case DayOfWeek(Date) of
  1: sTag := 'So';
  2: sTag := 'Mo';
  3: sTag := 'Di';
  4: sTag := 'Mi';
  5: sTag := 'Do';
  6: sTag := 'Fr';
  7: sTag := 'Sa';
  end;

  {$IFDEF Android}
  try
    sPath := system.IOUtils.TPath.Combine(system.IOUtils.TPath.GetSharedDocumentsPath, 'Logs');
    if not system.IOUtils.TDirectory.Exists(sPath) then
    begin
      system.IOUtils.TDirectory.CreateDirectory(sPath);
    end;
    Try
      system.IOUtils.TFile.OpenWrite(system.IOUtils.TPath.Combine(sPath, 'PCMTime.log'));
    except
      system.IOUtils.TFile.WriteAllText(system.IOUtils.TPath.Combine(sPath, 'PCMTime.log'),FormatDateTime('dd.mm.yyyy hh:mm:ss', Now) +  sTyp + AMessage);
    end;
    if not ANewFile then
    begin
      slLog:= TStringList.Create;
      try
        slLog.LoadFromFile(system.IOUtils.TPath.Combine(sPath, 'PCMTime.log'));
        slLog.Add(FormatDateTime('dd.mm.yyyy hh:mm:ss', Now) +  sTyp + AMessage);
        slLog.SaveToFile(system.IOUtils.TPath.Combine(sPath, 'PCMTime.log'));
      finally
        FreeandNil(slLog);
      end;
    end
    else begin
      system.IOUtils.TFile.WriteAllText(system.IOUtils.TPath.Combine(sPath, 'PCMTime.log'),FormatDateTime('dd.mm.yyyy hh:mm:ss', Now) +  sTyp + AMessage);
    end;
  except
  end;
  {$ENDIF Android}
  {$IFDEF MSWINDOWS}
  if not DirectoryExists(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM') then
    CreateDir(GetEnvironmentVariable('LOCALAPPDATA') + '\PCM');
  sPath := GetEnvironmentVariable('LOCALAPPDATA') + '\PCM\PCMTime' + sTag + '.log';
  AssignFile(f, sPath);
  if FileExists(sPath) then
    Append(f)
  else
    Rewrite(f);
  Writeln(f, DateTimeToStr(Now()) + ' ' + sTyp + AMessage);
  CloseFile(f);
  {$ENDIF MSWINDOWS}
end;
{$EndRegion procedures}
end.
