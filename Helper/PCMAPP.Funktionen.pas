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
  IdGlobal,
  IdIPAddress,
  IdStack,
  IdTCPClient,
  FMX.Platform,
  System.Classes,
  System.DateUtils,
  System.Devices,
  System.IOUtils,
  System.SysUtils,
  PCMAPP.Datamodul,
  PCMAPP.SQL,
  PCMAPP.WaitForm;
  {$EndRegion Uses}
// Deklarationen Functions
{$Region Functions}
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
procedure BerechneMonat(AMonat,AJahr: integer);
procedure BerechneTage(ATag,AMonat,AJahr: integer);
procedure CreateDatabase;
procedure DeleteAllTables;
procedure ClearAllTablesByID(AID: Integer; AColumnName: String);
procedure SynchAbsence_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchAbsence_ToServer(AID: integer; ADelete: boolean);
procedure SynchAbsenceConfig_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchBooking_ToServer(AID: integer);
procedure SynchBookingYear_FromServer(const AUserID, AServerID, AJahr: Integer; AWaitFrame: TWaitForm);
procedure SynchFirst(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm; bALL: Boolean);
procedure SynchFull(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm; bALL: Boolean);
procedure SyncKontakte_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchLastBooking_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchLastBooking_toServer(const AUserID: integer; AWaitFrame: TWaitForm; bALL: Boolean);
procedure SynchMonthView(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
procedure SynchOnlineBooking_ToServer(const AUserID: integer; ADate: TDate; ATime: TTime; ABookingType,AHOOffice:Integer; AWaitFrame: TWaitForm; bALL: Boolean);
procedure Synchronisation(const AUserID, AServerID: Integer; ALogin, ABuchungen, ADevice, AFirstStart: Boolean; AWaitFrame: TWaitForm);
procedure WriteLog(AMessage: String; ATyp: Integer; ANewFile: boolean);
{$EndRegion Procedures}
implementation
// Functions
{$Region Functions}
function CheckServerConnection: Boolean;
var
  ipAdrIPAddr: TIDIPAddress;
  idTCPClient: TIdTCPClient;
begin
  try
    idTCPClient:= TIdTCPClient.Create(nil);
    idTCPClient.ConnectTimeout := 1500;
    idTCPClient.ReadTimeout := 1500;
    idTCPClient.Disconnect;
    idTCPClient.Port := StrToInt(dmMain.sPort);
    ipAdrIPAddr := TIdIPAddress.MakeAddressObject(dmMain.sHostname);
    if ipAdrIPAddr <> nil then
    begin
      idTCPClient.Host := dmMain.sHostname;
      try
        idTCPClient.IPVersion := Id_IPv4;
        dmMain.con_SQL.Params.Values['CommunicationIPVersion'] := 'IP_IPv4';
        idTCPClient.Connect;
        idTCPClient.Disconnect;
        Result := True;
      except
        idTCPClient.IPVersion := Id_IPv6;
        dmMain.con_SQL.Params.Values['CommunicationIPVersion'] := 'IP_IPv6';
        idTCPClient.Connect;
        idTCPClient.Disconnect;
        Result := True;
      end;
    end else
    begin
      try
        idTCPClient.Host := GStack.ResolveHost(dmMain.sHostname, Id_IPv4);
        idTCPClient.IPVersion := Id_IPv4;
        dmMain.con_SQL.Params.Values['CommunicationIPVersion'] := 'IP_IPv4';
        idTCPClient.Connect;
        idTCPClient.Disconnect;
        Result := True;
      except
        idTCPClient.Host := GStack.ResolveHost(dmMain.sHostname, Id_IPv6);
        idTCPClient.IPVersion := Id_IPv6;
        dmMain.con_SQL.Params.Values['CommunicationIPVersion'] := 'IP_IPv6';
        idTCPClient.Connect;
        idTCPClient.Disconnect;
        Result := True;
      end;
    end;
    ipAdrIPAddr.Free;
    FreeandNil(idTCPClient);
  except
    Result := False;
    FreeandNil(idTCPClient);
  end;
end;
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
        iFehltag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
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
        iSollstunden:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
        if ((qry_Calc.FieldByName('Bezahlt').AsInteger = 1) and  (qry_Calc.FieldByName('Faktor').AsInteger = 1))  then
          iFehltag:= MinutesBetween(qry_Calc.FieldByName('Sollstunden').asDateTime,StrToTime('00:00'));
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
procedure SynchAbsence_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  qry_SynchConfig: TFDQuery;
  wJahr,wMonat,wTag: word;
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_HoleFehltage.SQLConnection := con_SQLConnection;
  DecodeDate(Date,wJahr,wMonat,wTag);
  qry_SynchConfig:= TFDQuery.Create(nil);
  qry_SynchConfig.Connection:= dmmain.con_PCM;
  qry_SynchConfig.SQL.Text:= 'Delete From Fehltage';
  qry_SynchConfig.ExecSQL;
  AWaitFrame.SetWaitMessage('Fehltage werden synchronisiert...', 'Synchronisierung');
  dmMain.sqlSM_HoleFehltage.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_HoleFehltage.Open;
  while not dmMain.sqlSM_HoleFehltage.Eof do
  begin
    qry_SynchConfig.SQL.Text:= 'Insert into Fehltage (ID, Von,Bis,Kuerzel,Beschreibung,Tage)  Values (:ID,:Von,:Bis,:Kuerzel,:Beschreibung,:Tage)';
    qry_SynchConfig.ParamByName('ID').AsInteger:= dmMain.sqlSM_HoleFehltage.FieldByName('ID').AsInteger;
    qry_SynchConfig.ParamByName('Von').AsDate:= dmMain.sqlSM_HoleFehltage.FieldByName('Von').AsDateTime;
    qry_SynchConfig.ParamByName('Bis').AsDate:= dmMain.sqlSM_HoleFehltage.FieldByName('Bis').AsDateTime;
    qry_SynchConfig.ParamByName('Kuerzel').asString:= dmMain.sqlSM_HoleFehltage.FieldByName('Kuerzel').asString;
    qry_SynchConfig.ParamByName('Beschreibung').asString:= dmMain.sqlSM_HoleFehltage.FieldByName('Beschreibung').asString;
    qry_SynchConfig.ParamByName('Tage').AsFloat:= dmMain.sqlSM_HoleFehltage.FieldByName('Tage').AsFloat;
    qry_SynchConfig.ExecSQL;
    dmMain.sqlSM_HoleFehltage.Next;
  end;
  dmMain.sqlSM_HoleFehltage.Close;
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection);
  FreeAndNil(qry_SynchConfig);
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
procedure SynchAbsenceConfig_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  iCount: integer;
  qry_SynchConfig: TFDQuery;
  wJahr,wMonat,wTag: word;
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_HoleFehltageKonfiguration.SQLConnection := con_SQLConnection;
  DecodeDate(Date,wJahr,wMonat,wTag);
  qry_SynchConfig:= TFDQuery.Create(nil);
  qry_SynchConfig.Connection:= dmmain.con_PCM;
  AWaitFrame.SetWaitMessage('Fehltagekonfiguration wird synchronisiert...', 'Synchronisierung');
  dmMain.sqlSM_HoleFehltageKonfiguration.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_HoleFehltageKonfiguration.Open;
  while not dmMain.sqlSM_HoleFehltageKonfiguration.Eof do
  begin
    qry_SynchConfig.SQL.Text:= 'Select Count(*) as Anzahl From Fehltag Where Kuerzel = :Kuerzel and Beschreibung = :Beschreibung and Typ = :Typ and Faktor = :Faktor and Bezahlt = :Bezahlt';
    qry_SynchConfig.ParamByName('Kuerzel').asString:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Kuerzel').asString;
    qry_SynchConfig.ParamByName('Beschreibung').asString:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Beschreibung').asString;
    qry_SynchConfig.ParamByName('Typ').AsInteger:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Typ').AsInteger;
    qry_SynchConfig.ParamByName('Faktor').AsInteger:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Faktor').AsInteger;
    qry_SynchConfig.ParamByName('Bezahlt').AsInteger:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Bezahlt').AsInteger;
    qry_SynchConfig.open;
    iCount:= qry_SynchConfig.FieldByName('Anzahl').AsInteger;
    qry_SynchConfig.Close;
    if iCount = 0 then
    begin
      qry_SynchConfig.SQL.Text:= 'Insert into Fehltag (ID,Kuerzel,Beschreibung,Typ,Faktor,Bezahlt)  Values (:ID,:Kuerzel,:Beschreibung,:Typ,:Faktor,:Bezahlt)';
      qry_SynchConfig.ParamByName('ID').AsInteger:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('ID').AsInteger;
      qry_SynchConfig.ParamByName('Kuerzel').asString:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Kuerzel').asString;
      qry_SynchConfig.ParamByName('Beschreibung').asString:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Beschreibung').asString;
      qry_SynchConfig.ParamByName('Typ').AsInteger:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Typ').AsInteger;
      qry_SynchConfig.ParamByName('Faktor').AsInteger:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Faktor').AsInteger;
      qry_SynchConfig.ParamByName('Bezahlt').AsInteger:= dmMain.sqlSM_HoleFehltageKonfiguration.FieldByName('Bezahlt').AsInteger;
      qry_SynchConfig.ExecSQL;
    end;
    dmMain.sqlSM_HoleFehltageKonfiguration.Next;
  end;
  dmMain.sqlSM_HoleFehltageKonfiguration.Close;
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection);
  FreeAndNil(qry_SynchConfig);
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
procedure SynchBookingYear_FromServer(const AUserID, AServerID, AJahr: Integer; AWaitFrame: TWaitForm);
var
  iCount: integer;
  qry_SynchConfig: TFDQuery;
  wJahr,wMonat,wTag: word;
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_HoleBuchungenJahr.SQLConnection := con_SQLConnection;
  DecodeDate(Date,wJahr,wMonat,wTag);
  qry_SynchConfig:= TFDQuery.Create(nil);
  qry_SynchConfig.Connection:= dmmain.con_PCM;
  AWaitFrame.SetWaitMessage('Buchungsübersicht wird synchronisiert...', 'Synchronisierung');
  dmMain.sqlSM_HoleBuchungenJahr.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_HoleBuchungenJahr.ParamByName('Jahr').AsInteger := AJahr;
  dmMain.sqlSM_HoleBuchungenJahr.Open;
  while not dmMain.sqlSM_HoleBuchungenJahr.Eof do
  begin
    qry_SynchConfig.SQL.Text:= 'Select Count(*) as Anzahl From Buchungen Where Datum = :Datum';
    qry_SynchConfig.ParamByName('Datum').AsDate :=dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Datum').AsDateTime;
    qry_SynchConfig.open;
    iCount:= qry_SynchConfig.FieldByName('Anzahl').AsInteger;
    qry_SynchConfig.Close;
    if iCount = 0 then
    begin
      qry_SynchConfig.SQL.Text:= 'Insert into Buchungen ' +
      '(Datum,Tag,Kommen,Gehen,Pause1Beginn,Pause1Ende,Pause2Beginn,Pause2Ende,Sollstunden,SollstundenI,Arbeitszeit,ArbeitszeitI,Feiertag,Fehltag,Mehrarbeit,MehrarbeitI,PausenI,FeiertagI,Abgeschlossen,Buchungsart,ID_Fehltage) ' +
      ' Values '+
      '(:Datum,:Tag,:Kommen,:Gehen,:Pause1Beginn,:Pause1Ende,:Pause2Beginn,:Pause2Ende,:Sollstunden,:SollstundenI,:Arbeitszeit,:ArbeitszeitI,:Feiertag,:Fehltag,:Mehrarbeit,:MehrarbeitI,:PausenI,:FeiertagI,:Abgeschlossen,:Buchungsart,:ID_Fehltage)';
      qry_SynchConfig.ParamByName('Datum').AsDate:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Datum').AsDateTime;
      qry_SynchConfig.ParamByName('Tag').AsString:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('tag').AsString;
      qry_SynchConfig.ParamByName('Kommen').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Kommen').AsDateTime;
      qry_SynchConfig.ParamByName('Gehen').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Gehen').AsDateTime;
      qry_SynchConfig.ParamByName('Pause1Beginn').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause1Beginn').AsDateTime;
      qry_SynchConfig.ParamByName('Pause1Ende').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause1Ende').AsDateTime;
      qry_SynchConfig.ParamByName('Pause2Beginn').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause2Beginn').AsDateTime;
      qry_SynchConfig.ParamByName('Pause2Ende').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause2Ende').AsDateTime;
      qry_SynchConfig.ParamByName('Sollstunden').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Sollstunden').AsDateTime;
      qry_SynchConfig.ParamByName('SollstundenI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('SollstundenI').AsInteger;
      qry_SynchConfig.ParamByName('Arbeitszeit').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Arbeitszeit').AsDateTime;
      qry_SynchConfig.ParamByName('ArbeitszeitI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('ArbeitszeitI').AsInteger;
      qry_SynchConfig.ParamByName('Feiertag').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Feiertag').AsInteger;
      qry_SynchConfig.ParamByName('Fehltag').asString:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Fehltag').AsString;
      qry_SynchConfig.ParamByName('Mehrarbeit').asString:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Mehrarbeit').AsString;
      qry_SynchConfig.ParamByName('MehrarbeitI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('MehrarbeitI').AsInteger;
      qry_SynchConfig.ParamByName('PausenI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('PausenI').AsInteger;
      qry_SynchConfig.ParamByName('FeiertagI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('FeiertagI').AsInteger;
      qry_SynchConfig.ParamByName('Abgeschlossen').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Abgeschlossen').AsInteger;
      qry_SynchConfig.ParamByName('Buchungsart').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Buchungsart').AsInteger;
      qry_SynchConfig.ParamByName('ID_Fehltage').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('ID_Fehltage').AsInteger;
      qry_SynchConfig.ExecSQL;
    end
    else begin
    qry_SynchConfig.SQL.Text:= 'Update Buchungen Set Kommen =:Kommen,Gehen =:Gehen, Pause1Beginn =:Pause1Beginn, Pause1Ende =:Pause1Ende,' +
                               'Pause2Beginn =:Pause2Beginn, Pause2Ende =:Pause2Ende, Sollstunden =:Sollstunden, SollstundenI =:SollstundenI,'+
                               'Arbeitszeit =:Arbeitszeit, ArbeitszeitI =:ArbeitszeitI,Feiertag =:Feiertag, Fehltag =:Fehltag,'+
                               'Mehrarbeit =:Mehrarbeit,MehrarbeitI =:MehrarbeitI, PausenI =:PausenI, FeiertagI =:FeiertagI,'+
                               'Abgeschlossen =:Abgeschlossen, Buchungsart =:Buchungsart, ID_Fehltage =:ID_Fehltage '+
                               'Where Datum = :Datum';
      qry_SynchConfig.ParamByName('Datum').AsDate:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Datum').AsDateTime;
      qry_SynchConfig.ParamByName('Kommen').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Kommen').AsDateTime;
      qry_SynchConfig.ParamByName('Gehen').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Gehen').AsDateTime;
      qry_SynchConfig.ParamByName('Pause1Beginn').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause1Beginn').AsDateTime;
      qry_SynchConfig.ParamByName('Pause1Ende').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause1Ende').AsDateTime;
      qry_SynchConfig.ParamByName('Pause2Beginn').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause2Beginn').AsDateTime;
      qry_SynchConfig.ParamByName('Pause2Ende').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Pause2Ende').AsDateTime;
      qry_SynchConfig.ParamByName('Sollstunden').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Sollstunden').AsDateTime;
      qry_SynchConfig.ParamByName('SollstundenI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('SollstundenI').AsInteger;
      qry_SynchConfig.ParamByName('Arbeitszeit').AsTime:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Arbeitszeit').AsDateTime;
      qry_SynchConfig.ParamByName('ArbeitszeitI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('ArbeitszeitI').AsInteger;
      qry_SynchConfig.ParamByName('Feiertag').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Feiertag').AsInteger;
      qry_SynchConfig.ParamByName('Fehltag').asString:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Fehltag').AsString;
      qry_SynchConfig.ParamByName('Mehrarbeit').asString:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Mehrarbeit').AsString;
      qry_SynchConfig.ParamByName('MehrarbeitI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('MehrarbeitI').AsInteger;
      qry_SynchConfig.ParamByName('PausenI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('PausenI').AsInteger;
      qry_SynchConfig.ParamByName('FeiertagI').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('FeiertagI').AsInteger;
      qry_SynchConfig.ParamByName('Abgeschlossen').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Abgeschlossen').AsInteger;
      qry_SynchConfig.ParamByName('Buchungsart').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('Buchungsart').AsInteger;
      qry_SynchConfig.ParamByName('ID_Fehltage').AsInteger:= dmMain.sqlSM_HoleBuchungenJahr.FieldByName('ID_Fehltage').AsInteger;
      qry_SynchConfig.ExecSQL;
    end;
    dmMain.sqlSM_HoleBuchungenJahr.Next;
  end;
  dmMain.sqlSM_HoleBuchungenJahr.Close;
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection);
  FreeAndNil(qry_SynchConfig);
end;
procedure SynchFirst(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm; bALL: Boolean);
begin
  Synchronisation(AUserID, AServerID, True, True, True, True, AWaitFrame);
end;
procedure SynchFull(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm; bALL: Boolean);
begin
  Synchronisation(AUserID, AServerID, True, True, True, True, AWaitFrame);
end;
procedure SyncKontakte_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  qry_SynchKontakte: TFDQuery;
  con_SQLConnection : TSQLConnection;
  iID_Kontakte: integer;
begin
  AWaitFrame.SetWaitMessage('Personaldaten synchronisieren...', 'Synchronisierung');
  qry_SynchKontakte:= TFDQuery.Create(nil);
  qry_SynchKontakte.Connection:= dmmain.con_PCM;
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_HolePersonalDaten.SQLConnection := con_SQLConnection;
  dmMain.sqlSM_HolePersonalDaten.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_HolePersonalDaten.Open;
  while not dmMain.sqlSM_HolePersonalDaten.Eof do
  begin
    qry_SynchKontakte.Close;
    qry_SynchKontakte.SQL.Text:= 'SELECT ID FROM Kontakte WHERE Nachname = :Nachname AND Vorname = :Vorname';
    qry_SynchKontakte.ParamByName('Vorname').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Vorname').AsString;
    qry_SynchKontakte.ParamByName('Nachname').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Nachname').AsString;
    qry_SynchKontakte.open;
    if qry_SynchKontakte.RecordCount > 0 then
    begin
      iID_Kontakte:= qry_SynchKontakte.FieldByName('ID').AsInteger;
      qry_SynchKontakte.Close;
      qry_SynchKontakte.SQL.Text := 'Update Kontakte Set ' +
                                    'Anrede =:Anrede,' +
                                    'Vorname =:Vorname,' +
                                    'Nachname =:Nachname,' +
                                    'Strasse =:Strasse,' +
                                    'PLZ =:PLZ,' +
                                    'Ort =:Ort,' +
                                    'Telefon	=:Telefon,' +
                                    'Handy =:Handy,' +
                                    'Email =:Email,' +
                                    'Geburtsdatum =:Geburtsdatum,' +
                                    'Geschlecht =:Geschlecht,' +
                                    'Familienstand =:Familienstand,' +
                                    'Staatsangehoerigkeit =:Staatsangehoerigkeit,' +
                                    'Konfession =:Konfession,' +
                                    'Firma =:Firma,' +
                                    'StrasseFirma =:StrasseFirma,' +
                                    'PLZFirma =:PLZFirma,' +
                                    'OrtFirma =:OrtFirma,' +
                                    'TelefonFirma =:TelefonFirma,' +
                                    'HandyFirma =:HandyFirma,' +
                                    'EmailFirma =:EmailFirma,' +
                                    'Urlaub =:Urlaub,' +
                                    'Eintritt =:Eintritt,' +
                                    'OffsetResturlaub =:OffsetResturlaub,' +
                                    'OffsetResturlaubJahr =:OffsetResturlaubJahr,' +
                                    'Sollstunden	=:Sollstunden, Personalnummer = :Personalnummer Where ID =:ID';
      qry_SynchKontakte.ParamByName('ID').AsInteger := iID_Kontakte;
      qry_SynchKontakte.ParamByName('Anrede').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Anrede').AsString;
      qry_SynchKontakte.ParamByName('Vorname').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Vorname').AsString;
      qry_SynchKontakte.ParamByName('Nachname').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Nachname').AsString;
      qry_SynchKontakte.ParamByName('Strasse').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Strasse_Privat').AsString;
      qry_SynchKontakte.ParamByName('PLZ').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('PLZ_Privat').AsString;
      qry_SynchKontakte.ParamByName('Ort').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Ort_Privat').AsString;
      qry_SynchKontakte.ParamByName('Telefon').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Telefon_Privat').AsString;
      qry_SynchKontakte.ParamByName('Handy').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Handy_Privat').AsString;
      qry_SynchKontakte.ParamByName('Email').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('E_mail_Privat').AsString;
      qry_SynchKontakte.ParamByName('Geburtsdatum').AsDate := dmMain.sqlSM_HolePersonalDaten.FieldByName('Geburtsdatum').AsDateTime;
      qry_SynchKontakte.ParamByName('Geschlecht').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Geschlecht').AsString;
      qry_SynchKontakte.ParamByName('Familienstand').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Familienstand').AsString;
      qry_SynchKontakte.ParamByName('Staatsangehoerigkeit').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Staatsangehoerigkeit').AsString;
      qry_SynchKontakte.ParamByName('Konfession').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Konfession').AsString;
      qry_SynchKontakte.ParamByName('Firma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Firma').AsString;
      qry_SynchKontakte.ParamByName('StrasseFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Strasse_Ges').AsString;
      qry_SynchKontakte.ParamByName('PLZFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('PLZ_Ges').AsString;
      qry_SynchKontakte.ParamByName('OrtFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Ort_Ges').AsString;
      qry_SynchKontakte.ParamByName('TelefonFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Telefon_Ges').AsString;
      qry_SynchKontakte.ParamByName('HandyFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Handy_Ges').AsString;
      qry_SynchKontakte.ParamByName('EmailFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('E_mail_GEs').AsString;
      qry_SynchKontakte.ParamByName('Urlaub').AsFloat:=  dmMain.sqlSM_HolePersonalDaten.FieldByName('Urlaub').AsFloat;
      qry_SynchKontakte.ParamByName('Eintritt').AsDate := dmMain.sqlSM_HolePersonalDaten.FieldByName('Eintritt').AsDateTime;
      qry_SynchKontakte.ParamByName('OffsetResturlaub').AsFloat := dmMain.sqlSM_HolePersonalDaten.FieldByName('OffsetResturlaub').AsFloat;
      qry_SynchKontakte.ParamByName('OffsetResturlaubJahr').AsInteger := dmMain.sqlSM_HolePersonalDaten.FieldByName('OffsetResturlaubJahr').AsInteger;
      qry_SynchKontakte.ParamByName('Sollstunden').AsTime := dmMain.sqlSM_HolePersonalDaten.FieldByName('Sollstunden').asDateTime;
      qry_SynchKontakte.ParamByName('Personalnummer').asInteger := dmMain.sqlSM_HolePersonalDaten.FieldByName('Personalnummer').asInteger;
      qry_SynchKontakte.ExecSQL
    end
    else begin
      qry_SynchKontakte.SQL.Text := 'INSERT INTO Kontakte (Personalnummer,Anrede,Vorname, Nachname, Strasse, PLZ, Ort, Telefon, Handy, Email, Geburtsdatum,'+
                                  'Geschlecht, Familienstand, Staatsangehoerigkeit,Konfession,Firma,StrasseFirma,PLZFirma,OrtFirma,TelefonFirma,HandyFirma,EmailFirma,Urlaub,Eintritt,OffsetResturlaub,OffsetResturlaubJahr,Sollstunden) VALUES ' +
                                  '(:Personalnummer,:Anrede,:Vorname, :Nachname, :Strasse, :PLZ, :Ort, :Telefon, :Handy, :Email, :Geburtsdatum, :Geschlecht, :Familienstand, :Staatsangehoerigkeit,' +
                                  ':Konfession,:Firma,:StrasseFirma,:PLZFirma,:OrtFirma,:TelefonFirma,:HandyFirma,:EmailFirma,:Urlaub,:Eintritt,:OffsetResturlaub,:OffsetResturlaubJahr,:Sollstunden)';
      qry_SynchKontakte.ParamByName('Anrede').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Anrede').AsString;
      qry_SynchKontakte.ParamByName('Vorname').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Vorname').AsString;
      qry_SynchKontakte.ParamByName('Nachname').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Nachname').AsString;
      qry_SynchKontakte.ParamByName('Strasse').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Strasse_Privat').AsString;
      qry_SynchKontakte.ParamByName('PLZ').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('PLZ_Privat').AsString;
      qry_SynchKontakte.ParamByName('Ort').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Ort_Privat').AsString;
      qry_SynchKontakte.ParamByName('Telefon').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Telefon_Privat').AsString;
      qry_SynchKontakte.ParamByName('Handy').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Handy_Privat').AsString;
      qry_SynchKontakte.ParamByName('Email').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('E_mail_Privat').AsString;
      qry_SynchKontakte.ParamByName('Geburtsdatum').AsDate := dmMain.sqlSM_HolePersonalDaten.FieldByName('Geburtsdatum').AsDateTime;
      qry_SynchKontakte.ParamByName('Geschlecht').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Geschlecht').AsString;
      qry_SynchKontakte.ParamByName('Familienstand').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Familienstand').AsString;
      qry_SynchKontakte.ParamByName('Staatsangehoerigkeit').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Staatsangehoerigkeit').AsString;
      qry_SynchKontakte.ParamByName('Konfession').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Konfession').AsString;
      qry_SynchKontakte.ParamByName('Firma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Firma').AsString;
      qry_SynchKontakte.ParamByName('StrasseFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Strasse_Ges').AsString;
      qry_SynchKontakte.ParamByName('PLZFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('PLZ_Ges').AsString;
      qry_SynchKontakte.ParamByName('OrtFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Ort_Ges').AsString;
      qry_SynchKontakte.ParamByName('TelefonFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Telefon_Ges').AsString;
      qry_SynchKontakte.ParamByName('HandyFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('Handy_Ges').AsString;
      qry_SynchKontakte.ParamByName('EmailFirma').AsString := dmMain.sqlSM_HolePersonalDaten.FieldByName('E_mail_GEs').AsString;
      qry_SynchKontakte.ParamByName('Urlaub').AsFloat:=  dmMain.sqlSM_HolePersonalDaten.FieldByName('Urlaub').AsFloat;
      qry_SynchKontakte.ParamByName('Eintritt').AsDate := dmMain.sqlSM_HolePersonalDaten.FieldByName('Eintritt').AsDateTime;
      qry_SynchKontakte.ParamByName('OffsetResturlaub').AsFloat := dmMain.sqlSM_HolePersonalDaten.FieldByName('OffsetResturlaub').AsFloat;
      qry_SynchKontakte.ParamByName('OffsetResturlaubJahr').AsInteger := dmMain.sqlSM_HolePersonalDaten.FieldByName('OffsetResturlaubJahr').AsInteger;
      qry_SynchKontakte.ParamByName('Sollstunden').AsTime := dmMain.sqlSM_HolePersonalDaten.FieldByName('Sollstunden').asDateTime;
      qry_SynchKontakte.ParamByName('Personalnummer').asInteger := dmMain.sqlSM_HolePersonalDaten.FieldByName('Personalnummer').asInteger;
      qry_SynchKontakte.ExecSQL;
    end;
    dmMain.sqlSM_HolePersonalDaten.Next;
  end;
  dmMain.sqlSM_HolePersonalDaten.Close;
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection);
  qry_SynchKontakte.Close;
  FreeAndNil(qry_SynchKontakte);
end;
procedure SynchLastBooking_FromServer(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  qry_SyncLastBooking: TFDQuery;
  iAnzahl: Integer;
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_HoleLetzteBuchung.SQLConnection := con_SQLConnection;
  AWaitFrame.SetWaitMessage('Letzte Buchung wird ermittelt ...', 'Synchronisierung');
  qry_SyncLastBooking:= TFDQuery.Create(nil);
  qry_SyncLastBooking.Connection:= dmmain.con_PCM;
  dmMain.sqlSM_HoleLetzteBuchung.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_HoleLetzteBuchung.Open;
  if dmMain.sqlSM_HoleLetzteBuchung.FieldByName('Text').AsString <> '' then
  begin
    qry_SyncLastBooking.SQL.Text:= 'SELECT COUNT (*) as Anzahl From LastBooking';
    qry_SyncLastBooking.open;
    iAnzahl:= qry_SyncLastBooking.FieldByName('Anzahl').AsInteger;
    qry_SyncLastBooking.Close;
    if iAnzahl > 0 then
    begin
      qry_SyncLastBooking.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
    end
    else begin
      qry_SyncLastBooking.SQL.Text:= 'Insert into LastBooking (Text) Values (:Text)';
    end;
    qry_SyncLastBooking.ParamByName('Text').asString := dmMain.sqlSM_HoleLetzteBuchung.FieldByName('Text').asString;
    qry_SyncLastBooking.ExecSQL;
  end;
  dmMain.sqlSM_HoleLetzteBuchung.Close;
  qry_SyncLastBooking.Close;
  FreeAndNil(qry_SyncLastBooking);
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection);
end;
procedure SynchLastBooking_toServer(const AUserID: integer; AWaitFrame: TWaitForm; bALL: Boolean);
var
  qry_SynchConfigTel: TFDQuery;
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_SetzeLetzteBuchung.SQLConnection := con_SQLConnection;
  AWaitFrame.SetWaitMessage('Letzte Buchung wird synchronisiert...', 'Synchronisierung');
  qry_SynchConfigTel:= TFDQuery.Create(nil);
  qry_SynchConfigTel.Connection:= dmmain.con_PCM;
  qry_SynchConfigTel.SQL.Text:= sSQL_SELECT_TEXT_LASTBOOKING;
  qry_SynchConfigTel.open;
  dmMain.sqlSM_SetzeLetzteBuchung.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_SetzeLetzteBuchung.ParamByName('Data').AsDataSet:= qry_SynchConfigTel;
  dmMain.sqlSM_SetzeLetzteBuchung.ExecuteMethod;
  qry_SynchConfigTel.Close;
  FreeandNil(qry_SynchConfigTel);
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection);
  SynchLastBooking_FromServer(AUserID,0,AWaitFrame);
end;
procedure SynchMonthView(const AUserID, AServerID: Integer; AWaitFrame: TWaitForm);
var
  iCount: integer;
  qry_SynchConfig: TFDQuery;
  wJahr,wMonat,wTag: word;
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_HoleMonatswerte.SQLConnection := con_SQLConnection;
  DecodeDate(Date,wJahr,wMonat,wTag);
  qry_SynchConfig:= TFDQuery.Create(nil);
  qry_SynchConfig.Connection:= dmmain.con_PCM;
  AWaitFrame.SetWaitMessage('Monatswerte werden synchronisiert...', 'Synchronisierung');
  dmMain.sqlSM_HoleMonatswerte.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_HoleMonatswerte.Open;
  while not dmMain.sqlSM_HoleMonatswerte.Eof do
  begin
    qry_SynchConfig.SQL.Text:= 'Select Count(*) as Anzahl From Monatswerte Where Monat = :Monat and Jahr = :Jahr';
    qry_SynchConfig.ParamByName('Monat').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Monat').AsInteger;
    qry_SynchConfig.ParamByName('Jahr').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('jahr').AsInteger;

    qry_SynchConfig.open;
    iCount:= qry_SynchConfig.FieldByName('Anzahl').AsInteger;
    qry_SynchConfig.Close;
    if iCount = 0 then
    begin
      qry_SynchConfig.SQL.Text:= 'Insert into Monatswerte ' +
      '(Monat,Jahr,ID_Benutzer,Sollzeit,IStzeit,Mehrarbeit,aktuelleMehrarbeit,Pausen,Urlaub_bezahlt,Urlaub_unbezahlt,Krank_bezahlt,Krank_unbezahlt,Feiertag,Resturlaub) ' +
      'Values' +
      '(:Monat,:Jahr,:ID_Benutzer,:Sollzeit,:IStzeit,:Mehrarbeit,:aktuelleMehrarbeit,:Pausen,:Urlaub_bezahlt,:Urlaub_unbezahlt,:Krank_bezahlt,:Krank_unbezahlt,:Feiertag,:Resturlaub)';
      qry_SynchConfig.ParamByName('Monat').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Monat').AsInteger;
      qry_SynchConfig.ParamByName('Jahr').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Jahr').AsInteger;
      qry_SynchConfig.ParamByName('ID_Benutzer').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('ID_Benutzer').AsInteger;
      qry_SynchConfig.ParamByName('Sollzeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Sollzeit').AsInteger;
      qry_SynchConfig.ParamByName('IStzeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('IStzeit').AsInteger;
      qry_SynchConfig.ParamByName('Mehrarbeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Mehrarbeit').AsInteger;
      qry_SynchConfig.ParamByName('aktuelleMehrarbeit').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('aktuelleMehrarbeit').AsInteger;
      qry_SynchConfig.ParamByName('Pausen').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Pausen').AsInteger;
      qry_SynchConfig.ParamByName('Urlaub_bezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Urlaub_bezahlt').AsFloat;
      qry_SynchConfig.ParamByName('Urlaub_unbezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Urlaub_unbezahlt').AsFloat;
      qry_SynchConfig.ParamByName('Krank_bezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Krank_bezahlt').AsFloat;
      qry_SynchConfig.ParamByName('Krank_unbezahlt').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Krank_unbezahlt').AsFloat;
      qry_SynchConfig.ParamByName('Feiertag').AsInteger:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Feiertag').AsInteger;
      qry_SynchConfig.ParamByName('Resturlaub').AsFloat:= dmMain.sqlSM_HoleMonatswerte.FieldByName('Resturlaub').AsFloat;
      qry_SynchConfig.ExecSQL;
    end;
    dmMain.sqlSM_HoleMonatswerte.Next;
  end;
  dmMain.sqlSM_HoleMonatswerte.Close;
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection);
  FreeAndNil(qry_SynchConfig);
end;
procedure SynchOnlineBooking_ToServer(const AUserID: integer; ADate: TDate; ATime: TTime; ABookingType,AHOOffice:Integer; AWaitFrame: TWaitForm; bALL: Boolean);
var
  qry_SynchBookingTel: TFDQuery;
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  con_SQLConnection := dmMain.con_SQL.CloneConnection;
  dmMain.sqlSM_SetzeBuchung.SQLConnection := con_SQLConnection;
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
  AWaitFrame.SetWaitMessage('Buchung wird synchronisiert...', 'Synchronisierung');
  qry_SynchBookingTel.SQL.Text:= 'Select Datum,Zeit,Typ,Buchungsart From SynchBooking';
  qry_SynchBookingTel.open;
  dmMain.sqlSM_SetzeBuchung.ParamByName('ID_Benutzer').AsInteger := AUserID;
  dmMain.sqlSM_SetzeBuchung.ParamByName('Data').AsDataSet:= qry_SynchBookingTel;
  dmMain.sqlSM_SetzeBuchung.ExecuteMethod;
  qry_SynchBookingTel.Close;
  FreeandNil(qry_SynchBookingTel);
  con_SQLConnection.Connected:= false;
  FreeAndNil(con_SQLConnection)
end;
procedure Synchronisation(const AUserID, AServerID: Integer; ALogin, ABuchungen, ADevice, AFirstStart: Boolean; AWaitFrame: TWaitForm);
  function AddZeros(AValue: String; ACount: integer): string;
  begin
    if Length(AValue) > Acount then
    begin
      // die letzten count Stellen kopieren
      AValue := Copy(AValue, Length(AValue) - Acount + 1, Acount);
    end
    else begin
      // '0'-en hinzufügen
      while Length(AValue) < Acount do
        AValue := '0' + AValue;
    end;
    result:= AValue;
  end;
  function FormatDateTimeToStr(ADate: TDateTime): String ;
  var
    wJahr: word;
    wMonat: word;
    wTag: word;
    wStunde: word;
    wMinute: word;
    wSekunde: word;
    wMSek: word;
  begin
    Result := '';
    DecodeDateTime(ADate,wJahr,wMonat,wTag,wStunde,wMinute,wSekunde,wMSek);
    if (wStunde = 0) and (wMinute = 0) and (wSekunde = 0)  then
      Result:= IntToStr(wJahr) + '-' + AddZeros(IntToStr(wMonat), 2) + '-' + AddZeros(IntToStr(wTag), 2)
    else
      Result:= IntToStr(wJahr) + '-' + AddZeros(IntToStr(wMonat), 2) + '-' + AddZeros(IntToStr(wTag), 2) + ' ' +
               AddZeros(IntToStr(wStunde), 2) + ':' + AddZeros(IntToStr(wMinute), 2) +':' + AddZeros(IntToStr(wSekunde), 2)+ '.000';
  end;
  procedure SyncConfigTel(const AUserID, AServerID: Integer;const AFirstStart: Boolean; AWaitFrame: TWaitForm);
  var
    qry_SynchConfigTel: TFDQuery;
  begin
    AWaitFrame.SetWaitMessage('Konfiguration wird synchronisiert...', 'Synchronisierung');
    qry_SynchConfigTel:= TFDQuery.Create(nil);
    qry_SynchConfigTel.Connection:= dmmain.con_PCM;
    qry_SynchConfigTel.SQL.Text:= 'SELECT DeviceToken FROM Auto_login';
    qry_SynchConfigTel.open;
    dmMain.sqlSM_SetzeLogin.ParamByName('ID_Benutzer').AsInteger := AUserID;
    dmMain.sqlSM_SetzeLogin.ParamByName('Data').AsDataSet:= qry_SynchConfigTel;
    dmMain.sqlSM_SetzeLogin.ExecuteMethod;
    qry_SynchConfigTel.Close;
    FreeAndNil(qry_SynchConfigTel);
  end;
  procedure SyncConfig(const AUserID, AServerID: Integer;const AFirstStart: Boolean; AWaitFrame: TWaitForm);
  var
    iCount: integer;
    qry_SynchConfig: TFDQuery;
  begin
    qry_SynchConfig:= TFDQuery.Create(nil);
    qry_SynchConfig.Connection:= dmmain.con_PCM;
    AWaitFrame.SetWaitMessage('Konfiguration wird synchronisiert...', 'Synchronisierung');
    try
      dmMain.sqlSM_HoleLogin.ParamByName('ID_Benutzer').AsInteger := AUserID;
    except
      on e:Exception do
        WriteLog('Synch:' + e.message,0,false);
    end;
    try
      dmMain.sqlSM_HoleLogin.ExecuteMethod;
      dmMain.sqlSM_HoleLogin.Open;
      while not dmMain.sqlSM_HoleLogin.Eof do
      begin
        iCount:= GetCountFromTableLogin;
        if (AFirstStart) and (iCount = 0)  then
        begin
          qry_SynchConfig.SQL.Text := sSQL_INSERT_All_login;
          qry_SynchConfig.ParamByName('ID_Benutzer').AsInteger := dmmain.sqlSM_HoleLogin.FieldByName('ID').AsInteger;
          qry_SynchConfig.ParamByName('Benutzername').AsString := dmMain.sqlSM_HoleLogin.FieldByName('Benutzer').AsString;
          qry_SynchConfig.ParamByName('Passwort').AsString := dmMain.sqlSM_HoleLogin.FieldByName('Passwort').AsString;
          qry_SynchConfig.ParamByName('FirstStart').AsBoolean := True;
          qry_SynchConfig.ParamByName('ID_Server').AsInteger := AServerID;
          try
            qry_SynchConfig.ExecSQL;
          except
            on e:exception do
              WriteLog(e.Message,0,false)
          end;
        end else
        begin
          qry_SynchConfig.SQL.Text := sSQL_UPDATE_ALL_login;
          qry_SynchConfig.ParamByName('ID_Benutzer').AsInteger := dmMain.sqlSM_HoleLogin.FieldByName('ID').AsInteger;
          qry_SynchConfig.ParamByName('Benutzername').AsString := dmMain.sqlSM_HoleLogin.FieldByName('Benutzer').AsString;
          qry_SynchConfig.ParamByName('Passwort').AsString := dmMain.sqlSM_HoleLogin.FieldByName('Passwort').AsString;
          qry_SynchConfig.ParamByName('FirstStart').AsBoolean := False;
          qry_SynchConfig.ParamByName('ID_Server').AsInteger := AServerID;
          qry_SynchConfig.ExecSQL;
        end;
        dmMain.sqlSM_HoleLogin.Next;

      end;
      dmMain.sqlSM_HoleLogin.Close;
      FreeandNil(qry_SynchConfig);
    except
      dmMain.sqlSM_HoleLogin.Close;
      FreeandNil(qry_SynchConfig);
      Exit;
    end;
  end;
  procedure RegisterDevice(const AUserID: Integer; AWaitFrame: TWaitForm);
  begin
    if dmmain.sDeviceToken <> '' then
    begin
      AWaitFrame.SetWaitMessage('Gerät wird registriert...', 'Synchronisierung');
      dmMain.sqlSM_SetzeGeraeteID.ParamByName('ID_MA_Stammdaten').AsInteger := AUserID;
      dmMain.sqlSM_SetzeGeraeteID.ParamByName('DeviceID').AsString := dmmain.sDeviceID;
      dmMain.sqlSM_SetzeGeraeteID.ParamByName('DeviceToken').AsString := dmmain.sDeviceToken;
      {$IFDEF ANDROID}
      dmMain.sqlSM_SetzeGeraeteID.ParamByName('DeviceType').AsInteger := 0;
      {$ENDIF ANDROID}
      {$IFDEF IOS}
      dmMain.sqlSM_SetzeGeraeteID.ParamByName('ADeviceType').AsInteger := 1;
      {$ENDIF IOS}
      try
        dmMain.sqlSM_SetzeGeraeteID.ExecuteMethod;
        dmMain.sqlSM_SetzeGeraeteID.Close;
      except
        dmMain.sqlSM_SetzeGeraeteID.Close;
      end;
    end;
  end;
var
  con_SQLConnection : TSQLConnection;
begin
  con_SQLConnection := nil;
  try
    con_SQLConnection := dmMain.con_SQL.CloneConnection;
    try
      dmMain.sqlSM_HolePersonalDaten.SQLConnection := con_SQLConnection;
      dmMain.sqlSM_HoleLogin.SQLConnection := con_SQLConnection;
      dmMain.sqlSM_HoleLetzteBuchung.SQLConnection := con_SQLConnection;
      dmMain.sqlSM_SetzeLetzteBuchung.SQLConnection := con_SQLConnection;
      dmMain.sqlSM_HoleBuchungenJahr.SQLConnection := con_SQLConnection;
      dmMain.sqlSM_SetzeLogin.SQLConnection := con_SQLConnection;
      // Login Synchronisieren
      {$Region Login}
      if ALogin then
      begin
        try
          SyncConfig(AUserID, AServerID, AFirstStart, AWaitFrame);
          WriteLog('Konfiguration Server to App synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Konfiguration Server to App : ' + e.Message,2,false);
        end;
        try
          SyncConfigTel(AUserID, AServerID, AFirstStart, AWaitFrame);
          WriteLog('Konfiguration App to Server synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Konfiguration App to Server: ' + e.Message,2,false);
        end;
      end;
      {$EndRegion Login}
      //Buchungen Synchronisieren
      if ABuchungen then
      begin
        try
          SyncKontakte_FromServer(AUserID,0,AWaitFrame);
          WriteLog('Personal Server to App synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Personal Server to App: ' + e.Message,2,false);
        end;
        try
          SynchBookingYear_FromServer(AUserID, 0,YearOf(Date), AWaitFrame);
          WriteLog('Booking Server to App synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Booking Server to App: ' + e.Message,2,false);
        end;
        try
          SynchLastBooking_FromServer(AUserID, AServerID, AWaitFrame);
          WriteLog('Booking App to Server synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Kontakte App to Server: ' + e.Message,2,false);
        end;
        try
          SynchAbsenceConfig_FromServer(AUserID, AServerID, AWaitFrame);
          WriteLog('Booking App to Server synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Kontakte App to Server: ' + e.Message,2,false);
        end;
        try
          SynchAbsence_FromServer(AUserID, AServerID, AWaitFrame);
          WriteLog('Booking App to Server synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Kontakte App to Server: ' + e.Message,2,false);
        end;
      end;
      if ADevice then
      begin
        try
          RegisterDevice(AUserID, AWaitFrame);
          WriteLog('Gerät App to Server synchronisiert' ,0,false);
        except
          on e:Exception do
            WriteLog('Fehler Gerät App to Server: ' + e.Message,2,false);
        end;
      end;
      con_SQLConnection.Connected := False;
    except
      on e:Exception do
        WriteLog('Fehler Synch: ' + e.Message,2,false);
    end;
    FreeandNil(con_SQLConnection);
  except
    FreeandNil(con_SQLConnection);
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
