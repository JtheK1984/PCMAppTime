unit PCMAPP.System;

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
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.Async,
  FireDAC.Stan.Def,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.DialogService.Async,
  FMX.Edit,
  FMX.Forms,
  FMX.Gestures,
  FMX.Graphics,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.Objects,
  FMX.Platform,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  REST.Client,
  REST.Types,
  System.Classes,
  System.Devices,
  System.IOUtils,
  system.json,
  System.SysUtils,
  System.Threading,
  System.Types,
  System.UITypes,
  System.Variants;
  {$EndRegion Uses}
type
  {$Region Types}
  Tfrm_PCMAPP_System = class(TFrame)
    bckup_sqlBackup: TFDSQLiteBackup;
    btn_Restore: TButton;
    cbx_DesignStyle: TComboBox;
    cbx_Files: TComboBox;
    img_Backup: TImage;
    img_Biometrie: TImage;
    img_Design: TImage;
    img_FCMInfos: TImage;
    img_LocalAccount: TImage;
    img_log: TImage;
    img_ProductVersion: TImage;
    img_Reset: TImage;
    img_Restore: TImage;
    img_Userdata: TImage;
    lbl_All: TLabel;
    lbl_Ausgaben: TLabel;
    lbl_BackupDetailDescription: TLabel;
    lbl_BackupDetailHeader: TLabel;
    lbl_Belege: TLabel;
    lbl_BiometrieDetailBody: TLabel;
    lbl_BiometrieDetailHeader: TLabel;
    lbl_Description: TLabel;
    lbl_DesignStyle: TLabel;
    lbl_Einnahmen: TLabel;
    lbl_FMCInfosDetailGoogleInfo: TLabel;
    lbl_FMCInfosDetailToken: TLabel;
    lbl_Gutschein: TLabel;
    lbl_Kalender: TLabel;
    lbl_Kontakte: TLabel;
    lbl_LocalAccountDetailBody: TLabel;
    lbl_LocalAccountDetailHeader: TLabel;
    lbl_LogDetailBody: TLabel;
    lbl_LogDetailHeader: TLabel;
    lbl_Passwort: TLabel;
    lbl_ProductVersionImageDescription: TLabel;
    lbl_ProductVersionImageDeviceDetail: TLabel;
    lbl_ProductVersionImageOSDetail: TLabel;
    lbl_ProductVersionImageProviderDetail: TLabel;
    lbl_ProductVersionImageVersion: TLabel;
    lbl_ResetDetailDescription: TLabel;
    lbl_ResetDetailHeader: TLabel;
    lbl_RestoreDetailDescription: TLabel;
    lbl_RestoreDetailHeader: TLabel;
    lbl_Serials: TLabel;
    lbl_Tables: TLabel;
    lbl_Target: TLabel;
    lbl_UserdataDetailPasswort: TLabel;
    lbl_UserdataDetailServerBez: TLabel;
    lbl_UserdataDetailServerData: TLabel;
    lbl_UserdataDetailServerIP: TLabel;
    lbl_UserdataDetailServerPort: TLabel;
    lbl_UserdataDetailUser: TLabel;
    lbl_UserdataDetailUserdata: TLabel;
    lo_1All: TLayout;
    lo_2Kontakte: TLayout;
    lo_3Kalender: TLayout;
    lo_4Passwort: TLayout;
    lo_5Serials: TLayout;
    lo_6Einnahmen: TLayout;
    lo_7Ausgaben: TLayout;
    lo_8Belege: TLayout;
    lo_9Gutscheine: TLayout;
    lo_AllLabel: TLayout;
    lo_Allsw: TLayout;
    lo_AusgabenLabel: TLayout;
    lo_AusgabenSw: TLayout;
    lo_BackupDetail: TLayout;
    lo_BackupImage: TLayout;
    lo_BelegeLabel: TLayout;
    lo_BelegeSw: TLayout;
    lo_BiometrieDetail: TLayout;
    lo_BiometrieImage: TLayout;
    lo_BiometrieSwitch: TLayout;
    lo_DesignDetail: TLayout;
    lo_DesignImage: TLayout;
    lo_EinnahmenLabel: TLayout;
    lo_EinnahmenSw: TLayout;
    lo_FMCInfosDetail: TLayout;
    lo_FMCInfosImage: TLayout;
    lo_GutscheinLabel: TLayout;
    lo_GutscheinSw: TLayout;
    lo_KalenderLabel: TLayout;
    lo_KalenderSw: TLayout;
    lo_KontakteLabel: TLayout;
    lo_KontakteSw: TLayout;
    lo_LocalAccountDetail: TLayout;
    lo_LocalAccountImage: TLayout;
    lo_LocalAccountSwitch: TLayout;
    lo_LogDetail: TLayout;
    lo_LogImage: TLayout;
    lo_LogSwitch: TLayout;
    lo_PasswortLabel: TLayout;
    lo_PasswortSw: TLayout;
    lo_ProductVersionDetail: TLayout;
    lo_ProductVersionImage: TLayout;
    lo_ResetDetail: TLayout;
    lo_ResetImage: TLayout;
    lo_RestoreDetail: TLayout;
    lo_RestoreImage: TLayout;
    lo_SerialsLabel: TLayout;
    lo_SerialsSw: TLayout;
    lo_UserdataDetail: TLayout;
    lo_UserdataImage: TLayout;
    lstbx_SystemInformation: TListBox;
    lstbxitm_101Design: TListBoxItem;
    lstbxitm_102Biometrie: TListBoxItem;
    lstbxitm_103LocalAccount: TListBoxItem;
    lstbxitm_104Log: TListBoxItem;
    lstbxitm_105Userdata: TListBoxItem;
    lstbxitm_106Backup: TListBoxItem;
    lstbxitm_107Restore: TListBoxItem;
    lstbxitm_108Reset: TListBoxItem;
    lstbxitm_109ProductVersion: TListBoxItem;
    lstbxitm_110FCMInfos: TListBoxItem;
    mem_FMCInfosDetailToken: TMemo;
    prgbr_Restore: TProgressBar;
    qry_Main: TFDQuery;
    qry_Restore: TFDQuery;
    sw_All: TSwitch;
    sw_Ausgaben: TSwitch;
    sw_Belege: TSwitch;
    sw_Biometrie: TSwitch;
    sw_Einnahmen: TSwitch;
    sw_Gutschein: TSwitch;
    sw_Kalender: TSwitch;
    sw_Kontakt: TSwitch;
    sw_LocalAccount: TSwitch;
    sw_Log: TSwitch;
    sw_Passwort: TSwitch;
    sw_Serial: TSwitch;
    tc_Optionen: TTabControl;
    ti_1Optionen: TTabItem;
    ti_2Restore: TTabItem;
    vsbx_RestoreDetailView: TVertScrollBox;
    ListBoxItem1: TListBoxItem;
    lo_AutologinImage: TLayout;
    Image1: TImage;
    Layout2: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Layout3: TLayout;
    sw_Autologin: TSwitch;
    procedure btn_RestoreClick(Sender: TObject);
    procedure cbx_DesignStyleChange(Sender: TObject);
    procedure cbx_FilesChange(Sender: TObject);
    procedure lstbxitm_106BackupClick(Sender: TObject);
    procedure lstbxitm_107RestoreClick(Sender: TObject);
    procedure lstbxitm_108ResetClick(Sender: TObject);
    procedure lstbxitm_110FCMInfosClick(Sender: TObject);
    procedure sw_AllClick(Sender: TObject);
    procedure sw_BiometrieClick(Sender: TObject);
    procedure sw_LocalAccountClick(Sender: TObject);
    procedure sw_LogClick(Sender: TObject);
    procedure sw_AutologinClick(Sender: TObject);
  private
    { Private-Deklarationen }
    qry_Work: TFDQuery;
    procedure SetDesign;
  public
    procedure Execute;
    { Public-Deklarationen }
  end;
  {$endRegion Types}
implementation
{$R *.fmx}
uses
  {$Region Uses}
  PCMAPP.Datamodul,
  PCMAPP.Funktionen,
  PCMApp.Main,
  PCMAPP.SQL;
  {$EndRegion Uses}
////////////////////////////////////////////////////////////////////////////////
// Functions                                                                  //
////////////////////////////////////////////////////////////////////////////////
{$Region Functions}
procedure Tfrm_PCMAPP_System.Execute;
  procedure ReadInformation;
  {$IFDEF ANDROID}
  var
    PackageManager: JPackageManager;
    PackageInfo : JPackageInfo;
  {$ENDIF ANDROID}
  begin
    qry_Work:= TFDQuery.Create(nil);
    qry_Work.Connection:= dmmain.con_PCM;
    qry_Work.SQL.Text:= sSQL_SELECT_All_Server;
    qry_Work.open;
    lbl_UserdataDetailServerBez.Text:= 'Server-Bezeichnung: ' + qry_Work.FieldByName('Bezeichnung').AsString;
    lbl_UserdataDetailServerIP.Text:= 'Server-IP: ' + qry_Work.FieldByName('Hostname').AsString;
    lbl_UserdataDetailServerPort.Text:= 'Server-Port: ' + qry_Work.FieldByName('Port').AsString;
    qry_Work.Close;
    {$IFDEF ANDROID}
    PackageManager := TAndroidHelper.Activity.getPackageManager;
    PackageInfo := PackageManager.getPackageInfo(TAndroidHelper.Context.getPackageName(), TJPackageManager.JavaClass.GET_ACTIVITIES);
    lbl_ProductVersionImageVersion.Text:= 'App-Version: ' + JStringToString(PackageInfo.versionName);
    lbl_ProductVersionImageOSDetail.text:=  'Android-Version: ' + frm_PCM_Main.sOSDetail;
    lbl_ProductVersionImageDeviceDetail.Text:= 'Geräte-Typ: ' + frm_PCM_Main.sDeviceDetail;
    lbl_ProductVersionImageProviderDetail.text:= 'Netzbetreiber: ' + frm_PCM_Main.sProviderDetail;
    mem_FMCInfosDetailToken.Text:=   dmmain.sDeviceToken;
    {$ENDIF ANDROID}
    {$IFDEF MSWINDOWS}
    lbl_ProductVersionImageVersion.Text:= 'App-Version: 1.6.0';
    lbl_ProductVersionImageOSDetail.text:=  'Windows-Version: ' + TOSVersion.ToString;
    lbl_ProductVersionImageDeviceDetail.Text:= 'Geräte-Typ: ' + GetDeviceType;
    lbl_ProductVersionImageProviderDetail.text:= '';
    {$ENDIF MSWINDOWS}
    FreeAndnil(qry_Work);
  end;
begin
  cbx_DesignStyle.Clear;
  {$IFDEF ANDROID}
  cbx_DesignStyle.items.Add('Calypso');
  cbx_DesignStyle.items.Add('Hell');
  cbx_DesignStyle.items.Add('Dunkel');
  cbx_DesignStyle.items.Add('Dunkel Blau');
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  cbx_DesignStyle.items.Add('Calypso');
  cbx_DesignStyle.items.Add('Hell');
  cbx_DesignStyle.items.Add('Dunkel');
  cbx_DesignStyle.items.Add('Mineshaft');
  cbx_DesignStyle.items.Add('Ubuntu');
  {$ENDIF MSWINDOWS}
  cbx_DesignStyle.ItemIndex:= frm_pcm_main.iDesignAPP;
  SetDesign;
  tc_Optionen.ActiveTab:= ti_1Optionen;
  ReadInformation;
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text := sSQL_SELECT_All_AUTOLOGIN;
  qry_Work.Open;
  if qry_Work.RecordCount > 0 then
  begin
    try
      lbl_UserdataDetailUser.text:= 'Benutzer: ' + qry_Work.FieldByName('Benutzername').AsString;
    except
    end;
    if qry_Work.FieldByName('FingerAuthenticate').AsBoolean = True then
    begin
      sw_Biometrie.IsChecked:= true;
    end
    else
    begin
      sw_Biometrie.IsChecked:= false;
    end;
    if qry_Work.FieldByName('localaccount').AsBoolean = True then
    begin
      sw_LocalAccount.IsChecked:= true;
    end
    else
    begin
      sw_LocalAccount.IsChecked:= false;
    end;
    if qry_Work.FieldByName('Log').asInteger = 1 then
    begin
      sw_Log.IsChecked:= true;
    end
    else
    begin
      sw_Log.IsChecked:= false;
    end;
    if qry_Work.FieldByName('Autologin').asInteger = 1 then
    begin
      sw_Autologin.IsChecked:= true;
    end
    else
    begin
      sw_Autologin.IsChecked:= false;
    end;

    lbl_UserdataDetailPasswort.text:= 'Passwort: ********';
    FreeAndnil(qry_Work);
  end;
  frm_PCM_Main.tc_More.ActiveTab := frm_PCM_Main.ti_2ConfigConfig;
  frm_PCM_Main.lbl_ModulName.Text := 'Einstellungen';
  frm_PCM_Main.SetDisableToolButtons;
//  frm_PCM_Main.btn_Synchronisation.Visible := True;
  frm_PCM_Main.btn_BackSystem.Visible := True;
  {$IFDEF MSWINDOWS}
  lstbxitm_102Biometrie.Visible:= false;
//  lstbxitm_110ProductVersion.Visible:= false;
  lstbxitm_110FCMInfos.Visible:= false;
  {$ENDIF MSWINDOWS}
end;
procedure Tfrm_PCMAPP_System.SetDesign;
var
  iDesignStyle: Integer;
  TextColor: Cardinal;
  icbxCount: Integer;
begin
  TextColor:= TAlphaColorRec.White;
  {$IFDEF ANDROID}
  iDesignStyle:= frm_PCM_Main.iDesignapp;
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  iDesignStyle:= frm_PCM_Main.iDesignwin;
  {$ENDIF MSWINDOWS}
  case iDesignStyle of
    0:
    begin
      TextColor:= TAlphaColorRec.White;
    end;
    1:
    begin
      TextColor:= TAlphaColorRec.Black;
    end;
    2:
    begin
      TextColor:= TAlphaColorRec.White;
    end;
    3:
    begin
      TextColor:= TAlphaColorRec.White;
    end;
    {$IFDEF MSWINDOWS}
    4:
    begin
      TextColor:= TAlphaColorRec.White;
    end;
    {$ENDIF MSWINDOWS}
  end;
  for icbxCount := 0 to cbx_Designstyle.count - 1 do
  begin
    cbx_Designstyle.ListBox.ListItems[icbxCount].StyledSettings:= cbx_Designstyle.ListBox.ListItems[icbxCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
    cbx_Designstyle.ListBox.ListItems[icbxCount].TextSettings.Font.Size:= 14;
    cbx_Designstyle.ListBox.ListItems[icbxCount].TextSettings.FontColor:= TextColor;
  end;
end;
{$EndRegion Functions}
////////////////////////////////////////////////////////////////////////////////
// Button FUNCTIONS                                                           //
////////////////////////////////////////////////////////////////////////////////
{$Region Buttonfunctions}
procedure Tfrm_PCMAPP_System.btn_RestoreClick(Sender: TObject);
begin
//  TDialogServiceAsync.MessageDialog('Möchten Sie die ausgewählten Tabellen wiederherstellen? Alle Daten werden gelöscht',
//  TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbNo, 0,
//  procedure(const AResult: TModalResult)
//  begin
//    if AResult = mrYes then
//    begin
//      dmmain.wfWaitFrame.Execute('Wiederherstellung wird gestartet...', 'Wiederherstellung',True);
//      TTask.Run(
//      procedure
//      begin
//        try
//          prgbr_Restore.Min:= 0;
//          dmMain.con_Restore.Params.Values['Database'] := TPath.Combine(TPath.GetsharedDocumentsPath, cbx_Files.Items[cbx_Files.Itemindex]);
//          dmMain.con_Restore.Connected:= true;
//          {$Region Passwort}
//          if sw_Passwort.IsChecked then
//          begin
//            prgbr_Restore.value:= 0;
//            qry_Restore.SQL.Text:= 'SELECT * FROM passwoerter';
//            qry_Main.SQL.Text:= 'Delete From passwoerter';
//            qry_Main.ExecSQL;
//            prgbr_Restore.Max:= qry_Restore.RecordCount;
//            qry_Restore.open;
//            while not qry_Restore.Eof do
//            begin
//              prgbr_Restore.Value:= prgbr_Restore.Value + 1;
//              qry_Main.SQl.Text:= 'Insert into passwoerter (Bezeichnung,user,password,link,' +
//                                  'VPN_SharedSecret,APP_IP,APP_Port,APP_Verschluesselung,MAIL_Posteingangsserver,' +
//                                  'MAIL_PosteingangsPort,MAIL_PosteingangsVerschluesselung,MAIL_Postausgangsserver,MAIL_PostausgangsPort,MAIL_PostausgangsVerschluesselung,PWTyp,WLAN,Deleted) Values ' +
//                                  ' (:Bezeichnung,:user,:password,:link,' +
//                                  ':VPN_SharedSecret,:APP_IP,:APP_Port,:APP_Verschluesselung,:MAIL_Posteingangsserver,' +
//                                  ':MAIL_PosteingangsPort,:MAIL_PosteingangsVerschluesselung,:MAIL_Postausgangsserver,:MAIL_PostausgangsPort,:MAIL_PostausgangsVerschluesselung,:PWTyp,:WLAN,:Deleted)';
//              try
//                qry_Main.ParamByName('Bezeichnung').AsString:= qry_Restore.FieldByName('Bezeichnung').AsString;
//                qry_Main.ParamByName('user').AsString:= qry_Restore.FieldByName('user').AsString;
//                qry_Main.ParamByName('password').AsString:= qry_Restore.FieldByName('password').AsString;
//                qry_Main.ParamByName('link').AsString:= qry_Restore.FieldByName('link').AsString;
//                qry_Main.ParamByName('VPN_SharedSecret').AsString:= qry_Restore.FieldByName('VPN_SharedSecret').AsString;
//                qry_Main.ParamByName('APP_IP').AsString:= qry_Restore.FieldByName('APP_IP').AsString;
//                qry_Main.ParamByName('APP_Port').asInteger:= qry_Restore.FieldByName('APP_Port').asInteger;
//                qry_Main.ParamByName('APP_Verschluesselung').AsString:= qry_Restore.FieldByName('APP_Verschluesselung').AsString;
//                qry_Main.ParamByName('MAIL_Posteingangsserver').AsString:= qry_Restore.FieldByName('MAIL_PostausgangsVerschluesselung').AsString;
//                qry_Main.ParamByName('MAIL_PosteingangsPort').asInteger:= qry_Restore.FieldByName('MAIL_PosteingangsPort').asInteger;
//                qry_Main.ParamByName('MAIL_PosteingangsVerschluesselung').AsString:= qry_Restore.FieldByName('MAIL_PosteingangsVerschluesselung').AsString;
//                qry_Main.ParamByName('MAIL_Postausgangsserver').AsString:= qry_Restore.FieldByName('MAIL_Postausgangsserver').AsString;
//                qry_Main.ParamByName('MAIL_PostausgangsPort').asInteger:= qry_Restore.FieldByName('MAIL_PostausgangsPort').asInteger;
//                qry_Main.ParamByName('MAIL_PostausgangsVerschluesselung').AsString:= qry_Restore.FieldByName('MAIL_PostausgangsVerschluesselung').AsString;
//                qry_Main.ParamByName('PWTyp').AsString:= qry_Restore.FieldByName('PWTyp').AsString;
//                qry_Main.ParamByName('WLAN').AsString:= qry_Restore.FieldByName('WLAN').AsString;
//                qry_Main.ParamByName('Deleted').AsBoolean:= qry_Restore.FieldByName('Deleted').AsBoolean;
//                qry_Main.ExecSQL;
//              except
//              end;
//              qry_Restore.Next
//            end;
//          end;
//          {$EndRegion}
//          {$Region Ausgaben}
//          if sw_Ausgaben.IsChecked then
//          begin
//            prgbr_Restore.value:= 0;
//            qry_Restore.SQL.Text:= 'SELECT ID, IFNULL(Name,'''') AS Name, IFNULL(Beschreibung,'''') AS Beschreibung, IFNULL(Kontonummer,'''') AS Kontonummer,'+
//                                  'IFNULL(Bankleitzahl,'''') AS Bankleitzahl, IFNULL(Betrag,0) AS Betrag, IFNULL(FixBetrag,0) AS FixBetrag,IFNULL(Fixkosten,0) AS Fixkosten,'+
//                                  'IFNULL(Gueltig_Monat,0) AS Gueltig_Monat,IFNULL(Gueltig_Jahr,0) AS Gueltig_Jahr,IFNULL(Verwendungszweck,'''') AS Verwendungszweck,'+
//                                  'IFNULL(Finanzen_Ausgaben_ID,0) AS Finanzen_Ausgaben_ID,IFNULL(GeaendertAM,''2023-08-10 21:28:45'') AS GeaendertAM,'+
//                                  'IFNULL(Deleted,0) AS Deleted FROM FinanzenAusgaben';
//            qry_Main.SQL.Text:= 'Delete From FinanzenAusgaben';
//            qry_Main.execsql;
//            prgbr_Restore.Max:= qry_Restore.RecordCount;
//            qry_Restore.open;
//            while not qry_Restore.Eof do
//            begin
//              prgbr_Restore.Value:= prgbr_Restore.Value + 1;
//              qry_Main.SQl.Text:= 'Insert into FinanzenAusgaben (Name,Beschreibung,Kontonummer,Bankleitzahl,Betrag,FixBetrag,Fixkosten,Gueltig_Monat,Gueltig_Jahr,Verwendungszweck,Finanzen_Ausgaben_ID,GeaendertAm,Deleted) Values ' +
//                                  ' (:Name,:Beschreibung,:Kontonummer,:Bankleitzahl,:Betrag,:FixBetrag,:Fixkosten,:Gueltig_Monat,:Gueltig_Jahr,:Verwendungszweck,:Finanzen_Ausgaben_ID,:GeaendertAm,:Deleted)';
//              try
//                qry_Main.ParamByName('Name').AsString:= qry_Restore.FieldByName('Name').AsString;
//                qry_Main.ParamByName('Beschreibung').AsString:= qry_Restore.FieldByName('Beschreibung').AsString;
//                qry_Main.ParamByName('Kontonummer').AsString:= qry_Restore.FieldByName('Kontonummer').AsString;
//                qry_Main.ParamByName('Bankleitzahl').AsString:= qry_Restore.FieldByName('Bankleitzahl').AsString;
//                qry_Main.ParamByName('Betrag').asFloat:= qry_Restore.FieldByName('Betrag').asFloat;
//                qry_Main.ParamByName('FixBetrag').asFloat:= qry_Restore.FieldByName('FixBetrag').asFloat;
//                qry_Main.ParamByName('Fixkosten').asinteger:= qry_Restore.FieldByName('Fixkosten').asinteger;
//                qry_Main.ParamByName('Gueltig_Monat').asinteger:= qry_Restore.FieldByName('Gueltig_Monat').asinteger;
//                qry_Main.ParamByName('Gueltig_Jahr').asinteger:= qry_Restore.FieldByName('Gueltig_Jahr').asinteger;
//                qry_Main.ParamByName('Verwendungszweck').AsString:= qry_Restore.FieldByName('Verwendungszweck').AsString;
//                qry_Main.ParamByName('Finanzen_Ausgaben_ID').AsInteger:= qry_Restore.FieldByName('Finanzen_Ausgaben_ID').AsInteger;
//                qry_Main.ParamByName('GeaendertAm').AsString:= qry_Restore.FieldByName('GeaendertAm').AsString;
//                qry_Main.ParamByName('Deleted').AsString:= qry_Restore.FieldByName('Deleted').AsString;
//                qry_Main.ExecSQL;
//              except
//              end;
//
//              qry_Restore.Next
//            end;
//          end;
//          {$ENDRegion}
//          {$Region Belege}
//          if sw_Belege.IsChecked then
//          begin
//            prgbr_Restore.value:= 0;
//            qry_Restore.SQL.Text:= 'SELECT ID, IFNULL(Nummer,'''') AS Nummer,IFNULL(Datum,DATE()) AS Datum,IFNULL(Aussteller, '''') AS Aussteller,'+
//                                  'IFNULL(Betrag,0) AS Betrag,IFNULL(Kategorie,0) AS Kategorie,IFNULL(Belege_ID,0) AS Belege_ID,'+
//                                  'IFNULL(GeaendertAM,''2023-08-10 21:28:45'') AS GeaendertAM,IFNULL(Deleted,0) AS Deleted FROM Belege';
//            qry_Main.SQL.Text:= 'Delete FROM Belege';
//            qry_Main.ExecSQL;
//            prgbr_Restore.Max:= qry_Restore.RecordCount;
//            qry_Restore.open;
//            while not qry_Restore.Eof do
//            begin
//              prgbr_Restore.Value:= prgbr_Restore.Value + 1;
//              qry_Main.SQl.Text:= 'Insert into Belege (Nummer,Datum,Aussteller,Betrag,Kategorie,Belege_ID,GeaendertAm,Deleted) Values ' +
//                                  ' (:Nummer,:Datum,:Aussteller,:Betrag,:Kategorie,:Belege_ID,:GeaendertAm,:Deleted)';
//              try
//                qry_Main.ParamByName('Nummer').AsString:= qry_Restore.FieldByName('Nummer').AsString;
//                qry_Main.ParamByName('Datum').AsString:= qry_Restore.FieldByName('Datum').AsString;
//                qry_Main.ParamByName('Aussteller').AsString:= qry_Restore.FieldByName('Aussteller').AsString;
//                qry_Main.ParamByName('Betrag').AsFloat:= qry_Restore.FieldByName('Betrag').asFloat;
//                qry_Main.ParamByName('Kategorie').AsInteger:= qry_Restore.FieldByName('Kategorie').AsInteger;
//                qry_Main.ParamByName('Belege_ID').AsInteger:= qry_Restore.FieldByName('Belege_ID').AsInteger;
//                qry_Main.ParamByName('GeaendertAm').AsString:= qry_Restore.FieldByName('GeaendertAm').AsString;
//                qry_Main.ParamByName('Deleted').AsString:= qry_Restore.FieldByName('Deleted').AsString;
//                qry_Main.ExecSQL;
//              except
//              end;
//              qry_Restore.Next
//            end;
//          end;
//          {$EndRegion}
//          {$Region Gutschein}
//          if sw_Gutschein.IsChecked then
//          begin
//            prgbr_Restore.value:= 0;
//            qry_Restore.SQL.Text:= 'SELECT ID, IFNULL(Nummer,'''') AS Nummer,IFNULL(Bezeichnung, ''Gutschein'') AS Bezeichnung,'+
//                                  'IFNULL(Wert,0) AS Wert,IFNULL(RestWert,0) AS RestWert,IFNULL(Datum,DATE()) AS Datum,'+
//                                  'IFNULL(AbfragePin,'''') AS AbfragePin,IFNULL(Gutschein_ID,0) AS Gutschein_ID,IFNULL(GeaendertAM,''2023-08-10 21:28:45'') AS GeaendertAM,'+
//                                  'IFNULL(Deleted,0) AS Deleted FROM Gutschein';
//            qry_Main.SQL.Text:= 'Delete From Gutschein';
//            qry_Main.ExecSQL;
//            prgbr_Restore.Max:= qry_Restore.RecordCount;
//            qry_Restore.open;
//            while not qry_Restore.Eof do
//            begin
//              prgbr_Restore.Value:= prgbr_Restore.Value + 1;
//              qry_Main.SQl.Text:= 'Insert into Gutschein (Nummer,Bezeichnung,Wert,RestWert,Datum,AbfragePin,Gutschein_ID,GeaendertAm,Deleted) Values ' +
//                                  ' (:Nummer,:Bezeichnung,:Wert,:RestWert,:Datum,:AbfragePin,:Gutschein_ID,:GeaendertAm,:Deleted)';
//              try
//                qry_Main.ParamByName('Nummer').AsString:= qry_Restore.FieldByName('Nummer').AsString;
//
//                qry_Main.ParamByName('Bezeichnung').AsString:= qry_Restore.FieldByName('Bezeichnung').AsString;
//                qry_Main.ParamByName('Wert').AsFloat:= qry_Restore.FieldByName('Wert').AsFloat;
//                qry_Main.ParamByName('RestWert').AsFloat:= qry_Restore.FieldByName('RestWert').AsFloat;
////                  sDate:=
//                qry_Main.ParamByName('Datum').asString:= qry_Restore.FieldByName('Datum').asString;
//                qry_Main.ParamByName('AbfragePin').asString:= qry_Restore.FieldByName('AbfragePin').asString;
//                qry_Main.ParamByName('Gutschein_ID').asInteger:= qry_Restore.FieldByName('Gutschein_ID').asInteger;
//                qry_Main.ParamByName('GeaendertAm').asString:= qry_Restore.FieldByName('GeaendertAm').asString;
//                qry_Main.ParamByName('Deleted').asString:= qry_Restore.FieldByName('Deleted').asString;
//                qry_Main.ExecSQL;
//              except
//              end;
//              qry_Restore.Next
//            end;
//          end;
//          {$EndRegion}
//          Sleep(5000);
//          dmmain.wfWaitFrame.HideFW;
//          tc_Optionen.ActiveTab:= ti_1Optionen;
//        except
//        on e:Exception do
//          begin
//            dmmain.wfWaitFrame.HideFW;
//            tc_Optionen.ActiveTab:= ti_1Optionen;
//          end;
//        end;
//
//      end);
//    end;
//  end);

end;
procedure Tfrm_PCMAPP_System.cbx_DesignStyleChange(Sender: TObject);
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  {$IFDEF MSWINDOWS}
  qry_Work.SQL.Text := sSQL_UPDATE_DesginWin_Autologin;
  qry_Work.ParamByName('Design').AsInteger:= cbx_DesignStyle.ItemIndex;
  qry_Work.ExecSQL;
  frm_PCM_Main.idesignwin:= cbx_DesignStyle.ItemIndex;
  frm_PCM_main.SetDesign(0,frm_PCM_Main.idesignwin);
  {$ENDIF MSWINDOWS}
  {$IFDEF ANDROID}
  qry_Work.SQL.Text := sSQL_UPDATE_DesginAPP_Autologin;
  qry_Work.ParamByName('Design').AsInteger:= cbx_DesignStyle.ItemIndex;
  qry_Work.ExecSQL;
  frm_PCM_Main.idesignAPP:= cbx_DesignStyle.ItemIndex;
  frm_PCM_Main.SetDesign(frm_PCM_Main.idesignAPP,0);
  {$ENDIF ANDROID}
  SetDesign;
  FreeAndnil(qry_Work);
end;
procedure Tfrm_PCMAPP_System.cbx_FilesChange(Sender: TObject);
begin
  if cbx_Files.ItemIndex > -1  then
  begin
    sw_All.Enabled:= true;
    sw_Kontakt.enabled:= true;
    sw_Kalender.enabled:= true;
    sw_Passwort.enabled:= true;
    sw_Serial.enabled:= true;
    sw_Einnahmen.enabled:= true;
    sw_Ausgaben.enabled:= true;
    sw_Belege.enabled:= true;
    sw_Gutschein.enabled:= true;
  end;
end;
procedure Tfrm_PCMAPP_System.lstbxitm_106BackupClick(Sender: TObject);
var
  sDestDB: String;
begin
  TDialogServiceAsync.MessageDialog('Möchten Sie ein Backup Ihrer Daten durchführen?',
  TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbNo, 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYes then
    begin
      dmmain.wfWaitFrame.Execute('Backup wird erstellt...', 'Backup',True);
      TTask.Run(
        procedure
        begin
          sDestDB := FormatDateTime('yyyymmdd__hhmm', Now) + '_PCMTime.s3db';
          bckup_sqlBackup.Database := TPath.Combine(TPath.GetDocumentsPath, 'PCMTime.s3db');
          {$IFDEF ANDROID}
          bckup_sqlBackup.DestDatabase := TPath.Combine(TPath.GetSharedDocumentsPath, sDestDB);
          {$ENDIF ANDROID}
          Sleep(5000);
          bckup_sqlBackup.Backup;
          dmmain.wfWaitFrame.HideFW;
        end);
    end;
  end);
end;
procedure Tfrm_PCMAPP_System.lstbxitm_107RestoreClick(Sender: TObject);
var
  iComboboxEintraege: integer;
  iDateiAnzahl: integer;
  strdynarrList: TStringDynArray;
begin
  try
    sw_All.Enabled:= false;
    sw_Kontakt.enabled:= false;
    sw_Kalender.enabled:= false;
    sw_Passwort.enabled:= false;
    sw_Serial.enabled:= false;
    sw_Einnahmen.enabled:= false;
    sw_Ausgaben.enabled:= false;
    sw_Belege.enabled:= false;
    sw_Gutschein.enabled:= false;
    cbx_Files.Clear;
    strdynarrList := TDirectory.GetFiles(TPath.GetsharedDocumentsPath);//, TSearchOption.soTopDirectoryOnly, '*.*');
    for iDateiAnzahl := 0 to Length(strdynarrList) - 1 do
      cbx_Files.items.Add(ExtractFileName(strdynarrList[iDateiAnzahl]));
    for iComboboxEintraege := 0 to cbx_Files.count - 1 do
    begin
      cbx_Files.ListBox.ListItems[iComboboxEintraege].StyledSettings:= cbx_Files.ListBox.ListItems[iComboboxEintraege].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cbx_Files.ListBox.ListItems[iComboboxEintraege].TextSettings.Font.Size:= 14;
      cbx_Files.ListBox.ListItems[iComboboxEintraege].TextSettings.FontColor:= TAlphaColors.White;
    end;
  except
  end;
  try
  tc_Optionen.ActiveTab:= ti_2Restore;
  except
  end;
end;
procedure Tfrm_PCMAPP_System.lstbxitm_108ResetClick(Sender: TObject);
begin
  TDialogServiceAsync.MessageDialog('ACHTUNG: Wenn Sie alle Daten löschen, muss bei der nächsten Anmeldung ' + #13 + 'ein aktive Serververbindung bestehen und Sie müssen Ihre Zugangsadaten erneut eingeben! Möchten Sie fortfahren?',
  TMsgDlgType.mtWarning, mbYesNo, TMsgDlgBtn.mbNo, 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYes then
    begin
      DeleteAllTables;
      CreateDatabase;
      frm_PCM_Main.logout;
    end;
  end);

end;
procedure Tfrm_PCMAPP_System.lstbxitm_110FCMInfosClick(Sender: TObject);
var
  joBodyMain,joBodySub: TJSONObject;
  sUploadstate: String;
begin
  joBodyMain:= TJSONObject.Create;
  joBodyMain.AddPair(TJSONPair.Create('to',mem_FMCInfosDetailToken.text));
  joBodyMain.AddPair(TJSONPair.Create('priority','high'));
  joBodySub:= TJSONObject.Create;
  joBodySub.AddPair(TJSONPair.Create('body','App-Benachrichtigung Test erfolgreich'));
  joBodySub.AddPair(TJSONPair.Create('title','App-Benachrichtigung Test'));
  joBodyMain.AddPair(TJSONPair.Create('notification',joBodySub));
  sUploadstate:= joBodyMain.ToString;
  dmmain.RESTRequest2.Params.AddItem('Authorization', 'Bearer AAAAKei3FDU:APA91bHidAp5KysKnJeC0zMHHs242AW-DN9GHepIEOQgqJeCni82g9l6m324q71H5Rn3yThrjLW-rH5W1P7KV4TC32eDeUUB4zeHmTv4AhTjTGVYc384BzUMUaDSY6x8KtqqkydOoq5a', pkHTTPHEADER, [poDoNotEncode]);
  dmmain.RESTRequest2.Body.Add(joBodyMain);
  dmmain.RESTRequest2.Execute;
  dmmain.RESTRequest2.ClearBody;
  dmmain.RESTRequest2.Body.ClearBody;
end;
procedure Tfrm_PCMAPP_System.sw_AllClick(Sender: TObject);
begin
 if sw_All.IsChecked then
  begin
    lbl_Description.Text:= 'Sie haben alle Tabellen ausgewählt. Hierbei werden auch alle Systemrelevanten Tabellen wiederhergestellt.';

    sw_Kontakt.IsChecked:= true;
    sw_Kontakt.enabled:= false;

    sw_Kalender.IsChecked:= true;
    sw_Kalender.enabled:= false;

    sw_Passwort.IsChecked:= true;
    sw_Passwort.enabled:= false;

    sw_Serial.IsChecked:= true;
    sw_Serial.enabled:= false;

    sw_Einnahmen.IsChecked:= true;
    sw_Einnahmen.enabled:= false;

    sw_Ausgaben.IsChecked:= true;
    sw_Ausgaben.enabled:= false;

    sw_Belege.IsChecked:= true;
    sw_Belege.enabled:= false;

    sw_Gutschein.IsChecked:= true;
    sw_Gutschein.enabled:= false;

  end
  else begin
    lbl_Description.Text:= 'Sie haben nur einzelne Tabellen ausgewählt. Hierbei werden nur die Tabellen wiederhergestellt, die Sie ausgewählt haben.';
    sw_Kontakt.enabled:= true;
    sw_Kalender.enabled:= true;
    sw_Passwort.enabled:= true;
    sw_Serial.enabled:= true;
    sw_Einnahmen.enabled:= true;
    sw_Ausgaben.enabled:= true;
    sw_Belege.enabled:= true;
    sw_Gutschein.enabled:= true;
  end;
end;
procedure Tfrm_PCMAPP_System.sw_AutologinClick(Sender: TObject);
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text := sSQL_UPDATE_FingerAutologin_AUTOLOGIN;
  if sw_Autologin.IsChecked then
  begin
    qry_Work.ParamByName('Autologin').asBoolean:= true;
    qry_Work.ParamByName('Finger').asBoolean:= false;
    sw_Biometrie.IsChecked:= false;
  end
  else begin
    qry_Work.ParamByName('Autologin').asBoolean:= false;
  end;
  qry_Work.ExecSQL;
  FreeAndnil(qry_Work);
end;
procedure Tfrm_PCMAPP_System.sw_BiometrieClick(Sender: TObject);
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text := sSQL_UPDATE_FingerAutologin_AUTOLOGIN;
  if sw_Biometrie.IsChecked then
  begin
    qry_Work.ParamByName('Finger').AsBoolean:= true;
    qry_Work.ParamByName('Autologin').AsBoolean:= false;
    sw_Autologin.IsChecked:= false;
  end
  else begin
    qry_Work.ParamByName('Finger').AsBoolean:= false;
  end;
  qry_Work.ExecSQL;
  FreeAndnil(qry_Work);
end;
procedure Tfrm_PCMAPP_System.sw_LocalAccountClick(Sender: TObject);
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text := sSQL_UPDATE_LOCALACCOUNT_Autologin;
  if sw_LocalAccount.IsChecked then
    qry_Work.ParamByName('localaccount').AsBoolean:= true
  else
    qry_Work.ParamByName('localaccount').AsBoolean:= false;
  qry_Work.ExecSQL;
  FreeAndnil(qry_Work);
end;
procedure Tfrm_PCMAPP_System.sw_LogClick(Sender: TObject);
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text := sSQL_UPDATE_LOG_Autologin;
  if sw_log.IsChecked then
    qry_Work.ParamByName('Log').asInteger:= 1
  else
    qry_Work.ParamByName('Log').asInteger:= 0;
  qry_Work.ExecSQL;
  FreeAndnil(qry_Work);
end;
{$EndRegion Buttonfunctions}
end.
