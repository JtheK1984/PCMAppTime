unit PCMAPP.Main;

interface

uses
  {$Region Uses}
  {$IFDEF ANDROID}
  Androidapi.AppGlue,
  Androidapi.Helpers,
  Androidapi.JNI.App,
  Androidapi.JNI.Embarcadero,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Javatypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNIBridge,
  Androidapi.NativeActivity,
  FMX.BiometricAuth,
  FMX.VirtualKeyboard,
  {$ENDIF ANDROID}
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.FMXUI.Wait,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Async,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.UI.Intf,
  FMX.ActnList,
  FMX.Ani,
  FMX.Calendar,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.DateTimeCtrls,
  FMX.Dialogs,
  FMX.DialogService,
  FMX.DialogService.Async,
  FMX.Edit,
  FMX.EditBox,
  FMX.Forms,
  FMX.Gestures,
  FMX.Graphics,
  FMX.Grid,
  FMX.Grid.Style,
  FMX.ImgList,
  FMX.Memo,
  FMX.Memo.Types,
  FMX.MultiView,
  FMX.NumberBox,
  FMX.Layouts,
  FMX.ListBox,
  FMX.ListView,
  FMX.ListView.Adapters.Base,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.Objects,
  FMX.Platform,
  FMX.PhoneDialer,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.TreeView,
  FMX.Types,
  IdIPAddress,
  IdGlobal,
  IdHashMessageDigest,
  IdStack,
  REST.Backend.BindSource,
  REST.Backend.KinveyProvider,
  REST.Backend.KinveyPushDevice,
  REST.Backend.PushDevice,
  REST.Backend.PushTypes,
  Soap.EncdDecd,Data.SqlExpr,
  {$IFDEF MSWINDOWS}
  ShellAPI,
  {$EndIF MSWINDOWS}
  System.Actions,
  System.Classes,
  system.DateUtils,
  System.ImageList,
  System.JSON,IdTCPClient,
  system.math,
  System.Messaging,
  System.NetEncoding,
  System.Notification,
  System.PushNotification,
  System.Permissions,
  System.Rtti,
  System.StrUtils,
  System.SysUtils,
  System.Threading,
  System.Types,
  System.UITypes,
  System.Variants,
  PCMAPP.Buchungen.Detail,
  PCMAPP.Fehltage.Detail,
  PCMAPP.Funktionen,
  PCMAPP.System,
  PCMAPP.WaitForm;
  {$EndRegion Uses}
type
  {$Region Types}
  TStringArray = TArray<TDateTime>;
  Tfrm_PCM_Main = class(TForm)
    btn_AddData: TButton;
    btn_BackSystem: TButton;
    btn_BookingBreakBegin: TButton;
    btn_BookingBreakend: TButton;
    btn_BookingWorkBegin: TButton;
    btn_BookingWorkEnd: TButton;
    btn_Calc: TButton;
    btn_CloseApp: TButton;
    btn_FehltageFilter: TButton;
    btn_lock: TButton;
    btn_Login: TButton;
    btn_LoginBiometrie: TButton;
    btn_Multiview: TButton;
    btn_Search: TButton;
    btn_Synchronisation: TButton;
    btn_TouchMeLabel: TLabel;
    btn_Unlock: TButton;
    btn_UserImg: TButton;
    cal_Calendar: TCalendar;
    cmbbx_MonatJahr: TComboBox;
    cmbbx_MonatMonat: TComboBox;
    crl_AuswertungaktGLZMain: TCircle;
    crl_AuswertungaktGLZSub: TCircle;
    crl_AuswertungGLZMain: TCircle;
    crl_AuswertungGLZSub: TCircle;
    crl_BookingMain: TCircle;
    crl_BookingSub: TCircle;
    crl_CalendarSub: TCircle;
    crl_CalndarMain: TCircle;
    crl_PersonalMain: TCircle;
    crl_PersonalSub: TCircle;
    edt_Benutzername: TEdit;
    edt_Passwort: TEdit;
    edt_Server: TEdit;
    fa_Auswertung: TFloatAnimation;
    fa_Auswertung1: TFloatAnimation;
    fa_AuswertungaktGLZCircle: TFloatAnimation;
    fa_AuswertungGLZCircle: TFloatAnimation;
    fa_Booking: TFloatAnimation;
    fa_BookingCircle: TFloatAnimation;
    fa_Calendar: TFloatAnimation;
    fa_CalendarCircle: TFloatAnimation;
    fa_Personal: TFloatAnimation;
    fa_PersonalCircle: TFloatAnimation;
    image_HomeBooking: TImage;
    img_Auswertung: TImage;
    img_Auswertung1: TImage;
    img_Biometric: TImage;
    img_Booking: TImage;
    img_BookingBreakBegin: TImage;
    img_BookingBreakEnd: TImage;
    img_BookingWorkBegin: TImage;
    img_BookingWorkEnd: TImage;
    img_Buchungen: TImage;
    img_Calander: TImage;
    img_Close: TImage;
    img_Fehltage: TImage;
    img_Home: TImage;
    img_HomeAuswertung: TImage;
    img_HomeCalendar: TImage;
    img_Logo: TImage;
    img_Logout: TImage;
    img_More: TImage;
    img_Online: TImage;
    img_Optionen: TImage;
    img_Personal: TImage;
    imglst_main: TImageList;
    kp_KinveyProvider: TKinveyProvider;
    lbl_AuswertungaktGLZDesc: TLabel;
    lbl_AuswertungaktGLZDetail: TLabel;
    lbl_AuswertungGLZDesc: TLabel;
    lbl_AuswertungGLZDetail: TLabel;
    lbl_AuswertungHeader: TLabel;
    lbl_BookingDesc: TLabel;
    lbl_BookingDetail: TLabel;
    lbl_BookingHeder: TLabel;
    lbl_Buchungen: TLabel;
    lbl_BueroDez: TTreeViewItem;
    lbl_CalendarDesc: TLabel;
    lbl_CalendarDetail: TLabel;
    lbl_CalendarHeader: TLabel;
    lbl_CloseBody: TLabel;
    lbl_CloseHeader: TLabel;
    lbl_CreateAccount: TLabel;
    lbl_CurDateTime: TLabel;
    lbl_HODez: TTreeViewItem;
    lbl_MonatJahr: TLabel;
    lbl_Kind: TLabel;
    lbl_LastBooking: TLabel;
    lbl_LogoutBody: TLabel;
    lbl_LogoutHeader: TLabel;
    lbl_ModulName: TLabel;
    lbl_MonatMonat: TLabel;
    lbl_MVAuswertung: TLabel;
    lbl_MVBuchungen: TLabel;
    lbl_MVFehltage: TLabel;
    lbl_MVHome: TLabel;
    lbl_MVMore: TLabel;
    lbl_MVOnline: TLabel;
    lbl_OptionenBody: TLabel;
    lbl_OptionenHeader: TLabel;
    lbl_PersonalDesc: TLabel;
    lbl_PersonalHeader: TLabel;
    lbl_Tageswerte: TLabel;
    ln_Auswertung: TLine;
    ln_Booking: TLine;
    ln_Calender: TLine;
    ln_Personal: TLine;
    lo_Auswertung: TLayout;
    lo_AuswertungaktGLZ: TLayout;
    lo_AuswertungaktGLZDetails: TLayout;
    lo_AuswertungaktGLZMain: TLayout;
    lo_AuswertungMonatDatum: TLayout;
    lo_AuswertungGLZ: TLayout;
    lo_AuswertungGLZDetails: TLayout;
    lo_AuswertungGLZMain: TLayout;
    lo_AuswertungImg: TLayout;
    lo_AuswertungLabel: TLayout;
    lo_Booking: TLayout;
    lo_BookingDetails: TLayout;
    lo_BookingMain: TLayout;
    lo_BookingValues: TLayout;
    lo_BookingValuesDetails: TLayout;
    lo_Buchungen: TLayout;
    lo_BuchungenImg: TLayout;
    lo_BuchungenLabel: TLayout;
    lo_Calendar: TLayout;
    lo_CalendarDetails: TLayout;
    lo_CalendarMain: TLayout;
    lo_CloseImg: TLayout;
    lo_CloseLabel: TLayout;
    lo_ConfigConfig: TLayout;
    lo_DetailFrame: TLayout;
    lo_FehltageImg: TLayout;
    lo_FehltageLabel: TLayout;
    lo_Frame: TLayout;
    lo_Home: TLayout;
    lo_HomeImage: TLayout;
    lo_HomeLabel: TLayout;
    lo_MonatJahr: TLayout;
    lo_LoginBody: TLayout;
    lo_LoginFooter: TLayout;
    lo_LoginHeader: TLayout;
    lo_LogoutImg: TLayout;
    lo_LogoutLabel: TLayout;
    lo_MainLeft: TLayout;
    lo_MainPCM: TLayout;
    lo_MainRight: TLayout;
    lo_MonatMonat: TLayout;
    lo_MoreImg: TLayout;
    lo_MoreLabel: TLayout;
    lo_OnlineImg: TLayout;
    lo_OnlineLabel: TLayout;
    lo_OptionenImg: TLayout;
    lo_OptionenLabel: TLayout;
    lo_Personal: TLayout;
    lo_PersonalDetail: TLayout;
    lo_PersonalMain: TLayout;
    lo_Tageswerte: TLayout;
    lstbx_Menu: TListBox;
    lstbx_More: TListBox;
    lstbxitm_101Home: TListBoxItem;
    lstbxitm_103Online: TListBoxItem;
    lstbxitm_104Buchungen: TListBoxItem;
    lstbxitm_105Fehltage: TListBoxItem;
    lstbxitm_106Auswertung: TListBoxItem;
    lstbxitm_107More: TListBoxItem;
    lstbxitm_101Optionen: TListBoxItem;
    lstbxitm_102Abmelden: TListBoxItem;
    lstbxitm_103Beenden: TListBoxItem;
    lv_Fehltage: TListView;
    mv_Menu: TMultiView;
    nc_PushNotification: TNotificationCenter;
    pe_PushEvents: TPushEvents;
    pie_AuswertungaktGLZ: TPie;
    pie_AuswertungGLZ: TPie;
    pie_Booking: TPie;
    pie_Calender: TPie;
    pie_Personal: TPie;
    qry_work_Sub: TFDQuery;
    rec_1Personal: TRectangle;
    rec_2Booking: TRectangle;
    rec_3Calendar: TRectangle;
    rec_4Auswertung: TRectangle;
    rec_Auswertung: TRectangle;
    rec_AuswertungaktGLZLine: TRectangle;
    rec_AuswertungGLZLine: TRectangle;
    rec_AuswertungHeader: TRectangle;
    rec_Booking: TRectangle;
    rec_BookingHeader: TRectangle;
    rec_Bookingline: TRectangle;
    rec_Calander: TRectangle;
    rec_CalenderHeader: TRectangle;
    rec_CalenderLine: TRectangle;
    rec_ContactsLine: TRectangle;
    rec_CreateAccount: TRectangle;
    rec_Main: TRectangle;
    rec_Personal: TRectangle;
    rec_PersonalHeader: TRectangle;
    strgrd_Buchungen: TStringGrid;
    strgrd_Tageswerte: TStringGrid;
    strgrdcol_Dez: TStringColumn;
    strgrdcol_Gehen: TStringColumn;
    strgrdcol_ID: TStringColumn;
    strgrdcol_Kommen: TStringColumn;
    strgrdcol_P1End: TStringColumn;
    strgrdcol_P1Start: TStringColumn;
    strgrdcol_P2End: TStringColumn;
    strgrdcol_P2Start: TStringColumn;
    strgrdcol_Std: TStringColumn;
    strgrdcol_Values: TStringColumn;
    tc_main: TTabControl;
    tc_MainApp: TTabControl;
    tc_More: TTabControl;
    ti_1ConfigMenu: TTabItem;
    ti_1Login: TTabItem;
    ti_1MainHome: TTabItem;
    ti_2ConfigConfig: TTabItem;
    ti_3MainOnline: TTabItem;
    ti_2MainProgram: TTabItem;
    ti_3ActiveFrame: TTabItem;
    ti_4MainBuchungen: TTabItem;
    ti_4DetailFrame: TTabItem;
    ti_5MainFehltage: TTabItem;
    ti_5Finger: TTabItem;
    ti_6MainMonatswerte: TTabItem;
    ti_7More: TTabItem;
    tmr_CurDateTime: TTimer;
    trvw_AuswertungMonat: TTreeView;
    trvw_AuswertungMonatValDez: TTreeView;
    trvw_AuswertungMonatValStdMin: TTreeView;
    trvw_Booking: TTreeView;
    trvw_BookingVal: TTreeView;
    trvw_Calendar: TTreeView;
    trvw_LastBooking: TTreeView;
    trvw_Month: TTreeView;
    trvw_MonthValDez: TTreeView;
    trvw_MonthValStd: TTreeView;
    trvw_PersonalVal: TTreeView;
    trvwitem_CalendarNext: TTreeViewItem;
    trvwitem_CalendarNextHeader: TTreeViewItem;
    trvwitem_CalendarToday: TTreeViewItem;
    trvwitem_CalendarTodayHeader: TTreeViewItem;
    trvwitm_BookingDatum: TTreeViewItem;
    trvwitm_BookingDatumVal: TTreeViewItem;
    trvwitm_BookingGehen: TTreeViewItem;
    trvwitm_BookingGehenVal: TTreeViewItem;
    trvwitm_BookingKommen: TTreeViewItem;
    trvwitm_BookingKommenVal: TTreeViewItem;
    trvwitm_BookingP1Beginn: TTreeViewItem;
    trvwitm_BookingP1BeginnVal: TTreeViewItem;
    trvwitm_BookingP1Ende: TTreeViewItem;
    trvwitm_BookingP1EndeVal: TTreeViewItem;
    trvwitm_BookingP2Beginn: TTreeViewItem;
    trvwitm_BookingP2BeginnVal: TTreeViewItem;
    trvwitm_BookingP2Ende: TTreeViewItem;
    trvwitm_BookingP2EndeVal: TTreeViewItem;
    trvwitm_EmailVal: TTreeViewItem;
    trvwitm_MonatEmpty: TTreeViewItem;
    trvwitm_MonatEmptyDez: TTreeViewItem;
    trvwitm_MonatEmptyStd: TTreeViewItem;
    trvwitm_MonatFeiertage: TTreeViewItem;
    trvwitm_FeiertageMWDez: TTreeViewItem;
    trvwitm_FeiertageMWStd: TTreeViewItem;
    trvwitm_MonatGLZAktuellDez: TTreeViewItem;
    trvwitm_MonatGLZaktMonat: TTreeViewItem;
    trvwitm_MonatGLZaktMonatDez: TTreeViewItem;
    trvwitm_MonatGLZaktMonatStd: TTreeViewItem;
    trvwitm_MonatGLZAktuellStd: TTreeViewItem;
    trvwitm_MonatGLZAktuell: TTreeViewItem;
    trvwitm_MonatGLZVormonat: TTreeViewItem;
    trvwitm_MonatGLZVormonatDez: TTreeViewItem;
    trvwitm_MonatGLZVormonatStd: TTreeViewItem;
    trvwitm_HomeGLZ: TTreeViewItem;
    trvwitm_HomeGLZAktuell: TTreeViewItem;
    trvwitm_HomeGLZAktuellDez: TTreeViewItem;
    trvwitm_HomeGLZAktuellSTd: TTreeViewItem;
    trvwitm_HomeGLZDez: TTreeViewItem;
    trvwitm_HomeGLZStd: TTreeViewItem;
    trvwitm_HomeGLZVormonat: TTreeViewItem;
    trvwitm_HomeGLZVormonatDez: TTreeViewItem;
    trvwitm_HomeGLZVormonatStd: TTreeViewItem;
    trvwitm_HomeIststundenBrutto: TTreeViewItem;
    trvwitm_HomeIststundenBruttoDez: TTreeViewItem;
    trvwitm_HomeIststundenBruttoStd: TTreeViewItem;
    trvwitm_HomeIststundenNetto: TTreeViewItem;
    trvwitm_HomeIststundenNettoDez: TTreeViewItem;
    trvwitm_HomeIststundenNettoStd: TTreeViewItem;
    trvwitm_MonatHomeoffice: TTreeViewItem;
    trvwitm_HomeofficeMWDez: TTreeViewItem;
    trvwitm_HomePausen: TTreeViewItem;
    trvwitm_HomePausenDez: TTreeViewItem;
    trvwitm_HomePausenStd: TTreeViewItem;
    trvwitm_HomeSollstunden: TTreeViewItem;
    trvwitm_HomeSollstundenDez: TTreeViewItem;
    trvwitm_HomeSollstundenStd: TTreeViewItem;
    trvwitm_HomeStunden: TTreeViewItem;
    trvwitm_HomeStundenDez: TTreeViewItem;
    trvwitm_HomeStundenStd: TTreeViewItem;
    trvwitm_MonatIststundenBrutto: TTreeViewItem;
    trvwitm_MonatIststundenBruttoDez: TTreeViewItem;
    trvwitm_MonatIststundenBruttoStd: TTreeViewItem;
    trvwitm_MonatIststundenNetto: TTreeViewItem;
    trvwitm_MonatIststundenNettoDez: TTreeViewItem;
    trvwitm_MonatIststundenNettoStd: TTreeViewItem;
    trvwitm_MonatKrankbezahlt: TTreeViewItem;
    trvwitm_KrankbezahltMWDez: TTreeViewItem;
    trvwitm_KrankbezahltMWStd: TTreeViewItem;
    trvwitm_MonatKrankUnbezahlt: TTreeViewItem;
    trvwitm_KrankUnbezahltMWDez: TTreeViewItem;
    trvwitm_KrankUnbezahltMWStd: TTreeViewItem;
    trvwitm_LastBookingHeader: TTreeViewItem;
    trvwitm_MobileVal: TTreeViewItem;
    trvwitm_NameVal: TTreeViewItem;
    trvwitm_MonatOffice: TTreeViewItem;
    trvwitm_OfficeMWDez: TTreeViewItem;
    trvwitm_MonatPausen: TTreeViewItem;
    trvwitm_MonatPausenDez: TTreeViewItem;
    trvwitm_MonatPausenStd: TTreeViewItem;
    trvwitm_PlaceVal: TTreeViewItem;
    trvwitm_MonatResturlaub: TTreeViewItem;
    trvwitm_ResturlaubMWDez: TTreeViewItem;
    trvwitm_ResturlaubMWStd: TTreeViewItem;
    trvwitm_MonatSollstunden: TTreeViewItem;
    trvwitm_MonatSollstundenDez: TTreeViewItem;
    trvwitm_MonatSollstundenStd: TTreeViewItem;
    trvwitm_StreetVal: TTreeViewItem;
    trvwitm_MonatStunden: TTreeViewItem;
    trvwitm_StundenMWDez: TTreeViewItem;
    trvwitm_MonatStundenStd: TTreeViewItem;
    trvwitm_MonatTage: TTreeViewItem;
    trvwitm_MonatTageDez: TTreeViewItem;
    trvwitm_MonatTageStd: TTreeViewItem;
    trvwitm_MonatUrlaubbezahlt: TTreeViewItem;
    trvwitm_MonatUrlaubbezahltDez: TTreeViewItem;
    trvwitm_MonatUrlaubbezahltStd: TTreeViewItem;
    trvwitm_MonatUrlaubunbezahlt: TTreeViewItem;
    trvwitm_UrlaubunbezahltMWDez: TTreeViewItem;
    trvwitm_UrlaubunbezahltMWStd: TTreeViewItem;
    trvwitm_MonatWorkdays: TTreeViewItem;
    trvwitm_WorkdaysMWDez: TTreeViewItem;
    trvwitm_WorkdaysString: TTreeViewItem;
    vsbx_AuswertungMonat: TVertScrollBox;
    vsbx_ConfigConfig: TVertScrollBox;
    vsbx_Home: TVertScrollBox;
    vsbx_Login: TVertScrollBox;
    wtcsr_WaitCursor: TFDGUIxWaitCursor;
    img_HomePersonal: TImage;
    ti_2MainPersonal: TTabItem;
    lstbxitm_102Personal: TListBoxItem;
    lo_PersonalImage: TLayout;
    img_PersonalMV: TImage;
    lo_PersonalLabel: TLayout;
    lbl_MVPersonal: TLabel;
    lo_PersonalDaten: TLayout;
    vsbx_PersonalDaten: TVertScrollBox;
    lo_PersonalDatenMain: TLayout;
    vsbx_PersonalDatenView: TVertScrollBox;
    lo_Adresse: TLayout;
    rec_MapPrivat: TRectangle;
    img_MapPrivat: TImage;
    lo_AdressPrivatDetail: TLayout;
    edt_Postleitzahl: TEdit;
    edt_Strasse: TEdit;
    lo_Telefon: TLayout;
    edt_Telefon: TEdit;
    img_TelefonPrivat: TImage;
    tc_personal: TTabControl;
    ti_2MAPrivat: TTabItem;
    ti_3MAFirma: TTabItem;
    ti_4MAZE: TTabItem;
    lo_PersonalDatenPrivat: TLayout;
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    vsbx_PasswortDetailView: TVertScrollBox;
    Layout3: TLayout;
    VertScrollBox2: TVertScrollBox;
    Layout4: TLayout;
    VertScrollBox3: TVertScrollBox;
    Layout5: TLayout;
    VertScrollBox4: TVertScrollBox;
    Layout6: TLayout;
    VertScrollBox5: TVertScrollBox;
    lbl_Adresse: TLabel;
    lbl_Telefon: TLabel;
    lbl_Handy: TLabel;
    lo_Handy: TLayout;
    edt_Handy: TEdit;
    img_Handy: TImage;
    lbl_Mail: TLabel;
    lo_EMail: TLayout;
    edt_Email: TEdit;
    img_EMail: TImage;
    lbl_Firma: TLabel;
    edt_Firma: TEdit;
    lbl_AdresseFirma: TLabel;
    lo_AdresseFirma: TLayout;
    rec_MapFirma: TRectangle;
    img_MapFirma: TImage;
    lo_AdresseFirmaDetail: TLayout;
    edt_PostleitzahlFirma: TEdit;
    edt_StrasseFirma: TEdit;
    lbl_TelefonFirma: TLabel;
    lo_TelefonFirma: TLayout;
    edt_TelefonFirma: TEdit;
    img_TelefonFirma: TImage;
    lbl_HandyFirma: TLabel;
    lo_HandyFirma: TLayout;
    edt_HandyFirma: TEdit;
    img_HandyFirma: TImage;
    lbl_MailFirma: TLabel;
    lo_EMailFirma: TLayout;
    edt_EMailfirma: TEdit;
    img_EMailfirma: TImage;
    Label1: TLabel;
    edt_personalnr: TEdit;
    lbl_Eintritt: TLabel;
    dedt_Eintritt: TDateEdit;
    Label2: TLabel;
    edt_ULAnspruch: TNumberBox;
    Label3: TLabel;
    ti_1MAMitarbeiter: TTabItem;
    lbl_Anrede: TLabel;
    cbx_Anrede: TComboBox;
    lbl_Vorname: TLabel;
    edt_Vorname: TEdit;
    lbl_Nachname: TLabel;
    edt_Nachname: TEdit;
    lbl_Geschlecht: TLabel;
    cbx_Geschlecht: TComboBox;
    lbl_Geburtsdatum: TLabel;
    dtp_Geburtsdatum: TDateEdit;
    lbl_Familienstand: TLabel;
    cbx_Familienstand: TComboBox;
    lbl_Staatsangehoerigkeit: TLabel;
    cbx_Staatsangehoerigkeit: TComboBox;
    cbx_Konfession: TComboBox;
    lbl_Konfession: TLabel;
    Layout7: TLayout;
    edt_OffYear: TNumberBox;
    edt_OffUrlaub: TNumberBox;
    Label4: TLabel;
    edt_sollstunden: TEdit;
    tc_Auswertung: TTabControl;
    ti_1Monatswerte: TTabItem;
    ti_2Jahreswerte: TTabItem;
    vsbx_AuswertungJahr: TVertScrollBox;
    lo_AuswertungJahrDatum: TLayout;
    cmbbx_JahrJA: TComboBox;
    Label5: TLabel;
    trvw_AuswertungJahr: TTreeView;
    TreeViewItem29: TTreeViewItem;
    TreeViewItem30: TTreeViewItem;
    TreeViewItem34: TTreeViewItem;
    TreeViewItem35: TTreeViewItem;
    TreeViewItem36: TTreeViewItem;
    TreeViewItem37: TTreeViewItem;
    TreeViewItem38: TTreeViewItem;
    trvw_AuswertungJahrVal: TTreeView;
    TreeViewItem48: TTreeViewItem;
    TreeViewItem49: TTreeViewItem;
    TreeViewItem53: TTreeViewItem;
    TreeViewItem54: TTreeViewItem;
    TreeViewItem55: TTreeViewItem;
    TreeViewItem56: TTreeViewItem;
    TreeViewItem57: TTreeViewItem;
    trvw_Personal: TTreeView;
    trvwitm_Name: TTreeViewItem;
    trvwitm_Street: TTreeViewItem;
    trvwitm_Place: TTreeViewItem;
    trvwitm_Mobile: TTreeViewItem;
    trvwitm_Email: TTreeViewItem;
    lbl_PersonalDetail: TLabel;
    trvwitm_LastBooking: TTreeViewItem;
    btn_AuswertungMonatCalc: TButton;
    qry_work: TFDQuery;
    lo_BuchungungenLegende: TLayout;
    Button1: TButton;
    rec_buchungenInfo: TRectangle;
    Layout1: TLayout;
    Button2: TButton;
    Info: TLabel;
    Layout8: TLayout;
    Label7: TLabel;
    Circle1: TCircle;
    Layout9: TLayout;
    Label6: TLabel;
    Circle2: TCircle;
    Layout10: TLayout;
    Label8: TLabel;
    Circle3: TCircle;
    Layout11: TLayout;
    Label9: TLabel;
    Circle4: TCircle;
    Layout12: TLayout;
    Label10: TLabel;
    Circle5: TCircle;
    Layout13: TLayout;
    Label11: TLabel;
    Circle6: TCircle;
    btn_AuswertungJahrCalc: TButton;
    Button3: TButton;
    {$IFDEF ANDROID}
    procedure BiometricAuth1AuthenticateSuccess(Sender: TObject);
    procedure BiometricAuth1AuthenticateFail(Sender: TObject; const FailReason: TBiometricFailReason; const ResultMessage: string);
    {$ENDIF ANDROID}
    procedure btn_AddDataClick(Sender: TObject);
    procedure btn_AuswertungMonatCalcClick(Sender: TObject);
    procedure btn_BackSystemClick(Sender: TObject);
    procedure btn_BookingBreakBeginClick(Sender: TObject);
    procedure btn_BookingBreakendClick(Sender: TObject);
    procedure btn_BookingWorkBeginClick(Sender: TObject);
    procedure btn_BookingWorkEndClick(Sender: TObject);
    procedure btn_CalcClick(Sender: TObject);
    procedure btn_CloseAppClick(Sender: TObject);
    procedure btn_FehltageFilterClick(Sender: TObject);
    procedure btn_lockClick(Sender: TObject);
    procedure btn_LoginClick(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure btn_UnlockClick(Sender: TObject);
    procedure cal_CalendarDateSelected(Sender: TObject);
    procedure cmbbx_MonatMonatChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormTouch(Sender: TObject; const Touches: TTouches;const Action: TTouchAction);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure img_BiometricClick(Sender: TObject);
    procedure lbl_CreateAccountNewClick(Sender: TObject);
    procedure lstbxitm_101HomeClick(Sender: TObject);
    procedure lstbxitm_102PersonalClick(Sender: TObject);
    procedure lstbxitm_103OnlineClick(Sender: TObject);
    procedure lstbxitm_104BuchungenClick(Sender: TObject);
    procedure lstbxitm_105FehltageClick(Sender: TObject);
    procedure lstbxitm_106AuswertungClick(Sender: TObject);
    procedure lstbxitm_107MoreClick(Sender: TObject);
    procedure lstbxitm_101OptionenClick(Sender: TObject);
    procedure lstbxitm_102AbmeldenClick(Sender: TObject);
    procedure lstbxitm_103BeendenClick(Sender: TObject);
    procedure strgrd_BuchungenCellClick(const Column: TColumn; const Row: Integer);
    procedure strgrd_BuchungenCellDblClick(const Column: TColumn; const Row: Integer);
    procedure tc_MainAppChange(Sender: TObject);
    procedure tc_mainChange(Sender: TObject);
    procedure tmr_CurDateTimeTimer(Sender: TObject);
    procedure img_MapPrivatClick(Sender: TObject);
    procedure img_TelefonPrivatClick(Sender: TObject);
    procedure img_HandyClick(Sender: TObject);
    procedure img_EMailClick(Sender: TObject);
    procedure img_MapFirmaClick(Sender: TObject);
    procedure img_TelefonFirmaClick(Sender: TObject);
    procedure img_HandyFirmaClick(Sender: TObject);
    procedure img_EMailfirmaClick(Sender: TObject);
    procedure cmbbx_JahrJAChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn_AuswertungJahrCalcClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
 private
    { Private-Deklarationen }
    {$IFDEF ANDROID}
    baBiometric: TBiometricAuth;
    sCallPhonePermission: string;
    evsrvEventService: IFMXApplicationEventService;
    pdsrvPhoneDialerService: IFMXPhoneDialerService;
    {$ENDIF ANDROID}
    dBounds: TRectF;
    bNeedOffset: Boolean;
    bOpened: boolean;
    iProgramm: integer;
    iServerID: integer;
    iTouchPosX: Single;
    iTouchPosY: Single;
  public
    { Public-Deklarationen }
    {$IFDEF ANDROID}
    clpbrdsrvClipboardService: IFMXClipboardService;
    {$ENDIF ANDROID}
    aryList: TStringArray;
    bFirstLogin: boolean;
    bHasBiometric: boolean;
    bKontakte: boolean;
    bNeu: boolean;
    bNofinger: boolean;
    iAnimation: integer;
    iDesignAPP: integer;
    iDesignWin: integer;
    iID: integer;
    iItemIndex: integer;
    iItemTag: integer;
    iListviewID: integer;
    iTags: integer;
    sDeviceDetail: string;
    sDisplayname: string;
    snglClientHeight: Single;
    snglClientWidth: Single;
    sOSDetail: string;
    sPhoneNumber: string;
    sProviderDetail: string;
    {$IFDEF ANDROID}
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplicationEventMessageHandler(const Sender: TObject; const M: TMessage);
    procedure DisplayRationaleDialers(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
    procedure Listening(const AIsListening: Boolean);
    procedure TakePhoneCallPermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
    {$ENDIF ANDROID}
    procedure AfterLogin(AFirstStart: Boolean);
    procedure AutoLogin(sBenutzername, sPasswort: String);
    procedure BerechneMonatsUebersicht(AMonat,AJahr: integer);
    procedure BerechneJahresUebersicht(AJahr: integer);
    procedure CloseDetailFrame(AModulName: String; iDetailFrame: Integer);
    procedure CreateDashboard;
    procedure CreateFormServer;
    procedure CreateFrameSystem;
    procedure CreateFTGridConfig(AFilter: boolean);
    procedure Logout;
    procedure MakeCall(Sender: TObject);
    procedure OnReceiveNotificationEvent(Sender: TObject; const ServiceNotification: TPushServiceNotification);
    procedure OnServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
    procedure ResizeLayout;
    procedure SendMail(ATarget: string);
    procedure SendToMapApp(AStreet,AZip: string);
    procedure SetAnimation(AAnimation: integer);
    procedure SetAutoLogin(sUsername, sPasswort: String; iID_MA_Stammdaten, iID_Server: Integer; bAutoLogin: Boolean);
    procedure SetDesign(ADesignApp,ADesignWin: integer);
    procedure SetDisableToolButtons;
    procedure SetGrid(ADate: TDate);
    procedure SetServerList;
    procedure ShowStartpage;
  end;
  {$EndRegion Types}
var
  {$Region Var}
  frm_PCM_Main: Tfrm_PCM_Main;
  {$EndRegion Var}
const
  {$Region Const}
  sAPPName = 'PCM - APP';
  {$EndRegion Const}
implementation
{$R *.fmx}
uses
  {$Region Uses}
  PCMAPP.Kalender.Funktionen,
  PCMAPP.Datamodul,
  PCMAPP.Server,
  PCMAPP.SQL;
  {$EndRegion Uses}
////////////////////////////////////////////////////////////////////////////////
// HELPER FUNCTIONS                                                           //
////////////////////////////////////////////////////////////////////////////////
{$Region Helperfunctions}
procedure Tfrm_PCM_Main.AfterLogin(AFirstStart: Boolean);
begin
  ShowStartPage;
end;
procedure Tfrm_PCM_Main.AutoLogin(sBenutzername, sPasswort: String);
var
  bLocalaccount: boolean;
  slocalBenutzername: String;
  slocalPasswort: String;
begin
  {$IFDEF MSWINDOWS}
  btn_CloseApp.Visible:= true;
  {$ENDIF MSWINDOWS}
  dmmain.wfWaitFrame.Execute('Auto Login...', 'Login', True);
  TTask.Run(
  procedure()
  begin
    qry_Work.SQL.Text := sSQL_SEL_All_AUtologin;
    qry_Work.Open;
    bLocalaccount:= qry_Work.FieldByName('Localaccount').AsBoolean;
    slocalBenutzername:= qry_Work.FieldByName('Benutzername').AsString;
    slocalPasswort:= qry_Work.FieldByName('Passwort').AsString;
    qry_Work.Close;
    if bLocalaccount then
    begin
      if (sBenutzername = slocalBenutzername) and (sPasswort = slocalPasswort) then
      begin
        bFirstLogin:= false;
        dmmain.iUserID:= 0;
        SetAutoLogin(sBenutzername, sPasswort, dmmain.iUserID, iServerID, true);
        AfterLogin(True);
      end
      else
      begin
        TThread.Synchronize(nil,
        procedure()
        begin
          if (sBenutzername = slocalBenutzername) and (sPasswort <> slocalPasswort) then
            ShowMessage('Passwort stimmt nicht überein.');
          if (sBenutzername <> slocalBenutzername) and (sPasswort = slocalPasswort) then
            ShowMessage('Benutzer stimmt nicht überein.');
          if (sBenutzername <> slocalBenutzername) and (sPasswort <> slocalPasswort) then
            ShowMessage('Benutzer und Passwort stimmen nicht überein.');
        end);
      end;
    end
    else
    begin
      SetServerlist;
      if iServerID <> -1 then
      begin
        qry_Work.SQL.Text := sSQL_SELECT_ALL_Login_Where_Benutzer_IDServer;
        qry_Work.ParamByName('User').AsString := sBenutzername;
        qry_Work.ParamByName('ID_Server').AsInteger := iServerID;
        qry_Work.Open();
        if qry_Work.RecordCount > 0 then
        begin
          if (qry_Work.FieldByName('Passwort').AsString = sPasswort) then
          begin
            dmmain.iUserID := qry_Work.FieldByName('ID_MA_Stammdaten').AsInteger;
            if dmmain.bServerAvailable then
            begin
              Synchronisation(dmmain.iUserID, iServerID, dmmain.wfWaitFrame,false);
            end;
            qry_Work.Close;
            qry_Work.SQL.Text := sSQL_SELECT_ALL_Login_Where_IDBenutzer_IDServer;
            qry_Work.ParamByName('ID_MA_Stammdaten').AsInteger := dmmain.iUserID;
            qry_Work.ParamByName('ID_Server').AsInteger := iServerID;
            qry_Work.Open;
            qry_Work.Close;
            AfterLogin(False);
          end else
          begin
            TThread.Synchronize(nil,
            procedure()
            begin
              iServerID := -1;
              tc_Main.ActiveTab := ti_1Login;
              ShowMessage('Ihre gespeicherten Logindaten stimmen nicht mehr überein. Bitte Login erneut eingeben.');
            end);
          end;
        end
        else begin
          TThread.Synchronize(nil,
          procedure()
          begin
            iServerID := -1;
            tc_Main.ActiveTab := ti_1Login;
            ShowMessage('Ihre gespeicherten Logindaten stimmen nicht mehr überein. Bitte Login erneut eingeben.');
          end);
        end;
      end else
      begin
        TThread.Synchronize(nil,
        procedure()
        begin
          iServerID := -1;
          tc_Main.ActiveTab := ti_1Login;
          ShowMessage('Der hinterlegte Server ist nicht mehr vorhanden.');
        end);
      end;

    end;
    dmmain.wfWaitFrame.HideFW;
  end);
end;
procedure Tfrm_PCM_Main.BerechneJahresUebersicht(AJahr: integer);
var
  iBueroTage: integer;
  iHOTage: integer;
begin
  TreeViewItem49.text:= FormatFloat('0.0', GetFehltagSum(1, 1, 1, EncodeDate(AJahr,1,1),EndOfAMonth(AJahr,12)));
  TreeViewItem53.text:= FormatFloat('0.0', GetFehltagSum(1, 2, 1, EncodeDate(AJahr,1,1),EndOfAMonth(AJahr,12)));
  TreeViewItem54.text:= FormatFloat('0.0', GetFeiertage(StartOfAMonth(AJahr,1),EndOfAMonth(AJahr,12)));
  iBueroTage:= GetBuchungsart(0, StartOfAMonth(AJahr,1),EndOfAMonth(AJahr,12));
  iHOTage:= GetBuchungsart(1, StartOfAMonth(AJahr,1),EndOfAMonth(AJahr,12));
  TreeViewItem55.text:= FormatFloat('0.0',iBueroTage);
  TreeViewItem56.text:= FormatFloat('0.0',iHOTage);
  TreeViewItem57.text:= FormatFloat('0.0',iHOTage + iBueroTage);
end;
procedure Tfrm_PCM_Main.BerechneMonatsUebersicht(AMonat,AJahr: integer);
var
  iGLZ: integer;
  iVJahr: integer;
  iVMonat: integer;
  fHoliDay: Double;
  fUrlaubunbezahlt: Double;
  fKrankBezahlt: Double;
  fKrankunbezahlt: Double;
  iBueroTage: integer;
  iHOTage: integer;
begin
  iVJahr:= AJahr;
  iVMonat:= AMonat - 1;
  if iVMonat = 0 then
  begin
    iVJahr:= AJahr - 1;
    iVMonat:= 12;
  end;
  qry_Work_sub.SQL.Text := 'Select aktuelleMehrarbeit From Monatswerte Where Jahr = :Jahr and Monat = :Monat';
  qry_Work_sub.ParamByName('Monat').AsInteger:= iVMonat;
  qry_Work_sub.ParamByName('Jahr').AsInteger:= iVJahr;
  qry_Work_sub.Open;
  iGlz:= qry_Work_sub.FieldByName('aktuelleMehrarbeit').AsInteger;
  qry_Work_sub.Close;
  // Mehrabeit vormonat
  if iGlz < 0 then
  begin
    trvwitm_MonatGLZVormonatStd.Text:= '-' + GetTimeValue(iGLZ * -1);
    trvwitm_MonatGLZVormonatDez.Text:= '-' + FormatFloat('0.00',iGlz / 60 * -1);
  end
  else begin
    trvwitm_MonatGLZVormonatStd.Text:= GetTimeValue(iGLZ);
    trvwitm_MonatGLZVormonatDez.Text:= FormatFloat('0.00',iGlz / 60);
  end;
  qry_Work_sub.SQL.Text := 'Select * From Monatswerte Where Jahr = :Jahr and Monat = :Monat';
  qry_Work_sub.ParamByName('Monat').AsInteger:= AMonat;
  qry_Work_sub.ParamByName('Jahr').AsInteger:= AJahr;
  qry_Work_sub.Open;
  // Iststunden Brutto
  trvwitm_MonatIststundenBruttoStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Istzeit').AsInteger + qry_Work_sub.FieldByName('Pausen').AsInteger);
  trvwitm_MonatIststundenBruttoDez.Text:= FormatFloat('0.00',(qry_Work_sub.FieldByName('Istzeit').AsInteger + qry_Work_sub.FieldByName('Pausen').AsInteger) / 60);
  // Pausen
  trvwitm_MonatPausenStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Pausen').AsInteger);
  trvwitm_MonatPausenDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Pausen').AsInteger / 60);
  // Iststunden Netto
  trvwitm_MonatIststundenNettoStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Istzeit').AsInteger);
  trvwitm_MonatIststundenNettoDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Istzeit').AsInteger / 60);
  // Sollstunden
  trvwitm_MonatSollstundenStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Sollzeit').AsInteger);
  trvwitm_MonatSollstundenDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Sollzeit').AsInteger / 60);
  // Mehrarbeit
  if qry_Work_sub.FieldByName('Mehrarbeit').AsInteger < 0 then
  begin
    trvwitm_MonatGLZaktMonatStd.Text:= '-' + GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger * -1);
    trvwitm_MonatGLZaktMonatDez.Text:= '-' + FormatFloat('0.00',qry_Work_sub.FieldByName('Mehrarbeit').AsInteger * -1 / 60);
  end
  else begin
    trvwitm_MonatGLZaktMonatStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger);
    trvwitm_MonatGLZaktMonatDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Mehrarbeit').AsInteger  / 60);
  end;
  // aktuelle Gleitzeit
  if qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz< 0 then
  begin
    trvwitm_MonatGLZAktuellStd.Text:= '-' + GetTimeValue((qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz) * -1);
    trvwitm_MonatGLZAktuellDez.Text:= '-' + FormatFloat('0.00',(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz) * -1 / 60);
  end
  else begin
    trvwitm_MonatGLZAktuellStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz);
    trvwitm_MonatGLZAktuellDez.Text:= FormatFloat('0.00',(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz) / 60);
  end;
  // Urlaub Bezahlt
  trvwitm_MonatUrlaubbezahltDez.Text:= FormatFloat('0.0', GetFehltagSum(1, 1, 1, EncodeDate(AJahr,AMonat,1),EndOfAMonth(AJahr,AMonat)));
  trvwitm_MonatUrlaubbezahltStd.Text:= GetTimeValue(Round(GetFehltagSum(1, 1, 1, EncodeDate(AJahr,AMonat,1),EndOfAMonth(AJahr,AMonat)) * 480));
  // Resturlaub
  if qry_Work_sub.FieldByName('Resturlaub').AsFloat < 0 then
  begin
     trvwitm_ResturlaubMWDez.Text:= '-' + FormatFloat('0.0',qry_Work_sub.FieldByName('Resturlaub').AsFloat * -1);
     trvwitm_ResturlaubMWStd.Text:='-' + GetTimeValue(qry_Work_sub.FieldByName('Resturlaub').asInteger * -1  * 480) ;
  end
  else begin
    trvwitm_ResturlaubMWDez.Text:= FormatFloat('0.0',qry_Work_sub.FieldByName('Resturlaub').AsFloat);
    trvwitm_ResturlaubMWStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Resturlaub').asInteger * 480);
  end;
  // Urlaub unbezahlt
  fUrlaubunbezahlt:= GetFehltagSum(1, 1, 0, StartOfAMonth(AJahr,AMonat),EndOfAMonth(AJahr,AMonat));
  trvwitm_urlaubunbezahltMWDez.Text:= FormatFloat('0.0',fUrlaubunbezahlt);
  trvwitm_urlaubunbezahltMWStd.Text:= GetTimeValue(Round(fUrlaubunbezahlt * 480 ));
  // Feiertage
  fHoliDay:= GetFeiertage(StartOfAMonth(AJahr,AMonat),EndOfAMonth(AJahr,AMonat));
  trvwitm_FeiertageMWDez.Text:= FormatFloat('0.0',fHoliDay);
  trvwitm_FeiertageMWStd.Text:= GetTimeValue(Round(fHoliDay * 480 ));
  // krank bezahlt
  fKrankBezahlt:=  GetFehltagSum(1, 2, 1, StartOfAMonth(AJahr,AMonat),EndOfAMonth(AJahr,AMonat));
  trvwitm_KrankbezahltMWDez.Text:= FormatFloat('0.0',fKrankBezahlt);
  trvwitm_KrankbezahltMWStd.Text:= GetTimeValue(Round(fKrankBezahlt * 480 ));
  // krank Unbezahlt
  fKrankunbezahlt:=  GetFehltagSum(1, 2, 0, StartOfAMonth(AJahr,AMonat),EndOfAMonth(AJahr,AMonat));
  trvwitm_KrankUnbezahltMWDez.Text:= FormatFloat('0.0',fKrankunbezahlt);
  trvwitm_KrankUnbezahltMWStd.Text:= GetTimeValue(Round(fKrankunbezahlt * 480 ));
  // Büro Tage
  iBueroTage:=  GetBuchungsart(0, StartOfAMonth(AJahr,AMonat),EndOfAMonth(AJahr,AMonat));
  trvwitm_OfficeMWDez.Text:= FormatFloat('0.0',iBueroTage);
  // Homeoffice Tage
  iHOTage:=  GetBuchungsart(1, StartOfAMonth(AJahr,AMonat),EndOfAMonth(AJahr,AMonat));
  trvwitm_HomeofficeMWDez.Text:= FormatFloat('0.0',iHOTage);
  // Arbeitstage
  trvwitm_WorkdaysMWDez.Text:= FormatFloat('0.0',iHOTage + iBueroTage);
  qry_Work_sub.Close;
end;
procedure Tfrm_PCM_Main.CreateDashboard;
  function GetLastBooking : String;
  var
    dDateBookingLast: TDate;
    tTimeBookingLast: TTime;
    dDatum: TDate;
    tKommen,
    tPause1S,
    tPause1E,
    tPause2S,
    tPause2E,
    tGehen: TTime;
    sTemp: String;
  begin
    qry_Work_sub.SQL.Text := sSQL_SELECT_TEXT_LASTBOOKING;
    qry_Work_sub.Open;
    sTemp:=  StringReplace(qry_Work_sub.FieldByName('Text').AsString,'Letzte Buchung: ','',[rfReplaceAll,rfIgnoreCase]);
    qry_Work_sub.Close;
    qry_Work_sub.SQL.Text := sSQL_SELECT_K_P1S_P1E_P2S_P2E_G;
    qry_Work_sub.Open;
    tKommen:= qry_Work_sub.FieldByName('Kommen').AsDateTime;
    tPause1S:= qry_Work_sub.FieldByName('Pause1Beginn').AsDateTime;
    tPause1E:= qry_Work_sub.FieldByName('Pause1Ende').AsDateTime;
    tPause2S:= qry_Work_sub.FieldByName('Pause2Beginn').AsDateTime;
    tPause2E:= qry_Work_sub.FieldByName('Pause2Ende').AsDateTime;
    tGehen:= qry_Work_sub.FieldByName('Gehen').AsDateTime;
    dDatum:= qry_Work_sub.FieldByName('Datum').AsDateTime;
    qry_Work_sub.Close;
    sTemp:= StringReplace(sTemp,'Kommen am ','',[rfReplaceAll,rfIgnoreCase]);
    sTemp:= StringReplace(sTemp,'1. Pause Beginn am ','',[rfReplaceAll,rfIgnoreCase]);
    sTemp:= StringReplace(sTemp,'1. Pause Ende am ','',[rfReplaceAll,rfIgnoreCase]);
    sTemp:= StringReplace(sTemp,'2. Pause Beginn am ','',[rfReplaceAll,rfIgnoreCase]);
    sTemp:= StringReplace(sTemp,'2. Pause Ende am ','',[rfReplaceAll,rfIgnoreCase]);
    sTemp:= StringReplace(sTemp,'Gehen am ','',[rfReplaceAll,rfIgnoreCase]);
    dDateBookingLast:= StrToDateDef(Copy(stemp,1,10),StrToDate('30.12.1899'));
    tTimeBookingLast:= StrToTimeDef(Copy(stemp,12,5),STrToTime('00:00:00'));
    if (dDatum > dDateBookingLast) or (dDateBookingLast = StrToDate('30.12.1899'))then
    begin
        if tKommen > StrToTime('00:00:00') then
        begin
          trvwitm_LastBooking.text:= 'Kommen am ' + DateToStr(dDatum) + ' ' + TimeToStr(tKommen);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
          SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
        end;
        if tPause1S > StrToTime('00:00:00') then
        begin
          trvwitm_LastBooking.text:= '1. Pause Beginn am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause1S);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
          SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
        end;
        if tPause1E > StrToTime('00:00:00') then
        begin
          trvwitm_LastBooking.text:= '1. Pause Ende am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause1E);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
          SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
        end;
        if tPause2S > StrToTime('00:00:00') then
        begin
          trvwitm_LastBooking.text:= '2. Pause Beginn am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause2S);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
          SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
        end;
        if tPause2E > StrToTime('00:00:00') then
        begin
          trvwitm_LastBooking.text:= '2. Pause Ende am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause2E);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
          SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
        end;
        if tGehen > StrToTime('00:00:00') then
        begin
          trvwitm_LastBooking.text:= 'Gehen am ' + DateToStr(dDatum) + ' ' + TimeToStr(tGehen);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
        end;
        SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
    end
    else begin
      if dDatum = dDateBookingLast then
      begin
        if tKommen >= tTimeBookingLast then
        begin
          trvwitm_LastBooking.text:= 'Kommen am ' + DateToStr(dDatum) + ' ' + TimeToStr(tKommen);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
        end;
        if tPause1S >= tTimeBookingLast then
        begin
          trvwitm_LastBooking.text:= '1. Pause Beginn am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause1S);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
        end;
        if tPause1E >= tTimeBookingLast then
        begin
          trvwitm_LastBooking.text:= '1. Pause Beginn am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause1E);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
        end;
        if tPause2S >= tTimeBookingLast then
        begin
          trvwitm_LastBooking.text:= '2. Pause Beginn am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause2S);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
        end;
        if tPause2E >= tTimeBookingLast then
        begin
          trvwitm_LastBooking.text:= '2. Pause Ende am ' + DateToStr(dDatum) + ' ' + TimeToStr(tPause2E);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
        end;
        if tGehen >= tTimeBookingLast then
        begin
          trvwitm_LastBooking.text:= 'Gehen am ' + DateToStr(dDatum) + ' ' + TimeToStr(tGehen);
          qry_Work_sub.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work_sub.ParamByName('Text').AsString := 'Letzte Buchung: ' + trvwitm_LastBooking.text;
          qry_Work_sub.ExecSQL;
        end;
        SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
      end;
    end;
  end;
var
  iVJahr: integer;
  iVMonat: integer;
  iGlz: integer;
  wJahr: Word;
  wMonat: Word;
  wTag: Word;
begin
  try
    DecodeDate(Now,wJahr,wMonat,wTag);
    BerechneTage(0,wMonat,wJahr);
    BerechneMonat(wMonat,wJahr);
    BerechneMonatsUebersicht(wMonat,wJahr);
    // Kontakte
    qry_Work_sub.SQL.Text := 'Select * From Kontakte';
    qry_Work_sub.Open;
    trvwitm_NameVal.Text:= qry_Work_sub.FieldByName('Vorname').AsString + ' ' + qry_Work_sub.FieldByName('nachname').AsString;
    trvwitm_StreetVal.Text:= qry_Work_sub.FieldByName('Strasse').AsString;
    trvwitm_PlaceVal.Text:= Stringreplace(qry_Work_sub.FieldByName('PLZ').AsString + ' ' + qry_Work_sub.FieldByName('Ort').AsString,', Deutschland','',[rfIgnoreCase,rfReplaceAll]);
    trvwitm_MobileVal.Text:= qry_Work_sub.FieldByName('Handy').AsString;
    trvwitm_EmailVal.Text:= qry_Work_sub.FieldByName('Email').AsString;
    lbl_PersonalDetail.Text:= qry_Work_sub.FieldByName('Personalnummer').AsString;
    qry_Work_sub.Close;
    // Kalender heuteige Abwesenheit
    qry_Work_sub.SQL.Text := 'Select Fehltag, ID_Fehltage From Buchungen Where Datum = :Datum';
    qry_Work_sub.ParamByName('Datum').asDate:= Date;
    qry_Work_sub.Open;
    if qry_Work_sub.FieldByName('ID_Fehltage').AsInteger <> 0 then
    begin
      lbl_CalendarDetail.Text:= 'Ja';
      trvwitem_CalendarToday.Text:= 'Fehltag:' + qry_Work_sub.FieldByName('Fehltag').AsString;
    end
    else begin
      lbl_CalendarDetail.Text:= 'Nein';
      trvwitem_CalendarToday.Text:= 'keine Abwesenheit';
    end;
    qry_Work_sub.Close;
    // Kalender nächste Abwesenheit
    qry_Work_sub.SQL.Text := 'SELECT ft.* FROM buchungen b LEFT OUTER JOIN Fehltage ft ON ft.ID = b.ID_Fehltage ' +
                             'WHERE b.Datum > :Datum AND b.ID_Fehltage <> 0 LIMIT 1';
    qry_Work_sub.ParamByName('Datum').asDate:= Date;
    qry_Work_sub.Open;
    trvwitem_CalendarNext.Text:= qry_Work_sub.FieldByName('Kuerzel').AsString + ' ' + qry_Work_sub.FieldByName('Von').AsString + ' - ' + qry_Work_sub.FieldByName('Bis').AsString;
    qry_Work_sub.Close;
    // Monatswerte
    iVJahr:= wJahr;
    iVMonat:= wMonat - 1;
    if iVMonat = 0 then
    begin
      iVJahr:= wJahr - 1;
      iVMonat:= 12;
    end;
    qry_Work_sub.SQL.Text := 'Select aktuelleMehrarbeit From Monatswerte Where Jahr = :Jahr and Monat = :Monat';
    qry_Work_sub.ParamByName('Monat').AsInteger:= iVMonat;
    qry_Work_sub.ParamByName('Jahr').AsInteger:= iVJahr;
    qry_Work_sub.Open;
    iGlz:= qry_Work_sub.FieldByName('aktuelleMehrarbeit').AsInteger;
    qry_Work_sub.Close;
    if iGlz < 0 then
    begin
      trvwitm_HomeGLZVormonatStd.Text:= '-' + GetTimeValue(iGLZ * -1);
      trvwitm_HomeGLZVormonatDez.Text:= '-' + FormatFloat('0.00',iGlz / 60 * -1);
    end
    else begin
      trvwitm_HomeGLZVormonatStd.Text:= GetTimeValue(iGLZ);
      trvwitm_HomeGLZVormonatDez.Text:= FormatFloat('0.00',iGlz / 60);
    end;
    qry_Work_sub.SQL.Text := 'Select * From Monatswerte Where Jahr = :Jahr and Monat = :Monat';
    qry_Work_sub.ParamByName('Monat').AsInteger:= wMonat;
    qry_Work_sub.ParamByName('Jahr').AsInteger:= wJahr;
    qry_Work_sub.Open;
    trvwitm_HomeIststundenBruttoStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Istzeit').AsInteger + qry_Work_sub.FieldByName('Pausen').AsInteger);
    trvwitm_HomeIststundenBruttoDez.Text:= FormatFloat('0.00',(qry_Work_sub.FieldByName('Istzeit').AsInteger + qry_Work_sub.FieldByName('Pausen').AsInteger) / 60);
    trvwitm_HomePausenStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Pausen').AsInteger);
    trvwitm_HomePausenDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Pausen').AsInteger / 60);
    trvwitm_HomeIststundenNettoStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Istzeit').AsInteger);
    trvwitm_HomeIststundenNettoDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Istzeit').AsInteger / 60);
    trvwitm_HomeSollstundenStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Sollzeit').AsInteger);
    trvwitm_HomeSollstundenDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Sollzeit').AsInteger / 60);
    if qry_Work_sub.FieldByName('Mehrarbeit').AsInteger < 0 then
    begin
      trvwitm_HomeGLZStd.Text:= '-' + GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger * -1);
      trvwitm_HomeGLZDez.Text:= '-' + FormatFloat('0.00',qry_Work_sub.FieldByName('Mehrarbeit').AsInteger * -1 / 60);
      lbl_AuswertungGLZDetail.text:= '-' + GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger * -1);
    end
    else begin
      trvwitm_HomeGLZStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger);
      trvwitm_HomeGLZDez.Text:= FormatFloat('0.00',qry_Work_sub.FieldByName('Mehrarbeit').AsInteger  / 60);
      lbl_AuswertungGLZDetail.text:= GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger);
    end;
    if qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz< 0 then
    begin
      trvwitm_HomeGLZAktuellStd.Text:= '-' + GetTimeValue((qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz) * -1);
      trvwitm_HomeGLZAktuellDez.Text:= '-' + FormatFloat('0.00',(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz) * -1 / 60);
      lbl_AuswertungaktGLZDetail.text:= GetTimeValue((qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz) * -1);
    end
    else begin
      trvwitm_HomeGLZAktuellStd.Text:= GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz);
      trvwitm_HomeGLZAktuellDez.Text:= FormatFloat('0.00',(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz) / 60);
      lbl_AuswertungaktGLZDetail.text:= GetTimeValue(qry_Work_sub.FieldByName('Mehrarbeit').AsInteger + iGlz);
    end;
    qry_Work_sub.Close;
    GetLastBooking;
    qry_Work_sub.SQL.Text := 'Select * From Buchungen Where Datum = :Datum';
    qry_Work_sub.ParamByName('Datum').AsDate:= Date;
    qry_Work_sub.Open;
    trvwitm_BookingDatumVal.Text:= FormatDateTime('dd.MM.yyyy',qry_Work_sub.FieldByName('Datum').AsDateTime);
    trvwitm_BookingKommenVal.Text:= FormatDateTime('hh:mm',qry_Work_sub.FieldByName('Kommen').AsDateTime);
    trvwitm_BookingGehenVal.Text:= FormatDateTime('hh:mm',qry_Work_sub.FieldByName('Gehen').AsDateTime);
    trvwitm_BookingP1BeginnVal.Text:= FormatDateTime('hh:mm',qry_Work_sub.FieldByName('Pause1Beginn').AsDateTime);
    trvwitm_BookingP1EndeVal.Text:= FormatDateTime('hh:mm',qry_Work_sub.FieldByName('Pause1Ende').AsDateTime);
    trvwitm_BookingP2BeginnVal.Text:= FormatDateTime('hh:mm',qry_Work_sub.FieldByName('Pause2Beginn').AsDateTime);
    trvwitm_BookingP2EndeVal.Text:= FormatDateTime('hh:mm',qry_Work_sub.FieldByName('Pause2Ende').AsDateTime);
    if (trvwitm_BookingKommenVal.Text <> '00:00') or (trvwitm_BookingGehenVal.Text <> '00:00') or
       (trvwitm_BookingP1BeginnVal.Text <> '00:00') or (trvwitm_BookingP1EndeVal.Text <> '00:00') or
       (trvwitm_BookingP2BeginnVal.Text <> '00:00') or (trvwitm_BookingP2EndeVal.Text <> '00:00') then
    begin
      lbl_BookingDetail.Text:= 'Ja';
      trvwitm_BookingKommen.Text:= 'Kommen:';
      trvwitm_BookingGehen.Text:= 'Gehen:';
      trvwitm_BookingP1Beginn.Text:= 'Pause 1 Beginn:';
      trvwitm_BookingP1Ende.Text:= 'Pause 1 Ende:';
      trvwitm_BookingP2Beginn.Text:= 'Pause 2 Beginn:';
      trvwitm_BookingP2Ende.Text:= 'Pause 2 Ende:';
    end
    else begin
      lbl_BookingDetail.Text:= 'Nein';
      if DayOfWeek(qry_Work_sub.FieldByName('Datum').AsDateTime) in [1,7] then
      begin
        trvwitm_BookingKommen.Text:= '';
        trvwitm_BookingKommenVal.Text:= 'Wochenende';
        trvwitm_BookingGehen.Text:= '';
        trvwitm_BookingGehenVal.Text:= '';
        trvwitm_BookingP1Beginn.Text:= '';
        trvwitm_BookingP1BeginnVal.Text:= '';
        trvwitm_BookingP1Ende.Text:= '';
        trvwitm_BookingP1EndeVal.Text:= '';
        trvwitm_BookingP2Beginn.Text:= '';
        trvwitm_BookingP2BeginnVal.Text:= '';
        trvwitm_BookingP2Ende.Text:= '';
        trvwitm_BookingP2EndeVal.Text:= '';
        if trvwitem_CalendarToday.Text = 'keine Abwesenheit' then
        begin
          lbl_CalendarDetail.Text:= 'Ja';
          trvwitem_CalendarToday.Text:= 'Wochenende';
        end;
      end;

    end;
    qry_Work_sub.Close;
  except
  end;
end;
procedure Tfrm_PCM_Main.CreateFormServer;
begin
  Application.CreateForm(Tfrm_PCMAPP_Server, frm_PCMAPP_Server);
  frm_PCMAPP_Server.Show;
end;
procedure Tfrm_PCM_Main.CreateFrameSystem;
var
  frm_FrameSystem: Tfrm_PCMAPP_System;
begin
  lo_ConfigConfig.DeleteChildren;
  frm_FrameSystem := Tfrm_PCMAPP_System.Create(lo_ConfigConfig);
  frm_FrameSystem.Parent := lo_ConfigConfig;
  frm_FrameSystem.Align := TAlignLayout.Client;
  frm_FrameSystem.Execute;
end;
procedure Tfrm_PCM_Main.CreateFTGridConfig(AFilter: boolean);
var
  lstvwitm_Fehltage: TListViewItem;
  qry_Fehltage: TFDQuery;
begin
  dmmain.wfWaitFrame.Execute('Fehltage laden...', 'Fehltage', True);
  try
    qry_Fehltage:= TFDQuery.Create(Self);
    qry_Fehltage.Connection:= dmmain.con_PCM;
    if AFilter then
    begin
      qry_Fehltage.SQL.Text:= 'Select * From Fehltage Where Year(Von) = :Jahr order by Von asc';
      qry_Fehltage.ParamByName('Jahr').AsInteger:= YearOf(Date);
    end
    else begin
      qry_Fehltage.SQL.Text:= 'Select * From Fehltage';
    end;
    qry_Fehltage.open;
    if not qry_Fehltage.Eof then
    begin
      while not qry_Fehltage.Eof do
      begin
        try
          lstvwitm_Fehltage:= lv_Fehltage.Items.Add;
          lstvwitm_Fehltage.Tag:= qry_Fehltage.FieldByName('ID').AsInteger;
          lstvwitm_Fehltage.Text:= qry_Fehltage.FieldByName('Kuerzel').AsString + ' - ' + qry_Fehltage.FieldByName('Beschreibung').AsString;
          if qry_Fehltage.FieldByName('Von').AsString = qry_Fehltage.FieldByName('Bis').AsString then
            lstvwitm_Fehltage.Detail:= qry_Fehltage.FieldByName('Von').AsString
          else
            lstvwitm_Fehltage.Detail:= qry_Fehltage.FieldByName('Von').AsString + ' - ' + qry_Fehltage.FieldByName('Bis').AsString;
          lstvwitm_Fehltage.ImageIndex:= 1;
        except
          on e:Exception do
          WriteLog('Passwort laden: ' + e.Message,2,false);
        end;
        qry_Fehltage.Next;
      end;
    end;
    FreeandNil(qry_Fehltage);
    dmmain.wfWaitFrame.HideFW;
  except
    FreeandNil(qry_Fehltage);
    dmmain.wfWaitFrame.HideFW;
  end;
end;
procedure Tfrm_PCM_Main.CloseDetailFrame(AModulName: String; iDetailFrame: Integer);
begin
  TThread.Queue(nil,
  procedure
  begin
    SetDisableToolButtons;
    lbl_ModulName.Text := AModulName;
    case iDetailFrame of
    1:
      begin
        tc_Main.ActiveTab := ti_3ActiveFrame;
        lo_DetailFrame.DeleteChildren;
      end;
    2:
      begin
        tc_Main.ActiveTab := ti_4DetailFrame;
      end;
    4:
      begin
        tc_Main.ActiveTab := ti_3ActiveFrame;
        lo_DetailFrame.DeleteChildren;
      end;
    5:
      begin
        lo_DetailFrame.DeleteChildren;
        lo_Frame.DeleteChildren;
      end;
    6:
      begin
        lo_DetailFrame.DeleteChildren;
        lo_Frame.DeleteChildren;
        tc_Main.ActiveTab := ti_1Login;
      end;
    end;
  end);
end;
procedure Tfrm_PCM_Main.Logout;
begin
  edt_Benutzername.Text := '';
  edt_Passwort.Text := '';
  dmmain.iUserID := 0;
  iServerID := -1;
end;
procedure Tfrm_PCM_Main.MakeCall(Sender: TObject);
begin
  {$IFDEF ANDROID}
  if pdsrvPhoneDialerService <> nil then
  begin
    if sPhoneNumber <> '' then
    begin
      PermissionsService.RequestPermissions([sCallPhonePermission], TakePhoneCallPermissionRequestResult, DisplayRationaleDialers)
    end;
  end
  else begin
     TDialogService.ShowMessage('Anruffunktion auf diesem Gerät nicht vorhanden.');
  end;
  {$else}
  TDialogService.ShowMessage('Anruffunktion auf diesem Gerät nicht vorhanden.');
  {$ENDIF ANDROID}
end;
procedure Tfrm_PCM_Main.OnServiceConnectionChange(Sender: TObject; PushChanges: TPushService.TChanges);
var
  pshsrvPushService: TPushService;
begin
  pshsrvPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.FCM);
  if TPushService.TChange.DeviceToken in PushChanges then
  begin
    dmmain.sDeviceToken := pshsrvPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
    dmmain.sDeviceID := pshsrvPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceID];
  end;
end;
procedure Tfrm_PCM_Main.OnReceiveNotificationEvent(Sender: TObject; const ServiceNotification: TPushServiceNotification);
var
  notNotification: TNotification;
  sBody: string;
  sString: string;
  sTitle: string;
  joNotification: TJSONObject;
begin
  sString:=ServiceNotification.Json.ToString;
  sString:= StringReplace(sString,'gcm.notification.title','gcm_notification_title',[rfReplaceAll,rfIgnoreCase]);
  sString:= StringReplace(sString,'gcm.notification.body','gcm_notification_body',[rfReplaceAll,rfIgnoreCase]);
  joNotification:=TJSONObject.ParseJSONValue(sString) as TJSONObject;
  if (joNotification.GetValue('gcm_notification_title').Null) OR (not joNotification.TryGetValue<String>('gcm_notification_title', sTitle)) then
    sTitle:= '';
  if (joNotification.GetValue('gcm_notification_body').Null) OR (not joNotification.TryGetValue<String>('gcm_notification_body', sBody)) then
    sBody:= '';
  notNotification:= nc_PushNotification.CreateNotification;
  try
    notNotification.Number:=18;
    notNotification.Title:= stitle;
    notNotification.AlertBody:= sBody;
    nc_PushNotification.PresentNotification(notNotification);
  finally
    FreeandNil(notNotification);
  end;
end;
procedure Tfrm_PCM_Main.ResizeLayout;
begin
  lo_Monatjahr.Width:= Round((frm_PCM_Main.ClientWidth - 48) / 2) - 16;
  lo_MonatMonat.Width:=  Round((frm_PCM_Main.ClientWidth - 48) / 2 - 16);
  rec_buchungenInfo.Width:= frm_PCM_Main.ClientWidth-64;
  rec_buchungenInfo.Position.x:= 32;
  rec_buchungenInfo.Position.Y:= Round(frm_PCM_Main.ClientHeight / 2) - Round(rec_buchungenInfo.Height / 2);
end;
procedure Tfrm_PCM_Main.SendMail(ATarget: string);
{$IFDEF ANDROID}
var
  JRecipient: TJavaObjectArray<JString>;
  Intent: JIntent;
{$ENDIF ANDROID}
{$IFDEF MSWINDOWS}
var
  ExecStr : String;
{$ENDIF MSWINDOWS}
begin
{$IFDEF ANDROID}
  JRecipient := TJavaObjectArray<JString>.Create(1);
  JRecipient.Items[0] := StringToJString(ATarget);
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_SEND);
  Intent.setFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NEW_TASK);
  Intent.putExtra(TJIntent.JavaClass.EXTRA_EMAIL, JRecipient);
  Intent.setType(StringToJString('vnd.android.cursor.dir/email'));
  TAndroidHelper.Activity.startActivity(Intent);
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  ExecStr := Format('mailto:%s?subject=', [ATarget]);
  ShellExecute(0,'open', PChar(ExecStr), NIL, NIL, 1);
  {$ENDIF MSWINDOWS}
end;
procedure Tfrm_PCM_Main.SendToMapApp(AStreet,AZip: string);
{$IFDEF ANDROID}
var
  Intent: JIntent;
{$ENDIF ANDROID}
begin
  {$IFDEF ANDROID}
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
  TJnet_Uri.JavaClass.parse(StringToJString('http://maps.google.com/?q=' + AStreet + ', ' + AZip)));
  TAndroidHelper.Activity.startActivity(Intent);
  exit;
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  ShellExecute(0, 'open', PChar('http://maps.google.de/maps?q=' + AStreet + ',' + AZiP + '&z=12'), nil, nil, 1);
  {$ENDIF MSWINDOWS}
end;
procedure Tfrm_PCM_Main.SetAnimation(AAnimation: integer);
begin
  rec_1Personal.Align:= TAlignLayout.None;
  rec_2Booking.Align:= TAlignLayout.None;
  rec_3Calendar.Align:= TAlignLayout.None;
  rec_4Auswertung.Align:= TAlignLayout.None;





  rec_1Personal.Width:= frm_PCM_Main.ClientWidth - 32;
  rec_2Booking.Width:= frm_PCM_Main.ClientWidth - 32;
  rec_3Calendar.Width:= frm_PCM_Main.ClientWidth - 32;
  rec_4Auswertung.Width:= frm_PCM_Main.ClientWidth - 32;

  case AAnimation of
  // Keine Animation
  0:
    begin
      rec_1Personal.Align:= TAlignLayout.Top;
      rec_2Booking.Align:= TAlignLayout.Top;
      rec_3Calendar.Align:= TAlignLayout.Top;
      rec_4Auswertung.Align:= TAlignLayout.Top;
    end;
  // von allen Richtungen
  1:
    begin
      fa_Personal.Trigger:= '';
      fa_Booking.Trigger:= '';
      fa_Calendar.Trigger:= '';
      fa_Auswertung.Trigger:= '';


      rec_1Personal.Visible:= true;
      rec_2Booking.Visible:= true;
      rec_3Calendar.Visible:= true;
      rec_4Auswertung.Visible:= true;

      fa_Personal.OnFinish:= nil;
      fa_Booking.OnFinish:= nil;
      fa_Calendar.OnFinish:= nil;
      fa_Auswertung.OnFinish:= nil;

      fa_Personal.StartValue:= -192;
      fa_Booking.StartValue:= -184;
      fa_Calendar.StartValue:= -184;
      fa_Auswertung.StartValue:= 216;

      fa_Personal.StopValue:= 8;
      fa_Booking.StopValue:= 16;
      fa_Calendar.StopValue:= 0;
      fa_Auswertung.StopValue:= 16;


      fa_Personal.PropertyName:= 'Position.Y';
      fa_Booking.PropertyName:= 'Position.X';
      fa_Calendar.PropertyName:= 'Position.X';
      fa_Auswertung.PropertyName:= 'Position.X';

      fa_Personal.Stop;
      fa_Booking.Stop;
      fa_Calendar.Stop;
      fa_Auswertung.Stop;

      fa_Personal.Start;
      fa_Booking.Start;
      fa_Calendar.Start;
      fa_Auswertung.Start;
    end;
  end;
//  rec1.Align:= TAlignLayout.Top;
//  rec_2Calendar.Align:= TAlignLayout.Top;
//  rec_3PasswordSerials.Align:= TAlignLayout.Top;
//  rec_3Password.Align:= TAlignLayout.left;
//  rec_3Serials.Align:= TAlignLayout.right;
//  rec_4Auswertung.Align:= TAlignLayout.Top;
//  rec_5BelegeGiftCards.Align:= TAlignLayout.Top;
//  rec_5left.Align:= TAlignLayout.left;
//  rec_5GiftCards.Align:= TAlignLayout.right;
end;
procedure Tfrm_PCM_Main.SetAutoLogin(sUsername, sPasswort: String; iID_MA_Stammdaten, iID_Server: Integer; bAutoLogin: Boolean);
begin
  if GetCountFromTableAuto_Login = 0 then
  begin
    qry_Work.SQL.Text := sSQL_INSERT_ALL_AUTOLOGIN_WITHOUT_LOCALACCOUNT;
    qry_Work.ParamByName('Benutzername').AsString := sUsername;
    qry_Work.ParamByName('Passwort').AsString := sPasswort;
    qry_Work.ParamByName('Autologin').AsBoolean := true;
    qry_Work.ParamByName('ID').AsInteger := iID_MA_Stammdaten;
    qry_Work.ParamByName('ID_Server').AsInteger := iID_Server;
    qry_Work.ParamByName('Design').AsInteger := 0;
    qry_Work.ParamByName('DesignApp').AsInteger := 0;
    qry_Work.ParamByName('DesignWin').AsInteger := 0;
    qry_Work.ParamByName('Log').AsInteger := 0;
    qry_Work.ExecSQL;
  end;
  qry_Work.Close;
  if sUsername <> '' then
  begin
    qry_Work.SQL.Text := sSQL_UPDATE_Benutzer_Autologin;
    qry_Work.ParamByName('Benutzername').AsString := sUsername;
    qry_Work.ExecSQL;
  end;
  if sPasswort <> '' then
  begin
    qry_Work.SQL.Text := sSQL_UPDATE_Passwort_Autologin;
    qry_Work.ParamByName('Passwort').AsString := sPasswort;
    qry_Work.ExecSQL;
  end;
  if dmmain.sDeviceToken <> '' then
  begin
    qry_Work.SQL.Text := sSQL_UPDATE_DEVICETOKEN_Autologin;
    qry_Work.ParamByName('DeviceToken').AsString := dmmain.sDeviceToken;
    qry_Work.ExecSQL;
  end;
  if dmmain.sDeviceID <> '' then
  begin
    qry_Work.SQL.Text := sSQL_UPDATE_DEVICEID_Autologin;
    qry_Work.ParamByName('DeviceID').AsString := dmmain.sDeviceID;
    qry_Work.ExecSQL;
  end;
end;
procedure Tfrm_PCM_Main.SetDesign(ADesignApp,ADesignWin: integer);
var
  cdlDetailColor: Cardinal;
  cdlTextColor: Cardinal;
  cdlCirclecolor: Cardinal;
  iCount: Integer;
  iDesignStyle: integer;
begin
  if Assigned(dmmain.wfWaitFrame) then
    FreeAndNil(dmmain.wfWaitFrame);
  dmmain.wfWaitFrame := TWaitForm.Create(lo_MainPCM);
  dmmain.wfWaitFrame.Parent := lo_MainPCM;
  dmmain.wfWaitFrame.Visible := False;
  cdlDetailColor:=TAlphaColorRec.White;
  cdlTextColor:= TAlphaColorRec.White;
  cdlCirclecolor:= TAlphaColorRec.White;
  try
    {$IFDEF ANDROID}
    iDesignStyle:= ADesignapp;
    {$ENDIF ANDROID}
    {$IFDEF MSWINDOWS}
    iDesignStyle:= ADesignwin;
    {$ENDIF MSWINDOWS}
    case iDesignStyle of
      0: // Calypso
      begin
        frm_PCM_Main.StyleBook:= dmMain.stB_0;
        btn_Multiview.ImageIndex:= 1;
        btn_BackSystem.ImageIndex:= 3;
        btn_Search.ImageIndex:= 5;
        btn_AddData.ImageIndex:= 7;
        btn_CloseApp.ImageIndex:= 9;
        btn_Synchronisation.ImageIndex:= 11;
        btn_UserImg.ImageIndex:= 13;
        btn_lock.ImageIndex:= 15;
        btn_Unlock.ImageIndex:= 17;
        cdlDetailColor:=TAlphaColorRec.White;
        cdlTextColor:= TAlphaColorRec.White;
        cdlCirclecolor:= $FF223D5A;
      end;
      1: // Hell
      begin
        frm_PCM_Main.StyleBook:= dmMain.stB_1;
        btn_Multiview.ImageIndex:= 0;
        btn_BackSystem.ImageIndex:= 2;
        btn_Search.ImageIndex:= 4;
        btn_AddData.ImageIndex:= 6;
        btn_CloseApp.ImageIndex:= 8;
        btn_Synchronisation.ImageIndex:= 10;
        btn_UserImg.ImageIndex:= 12;
        btn_lock.ImageIndex:= 14;
        btn_Unlock.ImageIndex:= 16;
        cdlDetailColor:= TAlphaColorRec.Black;
        cdlTextColor:= TAlphaColorRec.Black;
        {$IFDEF MSWINDOWS}
        cdlCirclecolor:= $FF3DC9ED;
        {$ENDIF MSWINDOWS}
        {$IFDEF ANDROID}
        cdlCirclecolor:= $FFE67A6E;
        {$ENDIF ANDROID}
      end;
      2: // Dunkel
      begin
        frm_PCM_Main.StyleBook:= dmMain.stB_2;
        btn_Multiview.ImageIndex:= 1;
        btn_BackSystem.ImageIndex:= 3;
        btn_Search.ImageIndex:= 5;
        btn_AddData.ImageIndex:= 7;
        btn_CloseApp.ImageIndex:= 9;
        btn_Synchronisation.ImageIndex:= 11;
        btn_UserImg.ImageIndex:= 13;
        btn_lock.ImageIndex:= 15;
        btn_Unlock.ImageIndex:= 17;
        cdlDetailColor:=TAlphaColorRec.White;
        cdlTextColor:= TAlphaColorRec.White;
        {$IFDEF MSWINDOWS}
        cdlCirclecolor:= $FF936639;
        {$ENDIF MSWINDOWS}
        {$IFDEF ANDROID}
        cdlCirclecolor:= $FF2B2B2B;
        {$ENDIF ANDROID}
      end;
      3: // Dunkel Blau
      begin
        frm_PCM_Main.StyleBook:= dmMain.stB_3;
        btn_Multiview.ImageIndex:= 1;
        btn_BackSystem.ImageIndex:= 3;
        btn_Search.ImageIndex:= 5;
        btn_AddData.ImageIndex:= 7;
        btn_CloseApp.ImageIndex:= 9;
        btn_Synchronisation.ImageIndex:= 11;
        btn_UserImg.ImageIndex:= 13;
        btn_lock.ImageIndex:= 15;
        btn_Unlock.ImageIndex:= 17;
        cdlDetailColor:=TAlphaColorRec.White;
        cdlTextColor:= TAlphaColorRec.White;
        {$IFDEF MSWINDOWS}
        cdlCirclecolor:= $FF0E7F9C;
        {$ENDIF MSWINDOWS}
        {$IFDEF ANDROID}
        cdlCirclecolor:= $FF202A2E;
        {$ENDIF ANDROID}
      end;
    {$IFDEF MSWINDOWS}
    4:
      begin
        frm_PCM_Main.StyleBook:= dmMain.stB_4;
        btn_Multiview.ImageIndex:= 1;
        btn_BackSystem.ImageIndex:= 3;
        btn_Search.ImageIndex:= 5;
        btn_AddData.ImageIndex:= 7;
        btn_CloseApp.ImageIndex:= 9;
        btn_Synchronisation.ImageIndex:= 11;
        btn_UserImg.ImageIndex:= 13;
        btn_lock.ImageIndex:= 15;
        btn_Unlock.ImageIndex:= 17;
        cdlDetailColor:= TAlphaColorRec.White;
        cdlTextColor:= TAlphaColorRec.White;
        cdlCirclecolor:= $FF250C12;
      end;
    {$ENDIF MSWINDOWS}
    end;
    //Dashboard
    rec_1Personal.Fill.Color:= cdlCirclecolor;
    rec_buchungenInfo.Fill.Color:= cdlCirclecolor;
    rec_2Booking.Fill.Color:= cdlCirclecolor;
    crl_BookingSub.Fill.Color:= cdlCirclecolor;
    rec_3Calendar.Fill.Color:= cdlCirclecolor;
    crl_CalendarSub.Fill.Color:= cdlCirclecolor;
    rec_4Auswertung.Fill.Color:= cdlCirclecolor;
    crl_AuswertungaktGLZSub.Fill.Color:= cdlCirclecolor;
    crl_AuswertungGLZSub.Fill.Color:= cdlCirclecolor;
    frm_PCM_Main.lv_Fehltage.ItemAppearanceObjects.ItemObjects.Detail.TextColor := cdlDetailColor;
    frm_PCM_Main.lv_Fehltage.ItemAppearanceObjects.ItemObjects.Text.TextColor:= cdlTextColor;
    for iCount := 0 to cmbbx_MonatMonat.count - 1 do
    begin
      cmbbx_MonatMonat.ListBox.ListItems[iCount].StyledSettings:= cmbbx_MonatMonat.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cmbbx_MonatMonat.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cmbbx_MonatMonat.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;
    for iCount := 0 to cmbbx_MonatJahr.count - 1 do
    begin
      cmbbx_MonatJahr.ListBox.ListItems[iCount].StyledSettings:= cmbbx_MonatJahr.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cmbbx_MonatJahr.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cmbbx_MonatJahr.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;

    for iCount := 0 to cbx_Anrede.count - 1 do
    begin
      cbx_Anrede.ListBox.ListItems[iCount].StyledSettings:= cbx_Anrede.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cbx_Anrede.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cbx_Anrede.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;

    for iCount := 0 to cbx_Geschlecht.count - 1 do
    begin
      cbx_Geschlecht.ListBox.ListItems[iCount].StyledSettings:= cbx_Geschlecht.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cbx_Geschlecht.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cbx_Geschlecht.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;

    for iCount := 0 to cbx_Familienstand.count - 1 do
    begin
      cbx_Familienstand.ListBox.ListItems[iCount].StyledSettings:= cbx_Familienstand.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cbx_Familienstand.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cbx_Familienstand.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;

    for iCount := 0 to cbx_Staatsangehoerigkeit.count - 1 do
    begin
      cbx_Staatsangehoerigkeit.ListBox.ListItems[iCount].StyledSettings:= cbx_Staatsangehoerigkeit.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cbx_Staatsangehoerigkeit.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cbx_Staatsangehoerigkeit.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;

    for iCount := 0 to cbx_Konfession.count - 1 do
    begin
      cbx_Konfession.ListBox.ListItems[iCount].StyledSettings:= cbx_Konfession.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cbx_Konfession.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cbx_Konfession.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;

    for iCount := 0 to cmbbx_JahrJa.count - 1 do
    begin
      cmbbx_JahrJa.ListBox.ListItems[iCount].StyledSettings:= cmbbx_JahrJa.ListBox.ListItems[iCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cmbbx_JahrJa.ListBox.ListItems[iCount].TextSettings.Font.Size:= 14;
      cmbbx_JahrJa.ListBox.ListItems[iCount].TextSettings.FontColor:= TAlphaColors.White;
    end;
  except
  end;
end;
procedure Tfrm_PCM_Main.SetDisableToolButtons;
begin
  btn_AddData.Visible := false;
  btn_Synchronisation.Visible := False;
  btn_BackSystem.Visible := False;
  btn_Search.Visible := False;
end;
procedure Tfrm_PCM_Main.SetGrid(ADate: TDate);
var
  qry_Booking: TFDQuery;
begin
  strgrd_Buchungen.RowCount := 1;
  qry_Booking:= TFDQuery.Create(Self);
  qry_Booking.Connection:= dmmain.con_PCM;
  qry_Booking.SQL.Text := 'Select * from Buchungen Where Datum = :Datum';
  qry_Booking.ParamByName('Datum').AsDate:= ADate;
  qry_Booking.open;
  strgrd_Buchungen.BeginUpdate;
  // Tageswerte
  strgrd_Buchungen.Cells[0, 0] := FormatDateTime('hh:mm',qry_Booking.FieldByName('kommen').AsDateTime);
  strgrd_Buchungen.Cells[1, 0] := FormatDateTime('hh:mm',qry_Booking.FieldByName('Gehen').AsDateTime);
  strgrd_Buchungen.Cells[2, 0] := FormatDateTime('hh:mm',qry_Booking.FieldByName('Pause1Beginn').AsDateTime);
  strgrd_Buchungen.Cells[3, 0] := FormatDateTime('hh:mm',qry_Booking.FieldByName('Pause1Ende').AsDateTime);
  strgrd_Buchungen.Cells[4, 0] := FormatDateTime('hh:mm',qry_Booking.FieldByName('Pause2Beginn').AsDateTime);
  strgrd_Buchungen.Cells[5, 0] := FormatDateTime('hh:mm',qry_Booking.FieldByName('Pause2Ende').AsDateTime);
  strgrd_Buchungen.Cells[6, 0] := qry_Booking.FieldByName('ID').AsString;

  // Iststunden Brutto
  strgrd_Tageswerte.Cells[0, 0] := 'Iststunden Brutto:';
  strgrd_Tageswerte.Cells[1, 0] := GetTimeValue(qry_Booking.FieldByName('ArbeitszeitI').AsInteger + qry_Booking.FieldByName('PausenI').AsInteger);
  strgrd_Tageswerte.Cells[2, 0] := FormatFloat('0.00',(qry_Booking.FieldByName('ArbeitszeitI').AsInteger + qry_Booking.FieldByName('PausenI').AsInteger)/60);
  // Pausen
  strgrd_Tageswerte.Cells[0, 1] := 'Pausen:';
  strgrd_Tageswerte.Cells[1, 1] := GetTimeValue(qry_Booking.FieldByName('PausenI').AsInteger);
  strgrd_Tageswerte.Cells[2, 1] := FormatFloat('0.00',qry_Booking.FieldByName('PausenI').AsInteger / 60);
  // Iststunden Netto
  strgrd_Tageswerte.Cells[0, 2] := 'Iststunden Netto:';
  strgrd_Tageswerte.Cells[1, 2] := GetTimeValue(qry_Booking.FieldByName('ArbeitszeitI').AsInteger);
  strgrd_Tageswerte.Cells[2, 2] := FormatFloat('0.00',qry_Booking.FieldByName('ArbeitszeitI').AsInteger / 60);
  // Sollstunden
  strgrd_Tageswerte.Cells[0, 3] := 'Sollstunden:';
  strgrd_Tageswerte.Cells[1, 3] := GetTimeValue(qry_Booking.FieldByName('SollstundenI').AsInteger);
  strgrd_Tageswerte.Cells[2, 3] := FormatFloat('0.00',qry_Booking.FieldByName('SollstundenI').AsInteger / 60);
  // Minder/Mehrarbeit
  strgrd_Tageswerte.Cells[0, 4] := 'Minder/Mehrarbeit:';
  strgrd_Tageswerte.Cells[1, 4] := GetTimeValue(qry_Booking.FieldByName('MehrarbeitI').AsInteger);
  strgrd_Tageswerte.Cells[2, 4] := FormatFloat('0.00',qry_Booking.FieldByName('MehrarbeitI').AsInteger / 60);
  // Minder/Mehrarbeit
  strgrd_Tageswerte.Cells[0, 4] := 'Minder/Mehrarbeit:';
  if qry_Booking.FieldByName('MehrarbeitI').AsInteger < 0 then
  begin
    strgrd_Tageswerte.Cells[1, 4] := '-' + GetTimeValue(qry_Booking.FieldByName('MehrarbeitI').AsInteger * -1);
    strgrd_Tageswerte.Cells[2, 4] := '-' + FormatFloat('0.00',qry_Booking.FieldByName('MehrarbeitI').AsInteger / 60 * -1);
  end
  else begin
    strgrd_Tageswerte.Cells[1, 4] := GetTimeValue(qry_Booking.FieldByName('MehrarbeitI').AsInteger);
    strgrd_Tageswerte.Cells[2, 4] := FormatFloat('0.00',qry_Booking.FieldByName('MehrarbeitI').AsInteger / 60);
  end;
  // Typ
  strgrd_Tageswerte.Cells[0, 5] := 'Buchungsart:';
  case qry_Booking.FieldByName('Buchungsart').AsInteger of
  -1: strgrd_Tageswerte.Cells[1, 5]:= '';
  0: strgrd_Tageswerte.Cells[1, 5]:= 'BÜ';
  1: strgrd_Tageswerte.Cells[1, 5]:= 'HO';
  end;
  // Fehltag
  strgrd_Tageswerte.Cells[0, 6]:= 'Fehltag:';
  strgrd_Tageswerte.Cells[1, 6]:= qry_Booking.FieldByName('Fehltag').AsString;
  // Feiertag
  strgrd_Tageswerte.Cells[0, 7]:= 'Feiertag:';
  case qry_Booking.FieldByName('Feiertag').AsInteger of
  0: strgrd_Tageswerte.Cells[1, 7]:= '';
  1: strgrd_Tageswerte.Cells[1, 7]:= 'FT 1';
  2: strgrd_Tageswerte.Cells[1, 7]:= 'FT 2';
  end;
  strgrd_Buchungen.EndUpdate;
  qry_Booking.Close;
  FreeAndNil(qry_Booking);
end;
procedure Tfrm_PCM_Main.SetServerList;
begin
  try
    iServerID:= -1;
    qry_Work_Sub.SQL.Text := sSQL_SEL_All_Server;
    qry_Work_Sub.Open;
    while not qry_Work_Sub.Eof do
    begin
      edt_Server.Text:= qry_Work_Sub.FieldByName('Bezeichnung').AsString;
      dmmain.sHostname:= qry_Work_Sub.FieldByName('Hostname').AsString;
      dmmain.sPort:= qry_Work_Sub.FieldByName('Port').AsString;
      iServerID:= qry_Work_Sub.FieldByName('ID').AsInteger;
      qry_Work_Sub.Next;
    end;
    qry_Work_Sub.Close;
  except
  end;
end;
procedure Tfrm_PCM_Main.ShowStartpage;
begin
  lbl_Modulname.Text:= 'Startseite';
  iTags:= 0;
  tc_Main.ActiveTab:= ti_2MainProgram;
  CreateDashboard;
  tc_MainApp.ActiveTab:= ti_1MainHome;
  SetAnimation(iAnimation);
end;
{$EndRegion Helperfunctions}
////////////////////////////////////////////////////////////////////////////////
// LOGIN FUNCTIONS                                                            //
////////////////////////////////////////////////////////////////////////////////
{$Region Loginfunctions}
procedure Tfrm_PCM_Main.btn_lockClick(Sender: TObject);
begin
  btn_Lock.Visible:= false;
  btn_UnLock.Visible:= true;
  edt_Passwort.Password:= false;
end;
procedure Tfrm_PCM_Main.btn_UnlockClick(Sender: TObject);
begin
  btn_Lock.Visible:= true;
  btn_UnLock.Visible:= false;
  edt_Passwort.Password:= true;
end;
procedure Tfrm_PCM_Main.lbl_CreateAccountNewClick(Sender: TObject);
begin
  CreateFormServer;
end;
procedure Tfrm_PCM_Main.btn_LoginClick(Sender: TObject);
  procedure LoginFirstStart;
  var
    bLocalaccount: boolean;
    bSynch: Boolean;
    slocalBenutzername: String;
    slocalPasswort: String;
    sBenutzername: String;
    sPasswort: String;
  begin
    {$IFDEF ANDROID}
    if (bHasBiometric) then
    begin
      TDialogServiceAsync.MessageDialog('Möchten Sie Ihren Fingerabdruck zum Anmelden verwenden?',
      TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
        begin
          qry_Work.SQL.Text := sSQL_UPDATE_FingerAutologin_AUTOLOGIN;
          if AResult = mrYes then
          begin
            qry_Work.ParamByName('Finger').AsBoolean:= true;
            qry_Work.ParamByName('Autologin').AsBoolean:= false;
          end
          else begin
            qry_Work.ParamByName('Finger').AsBoolean:= false;
            qry_Work.ParamByName('Autologin').AsBoolean:= false;
          end;
          qry_Work.ExecSQL;
        end);
    end
    else begin
      TDialogServiceAsync.MessageDialog('Möchten Sie automatisches Login aktivieren?',
      TMsgDlgType.mtInformation, mbYesNo, TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
        begin
          qry_Work.SQL.Text := sSQL_UPDATE_FingerAutologin_AUTOLOGIN;
          if AResult = mrYes then
          begin
            qry_Work.ParamByName('Finger').AsBoolean:= false;
            qry_Work.ParamByName('Autologin').AsBoolean:= true;
          end
          else begin
            qry_Work.ParamByName('Finger').AsBoolean:= false;
            qry_Work.ParamByName('Autologin').AsBoolean:= false;
          end;
          qry_Work.ExecSQL;
        end);
    end;
    {$ENDIF ANDROID}
    dmmain.wfWaitFrame.Execute('Erstes Login...', 'Login', True);
    TTask.Run(
    procedure ()
    begin
      qry_Work.SQL.Text := sSQL_SELECT_All_AUTOLOGIN;
      qry_Work.Open;
      bLocalaccount:= qry_Work.FieldByName('Localaccount').AsBoolean;
      slocalBenutzername:= qry_Work.FieldByName('Benutzername').AsString;
      slocalPasswort:= qry_Work.FieldByName('Passwort').AsString;
      qry_Work.Close;
      sBenutzername := edt_Benutzername.Text;
      sPasswort := edt_Passwort.Text;
      if bLocalaccount then
      begin
        if (sBenutzername = slocalBenutzername) and (sPasswort = slocalPasswort) then
        begin
          bFirstLogin:= true;
          dmmain.iUserID:= 0;
          SetAutoLogin(sBenutzername, sPasswort, dmmain.iUserID, iServerID, true);
          AfterLogin(True);
        end
        else
        begin
          TThread.Synchronize(nil,
          procedure()
          begin
            if (sBenutzername = slocalBenutzername) and (sPasswort <> slocalPasswort) then
              ShowMessage('Passwort stimmt nicht überein.');
            if (sBenutzername <> slocalBenutzername) and (sPasswort = slocalPasswort) then
              ShowMessage('Benutzer stimmt nicht überein.');
            if (sBenutzername <> slocalBenutzername) and (sPasswort <> slocalPasswort) then
              ShowMessage('Benutzer und Passwort stimmen nicht überein.');
          end);
        end;
      end
      else
      begin
        bSynch := False;
        SetServerList;
        if iServerID <> -1 then
        begin
          if dmmain.bServerAvailable then
          begin
            if CheckLogin then
            begin
              bFirstLogin:= true;
              SetAutoLogin(sBenutzername, sPasswort, dmmain.iUserID, iServerID, true);
              qry_Work_Sub.SQL.Text := sSQL_UPD_FIRSTSTART_login;
              qry_Work_Sub.ParamByName('Bool').AsBoolean := False;
              qry_Work_Sub.ParamByName('ID').AsInteger := dmmain.iUserID;
              qry_Work_Sub.ParamByName('ID_Server').AsInteger := iServerID;
              qry_Work_Sub.ExecSQL;
              SaveLogin(sBenutzername, sPasswort,dmmain.iUserID, iServerID,true);
              Synchronisation(dmmain.iUserID, iServerID, dmmain.wfWaitFrame,false);
              AfterLogin(True);
            end else
            begin
              TThread.Synchronize(nil,
              procedure()
              begin
                ShowMessage('Benutzername oder Passwort falsch. Bitte geben Sie ein gültiges Login ein.');
              end);
            end;
          end else
          begin
            TThread.Synchronize(nil,
            procedure()
            begin
              ShowMessage('Für die erste Verwendung der App wird eine Verbindung zum Server vorrausgesetzt. Bitte überprüfen.');
            end);
          end;

        end else
        begin
          TThread.Synchronize(nil,
          procedure()
          begin
            ShowMessage('Es wurde noch kein Server konfiguriert. Bitte Server unter Einstellungen konfigurieren.');
          end);
        end;
      end;
      dmmain.wfWaitFrame.HideFW;
    end);
  end;
  procedure Login;
  var
    bLocalaccount: boolean;
    slocalBenutzername: String;
    slocalPasswort: String;
    sBenutzername: String;
    sPasswort: String;
  begin
    dmmain.wfWaitFrame.Execute('Login...', 'Login',True);
    TTask.Run(
    procedure ()
    begin
      qry_Work.SQL.Text := sSQL_SELECT_All_AUTOLOGIN;
      qry_Work.Open;
      bLocalaccount:= qry_Work.FieldByName('Localaccount').AsBoolean;
      slocalBenutzername:= qry_Work.FieldByName('Benutzername').AsString;
      slocalPasswort:= qry_Work.FieldByName('Passwort').AsString;
      qry_Work.Close;
      sBenutzername := edt_Benutzername.Text;
      sPasswort := edt_Passwort.Text;
      if bLocalaccount then
      begin
        if (sBenutzername = slocalBenutzername) and (sPasswort = slocalPasswort) then
        begin
          bFirstLogin:= false;
          dmmain.iUserID:= 0;
          SetAutoLogin(sBenutzername, sPasswort, dmmain.iUserID, iServerID, true);
          AfterLogin(True);
        end
        else
        begin
          if (sBenutzername = slocalBenutzername) and (sPasswort <> slocalPasswort) then
            ShowMessage('Passwort stimmt nicht überein.');
          if (sBenutzername <> slocalBenutzername) and (sPasswort = slocalPasswort) then
            ShowMessage('Benutzer stimmt nicht überein.');
          if (sBenutzername <> slocalBenutzername) and (sPasswort <> slocalPasswort) then
            ShowMessage('Benutzer und Passwort stimmen nicht überein.');
        end;
      end
      else
      begin
        SetServerList;
        if iServerID <> -1 then
        begin
          sBenutzername :=  edt_Benutzername.Text;
          sPasswort := edt_Passwort.Text;
          qry_Work.Close;
          qry_Work.SQL.Text := sSQL_SELECT_ALL_Login_Where_Benutzer_IDServer;
          qry_Work.ParamByName('User').AsString := sBenutzername;
          qry_Work.ParamByName('ID_Server').AsInteger := iServerID;
          qry_Work.Open;
          if qry_Work.RecordCount > 0 then
          begin
            if (qry_Work.FieldByName('Passwort').AsString = sPasswort) then
            begin
              dmmain.iUserID := qry_Work.FieldByName('ID_MA_Stammdaten').AsInteger;
              SetAutoLogin(sBenutzername, sPasswort, dmmain.iUserID, iServerID, True);
              qry_Work.Close;
              if dmmain.bServerAvailable then
              begin
                SaveLogin(sBenutzername, sPasswort,dmmain.iUserID, iServerID,false);
                Synchronisation(dmmain.iUserID, iServerID, dmmain.wfWaitFrame,false)
              end;
              qry_Work.Close;
              qry_Work.SQL.Text := sSQL_SELECT_ALL_Login_Where_IDBenutzer_IDServer;
              qry_Work.ParamByName('ID_MA_Stammdaten').AsInteger := dmmain.iUserID;
              qry_Work.ParamByName('ID_Server').AsInteger := iServerID;
              qry_Work.Open;
              qry_Work.Close;
              AfterLogin(False);
            end else
            begin
              ShowMessage('Benutzername oder Passwort falsch. Bitte geben Sie ein gültiges Login ein.');
            end;
          end else
          begin
            ShowMessage('Benutzername oder Passwort falsch. Bitte geben Sie ein gültiges Login ein.');
          end;
        end else
        begin
          ShowMessage('Es wurde noch kein Server konfiguriert. Bitte Server unter Einstellungen konfigurieren.');
        end;
      end;
      dmmain.wfWaitFrame.HideFW;
    end);
  end;
begin
  SetServerList;
  if iServerID <> -1 then
    dmmain.bServerAvailable:= CheckServerConnection;
  qry_Work.Close;
  qry_Work.SQL.Text := sSQL_SELECT_ALL_Login_Where_Benutzer;
  qry_Work.ParamByName('User').AsString := edt_Benutzername.Text;
  qry_Work.Open;
  if (qry_Work.RecordCount = 0) or (qry_Work.FieldByName('FirstStart').AsBoolean = True) then
  begin
    LoginFirstStart;
  end else
  begin
    Login;
  end;
end;
{$EndRegion Loginfunctions}
////////////////////////////////////////////////////////////////////////////////
// BIOMETRIC / PERMISSION FUNCTIONS                                           //
////////////////////////////////////////////////////////////////////////////////
{$Region Biometricfunctions}
procedure Tfrm_PCM_Main.img_BiometricClick(Sender: TObject);
begin
  {$IFDEF ANDROID}
  baBiometric.GetBiometryKind;
  baBiometric.Authenticate;
  {$ENDIF ANDROID}
end;
{$IFDEF ANDROID}
procedure Tfrm_PCM_Main.BiometricAuth1AuthenticateFail(Sender: TObject; const FailReason: TBiometricFailReason; const ResultMessage: string);
begin
  tc_Main.ActiveTab:= ti_1Login;
end;
procedure Tfrm_PCM_Main.BiometricAuth1AuthenticateSuccess(Sender: TObject);
begin
  qry_Work.SQL.Text := sSQL_SELECT_All_AUtologin;
  qry_Work.Open;
  AutoLogin(qry_Work.FieldByName('Benutzername').AsString, qry_Work.FieldByName('Passwort').AsString);
  qry_Work.Close;
end;
procedure Tfrm_PCM_Main.Listening(const AIsListening: Boolean);
begin
end;
procedure Tfrm_PCM_Main.ApplicationEventMessageHandler(const Sender: TObject; const M: TMessage);
begin
end;
constructor Tfrm_PCM_Main.Create(AOwner: TComponent);
begin
  inherited;
  TMessageManager.DefaultManager.SubscribeToMessage(TApplicationEventMessage, ApplicationEventMessageHandler);
  Listening(False);
end;
destructor Tfrm_PCM_Main.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TApplicationEventMessage, ApplicationEventMessageHandler);
  inherited;
end;
////////////////////////////////////////////////////////////////////////////////
// PERMISSION FUNCTIONS                                                       //
////////////////////////////////////////////////////////////////////////////////
procedure Tfrm_PCM_Main.DisplayRationaleDialers(Sender: TObject; const APermissions: TClassicStringDynArray; const APostRationaleProc: TProc);
begin
  TDialogService.ShowMessage('The app needs to be able to support your making phone calls',
    procedure(const AResult: TModalResult)
    begin
      APostRationaleProc;
    end)
end;
procedure Tfrm_PCM_Main.TakePhoneCallPermissionRequestResult(Sender: TObject; const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray);
begin
  if (Length(AGrantResults) = 1) and (AGrantResults[0] = TPermissionStatus.Granted) then
  begin
    pdsrvPhoneDialerService.Call(StringReplace(sPhoneNumber, ' ', '-', [rfReplaceAll]))
  end;
end;
{$ENDIF ANDROID}
{$EndRegion Biometricfunctions}
////////////////////////////////////////////////////////////////////////////////
// FORM FUNCTIONS                                                             //
////////////////////////////////////////////////////////////////////////////////
{$Region Formfunctions}
procedure Tfrm_PCM_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseDetailFrame('Beenden', 5);
  if Assigned(dmmain.wfWaitFrame) then
    FreeAndNil(dmmain.wfWaitFrame);
  Action := TCloseAction.caFree;
end;
procedure Tfrm_PCM_Main.FormCreate(Sender: TObject);
begin
  FormatSettings.LongTimeFormat:= 'HH:mm:ss';
  FormatSettings.ShortTimeFormat:= 'HH:mm';
  FormatSettings.ShortDateFormat:= 'dd.mm.yyyy';
  try
    iServerID := -1;
    {$IFDEF ANDROID}
    if not TPlatformServices.Current.SupportsPlatformService (IFMXClipboardService, IInterface (clpbrdsrvClipboardService)) then
       raise Exception.Create ( 'Can not get access to clipboard service!');
    if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, evsrvEventService) then
      sCallPhonePermission := JStringToString(TJManifest_permission.JavaClass.CALL_PHONE);
    TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, pdsrvPhoneDialerService);
    {$ENDIF ANDROID}
    qry_Work.SQL.Text := sSQL_SELECT_All_AUTOLOGIN;
    qry_Work.Open;
    if qry_Work.RecordCount > 0 then
    begin
      iAnimation:= qry_Work.FieldByName('Design').AsInteger;
      iDesignAPP:= qry_Work.FieldByName('DesignApp').AsInteger;
      iDesignwin:= qry_Work.FieldByName('DesignWin').AsInteger;
    end
    else begin
      iAnimation:= 0;
      iDesignAPP:= 0;
      iDesignwin:= 0;
    end;
    SetDesign(iDesignAPP,iDesignwin);
    qry_Work.close;
  except
  end;
end;
procedure Tfrm_PCM_Main.FormShow(Sender: TObject);
  function GetCodename(VerString: string): string;
  begin
    Result:= 'Windows';
    {$IFDEF ANDROID}
    case AnsiIndexStr(VerString, ['1.0','1.5','1.6','2.0','2.1','2.2','2.3','3','4.0','4.1','4.2','4.3','4.4','5','6','7','8','9','10','11','12','13','14','15']) of
    0: Result:= 'Android 1.0: BASE';
    1: Result:= 'Android 1.5: CUPCAKE';
    2: Result:= 'Android 1.6: DONUT';
    3: Result:= 'Android 2.0: ECLAIR';
    4: Result:= 'Android 2.1: ECLAIR';
    5: Result:= 'Android 2.2: FROYO';
    6: Result:= 'Android 2.3: GINGERBREAD';
    7: Result:= 'Android 3: HONEYCOMB';
    8: Result:= 'Android 4.0: ICE_CREAM_SANDWICH';
    9: Result:= 'Android 4.1: JELLY_BEAN';
    10: Result:= 'Android 4.2: JELLY_BEAN';
    11: Result:= 'Android 4.3: JELLY_BEAN';
    12: Result:= 'Android 4.4: KITKAT';
    13: Result:= 'Android 5:	LOLLIPOP';
    14: Result:= 'Android 6:	MARSHMALLOW';
    15: Result:= 'Android 7:	NOUGAT';
    16: Result:= 'Android 8:	OREO';
    17: Result:= 'Android 9:	PIE';
    18: Result:= 'Android 10:	ANDROID Q';
    19: Result:= 'Android 11:	RED VELVET CAKE';
    20: Result:= 'Android 12:	SNOW CONE';
    21: Result:= 'Android 13:	TIRAMISU';
    22: Result:= 'Android 14:	UPSIDE DOWN CAKE';
    23: Result:= 'Android 15:	VANILLA ICE';
    end;
    {$ENDIF ANDROID}
  end;
{$IFDEF ANDROID}
var
   consrvServiceConnection: TPushServiceConnection;
   pshsrvNtnNotifications: TArray<TPushServiceNotification>;
   pshsrvPushService: TPushService;
{$ENDIF ANDROID}
begin
  WriteLog('PCM - APP FormShow',0,true);
  {$IFDEF ANDROID}
  PermissionsService.RequestPermissions([ 'android.permission.READ_MEDIA_AUDIO',
                                          'android.permission.READ_MEDIA_IMAGES',
                                          'android.permission.READ_MEDIA_AUDIO',
                                          'android.permission.CAMERA',
                                          'android.permission.POST_NOTIFICATIONS',
                                          'android.permission.READ_CONTACTS',
                                          'android.permission.CALL_PHONE'], procedure(const APermissions: TClassicStringDynArray; const AGrantResults: TClassicPermissionStatusDynArray) begin end);
  btn_CloseApp.Visible:= false;
  baBiometric:= TBioMetricauth.Create(nil);
  baBiometric.BiometricStrengths := [ TBiometricStrength.DeviceCredential,TBiometricStrength.Strong,TBiometricStrength.Weak];
  baBiometric.PromptTitle:= 'PCM - Time entsperren';
  baBiometric.PromptSubTitle:= 'Bitte bestätigen Sie Ihre Identität per Fingerabdruck';
  baBiometric.PromptCancelButtonText := 'Cancel';
  baBiometric.OnAuthenticateFail:= BiometricAuth1AuthenticateFail;
  baBiometric.OnAuthenticateSuccess:= BiometricAuth1AuthenticateSuccess;
   if baBiometric.CanAuthenticate then
  begin
    bHasBiometric:= true;
  end
  else begin
    bHasBiometric:= false;
  end;
  pshsrvPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.FCM);
  consrvServiceConnection := TPushServiceConnection.Create(pshsrvPushService);
  consrvServiceConnection.Active := True;
  consrvServiceConnection.OnChange := OnServiceConnectionChange;
  consrvServiceConnection.OnReceiveNotification := OnReceiveNotificationEvent;
  dmmain.sDeviceId := pshsrvPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceId];
  pshsrvNtnNotifications := pshsrvPushService.StartupNotifications;
  {$ENDIF ANDROID}
  tc_more.ActiveTab:= ti_1ConfigMenu;
  SetDisableToolButtons;
  rec_main.Visible:= false;
  bOpened:= false;
  iProgramm:= 1;
  tc_Main.ActiveTab := ti_1Login;
  snglClientWidth := frm_PCM_Main.Width;
  snglClientHeight := frm_PCM_Main.Height;
  rec_main.Height := 48;
  {$IFDEF MSWINDOWS}
  btn_CloseApp.Visible:= true;
  lstbxitm_103Beenden.Visible:= true;
  FMX.Types.VKAutoShowMode:= TVKAutoShowMode.never;
  rec_main.Margins.Top:= 0;
  frm_PCM_Main.BorderStyle:= TFmxFormBorderStyle.None;
  {$ENDIF MSWINDOWS}
  {$IFDEF ANDROID}
  vsbx_Login.Touch.InteractiveGestures := [TInteractiveGesture.Pan];
  sDeviceDetail := JStringToString(TJBuild.JavaClass.MANUFACTURER) + ' ' + JStringToString(TJBuild.JavaClass.MODEL);
  sOSDetail := GetCodename(JStringToString(TJBuild_VERSION.JavaClass.RELEASE));
  try
    if pdsrvPhoneDialerService <> nil then
    begin
      sProviderDetail := pdsrvPhoneDialerService.GetCarrier.GetCarrierName;
    end
    else begin
      sProviderDetail:= 'kein Provider vorhanden'
    end;
  except
  end;
  {$ENDIF ANDROID}
  SetServerList;
  if iServerID <> -1 then
    dmmain.bServerAvailable:= CheckServerConnection;
  qry_Work.SQL.Text := sSQL_SELECT_All_AUTOLOGIN;
  qry_Work.Open;
  if qry_Work.RecordCount > 0 then
  begin
    edt_Benutzername.text:= qry_Work.FieldByName('Benutzername').AsString;
    {$ifdef MSWINDOWS}
    AutoLogin(qry_Work.FieldByName('Benutzername').AsString, qry_Work.FieldByName('Passwort').AsString);
    qry_Work.Close;
    {$ENDIF MSWINDOWS}
    {$IFDEF ANDROID}
    if qry_Work.FieldByName('FingerAuthenticate').AsBoolean = True then
    begin
      qry_Work.Close;
      img_BiometricClick(Self);
      tc_Main.ActiveTab:= ti_1Login;
    end
    else begin
      if qry_Work.FieldByName('Autologin').AsBoolean = True then
      begin
        AutoLogin(qry_Work.FieldByName('Benutzername').AsString, qry_Work.FieldByName('Passwort').AsString);
        qry_Work.Close;
      end;
    end;
    {$ENDIF ANDROID}
  end;
end;
procedure Tfrm_PCM_Main.FormResize(Sender: TObject);
begin
  ResizeLayout;
end;
procedure Tfrm_PCM_Main.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  dBounds.Create(0, 0, 0, 0);
  bNeedOffset := False;
end;
procedure Tfrm_PCM_Main.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  dBounds := TRectF.Create(Bounds);
  dBounds.TopLeft := ScreenToClient(dBounds.TopLeft);
  dBounds.BottomRight := ScreenToClient(dBounds.BottomRight);
end;
procedure Tfrm_PCM_Main.FormTouch(Sender: TObject; const Touches: TTouches; const Action: TTouchAction);
begin
  iTouchPosY := Touches[0].Location.Y;
  iTouchPosX := Touches[0].Location.X;
end;
{$EndRegion Formfunctions}
////////////////////////////////////////////////////////////////////////////////
// FORM OTHER FUNCTIONS                                                       //
////////////////////////////////////////////////////////////////////////////////
{$Region Other Form Functions}
procedure Tfrm_PCM_Main.btn_AddDataClick(Sender: TObject);
begin
  bNeu:= true;
  iID:= 0;
  iListviewID:= 0;
  if tc_MainApp.ActiveTab = ti_4MainBuchungen then
  begin
    Application.CreateForm(Tfrm_PCMAPP_BuchungenDetail,frm_PCMAPP_BuchungenDetail);
    frm_PCMAPP_BuchungenDetail.Show;
  end;
  if tc_MainApp.ActiveTab = ti_5MainFehltage then
  begin
    Application.CreateForm(Tfrm_PCMAPP_FehltageDetail,frm_PCMAPP_FehltageDetail);
    frm_PCMAPP_FehltageDetail.Show;
  end;
end;
procedure Tfrm_PCM_Main.btn_BackSystemClick(Sender: TObject);
begin
  btn_Multiview.visible:= true;
  case iTags of
    3:
    begin
      tc_MainApp.ActiveTab:= ti_4MainBuchungen;
      btn_backSystem.visible:= false;
    end;
    4:
    begin
      tc_MainApp.ActiveTab:= ti_5MainFehltage;
      btn_backSystem.visible:= false;
    end;
    5:
    begin
      tc_MainApp.ActiveTab:= ti_6MainMonatswerte;
      btn_backSystem.visible:= false;
    end;
    6:
    begin
      tc_More.ActiveTab:= ti_1ConfigMenu;
      btn_backSystem.visible:= false;
      btn_Synchronisation.Visible:= false;
      btn_AddData.Visible:= false;
    end;
    7:
    begin
      tc_More.ActiveTab:= ti_2ConfigConfig;
      iTags:= 6;
    end;
  end;
end;
procedure Tfrm_PCM_Main.btn_CloseAppClick(Sender: TObject);
begin
  Application.Terminate;
end;
procedure Tfrm_PCM_Main.btn_SearchClick(Sender: TObject);
begin
  if tc_MainApp.ActiveTab = ti_5MainFehltage then
  begin
    lv_Fehltage.SearchVisible := not lv_Fehltage.SearchVisible;
  end;
end;
procedure Tfrm_PCM_Main.tmr_CurDateTimeTimer(Sender: TObject);
var
  tKommen: TTime;
  tGehen: TTime;
  tPause1Beginn: TTime;
  tPause1ende: TTime;
  tPause2Beginn: TTime;
  tPause2ende: TTime;
begin
  lbl_CurDateTime.text:= 'Aktuelles Datum / Uhrzeit: ' + FormatDateTime('dd.MM.yyyy hh:mm:ss',Now);
  dmmain.qry_Timer.ResourceOptions.SilentMode:=True;
  dmmain.qry_Timer.SQL.Text:= sSQL_SELECT_TEXT_LASTBOOKING;
  dmmain.qry_Timer.open;
  lbl_LastBooking.Text:= dmmain.qry_Timer.FieldByName('Text').asString;
  dmmain.qry_Timer.Close;
  dmmain.qry_Timer.SQL.Text:= 'Select Kommen, Gehen, Pause1Beginn,Pause1ende,Pause2Beginn,Pause2ende From buchungen Where Datum = :Datum';
  dmmain.qry_Timer.ParamByName('Datum').AsDate:= Date;
  dmmain.qry_Timer.open;
  tKommen:= dmmain.qry_Timer.FieldByName('Kommen').AsDateTime;
  tGehen:= dmmain.qry_Timer.FieldByName('Gehen').AsDateTime;
  tPause1Beginn:=dmmain.qry_Timer.FieldByName('Pause1Beginn').AsDateTime;
  tPause1ende:=dmmain.qry_Timer.FieldByName('Pause1ende').AsDateTime;
  tPause2Beginn:=dmmain.qry_Timer.FieldByName('Pause2Beginn').AsDateTime;
  tPause2ende:=dmmain.qry_Timer.FieldByName('Pause2ende').AsDateTime;
  dmmain.qry_Timer.close;
  // Kommen
  if tKommen <> StrToTime('00:00') then
    btn_BookingWorkBegin.Enabled:= false
  else
    btn_BookingWorkBegin.Enabled:= true;
  // Gehen
  if (tGehen <> StrToTime('00:00')) or (btn_Bookingbreakend.Enabled) or (btn_BookingWorkBegin.Enabled) then
    btn_BookingWorkEnd.Enabled:= false
  else
    if (tKommen <> StrToTime('00:00')) then
      btn_BookingWorkEnd.Enabled:= true;
  // Pause Begin
  if (tPause1Beginn <> StrToTime('00:00')) and (tPause2Beginn <> StrToTime('00:00'))then
  begin
    if tKommen <> StrToTime('00:00') then
      btn_BookingBreakBegin.Enabled:= false
  end
  else begin
    if (tPause1Beginn <> StrToTime('00:00')) and (tPause1Ende = StrToTime('00:00')) or (tPause2Beginn <> StrToTime('00:00')) and (tPause2Ende = StrToTime('00:00')) then
    begin
      btn_BookingBreakBegin.Enabled:= false;
    end
    else begin
      if (tKommen <> StrToTime('00:00')) and (tGehen = StrToTime('00:00')) then
        btn_BookingBreakBegin.Enabled:= true;
    end;
  end;

  if (tPause1ende <> StrToTime('00:00')) and (tPause2ende <> StrToTime('00:00'))then
  begin
    btn_BookingBreakend.Enabled:= false
  end
  else begin
    if (tPause1ende <> StrToTime('00:00')) and (tPause2Beginn = StrToTime('00:00'))then
    begin
      btn_BookingBreakend.Enabled:= false
    end
    else begin
      if ((tPause2Beginn <> StrToTime('00:00')) and (tPause2Ende = StrToTime('00:00'))) or ((tPause1Beginn <> StrToTime('00:00')) and (tPause1Ende = StrToTime('00:00'))) then
      begin
        if (tKommen <> StrToTime('00:00')) and (tGehen = StrToTime('00:00')) then
            btn_BookingBreakend.Enabled:= true;
        end;
    end;
  end;
  if not btn_BookingWorkEnd.Enabled then
  begin
    btn_BookingBreakBegin.Enabled:= false;
  end;
  dmmain.qry_Timer.ResourceOptions.SilentMode:=false;
end;
procedure Tfrm_PCM_Main.tc_mainChange(Sender: TObject);
begin
  if tc_Main.ActiveTab = ti_5Finger then
  begin
    SetDisableToolButtons;
    img_BiometricClick(Sender);
    lbl_ModulName.Text := 'Authentifizierung';
  end;
  if tc_Main.ActiveTab = ti_1Login then
  begin
    rec_main.Visible:= false;
    SetDisableToolButtons;
    qry_Work.SQL.Text := sSQL_SELECT_All_AUTOLOGIN;
    qry_Work.Open;
    if qry_Work.RecordCount > 0 then
    begin
      if qry_Work.FieldByName('FingerAuthenticate').AsBoolean = True then
      begin
        btn_LoginBiometrie.visible:= true;
      end
      else begin
        btn_LoginBiometrie.visible:= false;
      end;
    end
    else begin
      btn_LoginBiometrie.visible:= false;
    end;
    lbl_ModulName.Text := 'Login';
  end
  else begin
    rec_main.Visible:= true;
  end;
end;
procedure Tfrm_PCM_Main.tc_MainAppChange(Sender: TObject);
begin
  if tc_MainApp.ActiveTab = ti_3MainOnline then
  begin
    tmr_CurDateTime.Enabled:= true;
  end
  else begin
    tmr_CurDateTime.Enabled:= false;
  end;
  if tc_MainApp.ActiveTab = ti_7More then
  begin
    WriteLog('Modul Weitere Optionen laden',0,false);
    try
      itags:= 6;
      SetDisableToolButtons;
      lbl_ModulName.Text := 'Weitere Optionen';
      btn_Synchronisation.Visible:= false;
    except
      on e:Exception do
        WriteLog('Fehler im Modul Finanzen ' + e.Message,0,false);
    end;
  end;
end;
{$EndRegion Other Form Functions}
////////////////////////////////////////////////////////////////////////////////
// Multiview Menu                                                             //
////////////////////////////////////////////////////////////////////////////////
{$Region Multiview}
procedure Tfrm_PCM_Main.lstbxitm_101HomeClick(Sender: TObject);
begin
  itags:= 0;
  mv_Menu.HideMaster;
  WriteLog('Modul Home laden',0,false);
  try
    CreateDashboard;
    lbl_ModulName.Text := 'Startseite';
  except
    on e:Exception do
      WriteLog('Fehler im Modul Home ' + e.Message,0,false);
  end;
  {$IFDEF MSWINDOWS}
  btn_Closeapp.visible:= true;
  {$ENDIF MSWINDOWS}
  tc_MainApp.ActiveTab := ti_1MainHome;
end;
procedure Tfrm_PCM_Main.lstbxitm_102PersonalClick(Sender: TObject);
begin
  itags:= 1;
  mv_Menu.HideMaster;
  WriteLog('Modul Personal laden',0,false);
  try
    qry_work.SQL.Text:= 'Select * From Kontakte';
    qry_work.open;
    if qry_work.FieldByName('Anrede').AsString = 'Herr' then
      cbx_Anrede.ItemIndex:= 0;
    if qry_work.FieldByName('Anrede').AsString = 'Frau' then
      cbx_Anrede.ItemIndex:= 1;
    if qry_work.FieldByName('Anrede').AsString = 'Familie' then
      cbx_Anrede.ItemIndex:= 2;
    edt_Vorname.Text:= qry_work.FieldByName('Vorname').AsString;
    edt_Nachname.Text:= qry_work.FieldByName('Nachname').AsString;
    if qry_work.FieldByName('Geschlecht').AsString = 'männlich' then
      cbx_Geschlecht.ItemIndex:=  0;
    if qry_work.FieldByName('Geschlecht').AsString = 'weiblich' then
      cbx_Geschlecht.ItemIndex:=  1;
    if qry_work.FieldByName('Geschlecht').AsString = 'Familie' then
      cbx_Geschlecht.ItemIndex:=  2;
    dtp_Geburtsdatum.Text:= qry_work.FieldByName('Geburtsdatum').AsString;
    if qry_work.FieldByName('Geburtsdatum').AsDateTime <>  StrToDate('30.12.1899') then
      dtp_Geburtsdatum.Text:= FormatDateTime('dd.mm.yyyy', qry_work.FieldByName('Geburtsdatum').AsDateTime)
    else
      dtp_Geburtsdatum.Text:= '';
    if qry_work.FieldByName('Familienstand').AsString = 'ledig' then
      cbx_Familienstand.itemindex:= 0;
    if qry_work.FieldByName('Familienstand').AsString = 'geschieden' then
      cbx_Familienstand.itemindex:= 1;
    if qry_work.FieldByName('Familienstand').AsString = 'verheiratet' then
      cbx_Familienstand.itemindex:= 2;
    if qry_work.FieldByName('Familienstand').AsString = 'verwitwet' then
      cbx_Familienstand.itemindex:= 3;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='deutsch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 0;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='englisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:=1;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='französisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 2;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='bosnisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 3;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='russisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 4;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='türkisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 5;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='amerikanisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 6;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='arabisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 7;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='indisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 8;
    if qry_work.FieldByName('Staatsangehoerigkeit').AsString='polnisch' then
      cbx_Staatsangehoerigkeit.ItemIndex:= 9;
    if qry_work.FieldByName('Konfession').AsString = 'Römisch-Katholisch' then
      cbx_Konfession.ItemIndex:= 0;
    if qry_work.FieldByName('Konfession').AsString = 'Evangelisch' then
      cbx_Konfession.ItemIndex:= 1;
    if qry_work.FieldByName('Konfession').AsString = 'Sonstige' then
      cbx_Konfession.ItemIndex:= 2;
    edt_Strasse.Text:= qry_work.FieldByName('Strasse').AsString;
    edt_Postleitzahl.Text:= qry_work.FieldByName('PLZ').AsString + ' ' + qry_work.FieldByName('Ort').AsString;;
    edt_Telefon.Text:= qry_work.FieldByName('Telefon').AsString;
    edt_Handy.Text:= qry_work.FieldByName('Handy').AsString;
    edt_Email.Text:= qry_work.FieldByName('Email').AsString;
    edt_Firma.Text:= qry_work.FieldByName('Firma').AsString;
    edt_StrasseFirma.Text:= qry_work.FieldByName('StrasseFirma').AsString;
    edt_PostleitzahlFirma.Text:= qry_work.FieldByName('PLZFirma').AsString + ' ' + qry_work.FieldByName('OrtFirma').AsString;
    edt_TelefonFirma.Text:= qry_work.FieldByName('TelefonFirma').AsString;
    edt_HandyFirma.Text:= qry_work.FieldByName('HandyFirma').AsString;
    edt_EmailFirma.Text:= qry_work.FieldByName('EmailFirma').AsString;
    edt_personalnr.text:= qry_work.FieldByName('Personalnummer').AsString;
    dedt_Eintritt.Text:= FormatDateTime('dd.mm.yyyy',qry_work.FieldByName('Eintritt').AsDateTime);
    edt_ULAnspruch.Value:= qry_work.FieldByName('Urlaub').AsFloat;
    edt_OffUrlaub.Value:= qry_work.FieldByName('OffsetResturlaub').AsFloat;
    edt_OffYear.Value:= qry_work.FieldByName('OffsetResturlaubJahr').AsInteger;
    edt_sollstunden.Text:= FormatDateTime('hh:mm',qry_work.FieldByName('Sollstunden').AsDateTime);
    qry_work.Close;
    lbl_ModulName.Text := 'Personal';
  except
    on e:Exception do
      WriteLog('Fehler im Modul Personal ' + e.Message,0,false);
  end;
  {$IFDEF MSWINDOWS}
  tc_personal.Margins.Left:= 16;
  tc_personal.Margins.Right:= 16;
  {$ENDIF MSWINDOWS}
  tc_MainApp.ActiveTab:= ti_2MainPersonal;
end;
procedure Tfrm_PCM_Main.lstbxitm_103OnlineClick(Sender: TObject);
var
  sText: String;
begin
  mv_Menu.HideMaster;
  tmr_CurDateTime.Enabled:= true;
  itags:= 2;
  WriteLog('Modul Online laden',0,false);
  try
    SetDisableToolButtons;
//    btn_Synchronisation.Visible:= true;
    lbl_ModulName.Text := 'Onlinebuchungen';
    qry_work.SQL.Text:= sSQL_SELECT_TEXT_LASTBOOKING;
    qry_work.open;
    sText:= qry_work.FieldByName('Text').asString;
    lbl_LastBooking.Text:= sText;
    qry_work.Close;
    btn_BookingWorkBegin.Height:= Round((tc_MainApp.Height - 8 - 55 - 64 - 39) / 4);
    btn_BookingWorkEnd.Height:= Round((tc_MainApp.Height - 8 - 55 - 64- 39) / 4);
    btn_BookingBreakBegin.Height:= Round((tc_MainApp.Height - 8 - 55 - 64- 39) / 4);
    btn_BookingBreakEnd.Height:= Round((tc_MainApp.Height - 8 - 55 - 64- 39) / 4);
    btn_Search.visible:= false;
    btn_AddData.Visible:= false;
  except
    on e:Exception do
      WriteLog('Fehler im Modul Online ' + e.Message,0,false);
  end;
  {$IFDEF MSWINDOWS}
  btn_Search.visible:= false;
  {$ENDIF MSWINDOWS}
  tc_MainApp.ActiveTab:= ti_3MainOnline;
end;
procedure Tfrm_PCM_Main.lstbxitm_104BuchungenClick(Sender: TObject);
begin
  mv_Menu.HideMaster;
  itags:= 3;
  WriteLog('Modul Buchungen laden',0,false);
  try
    SetDisableToolButtons;
    lbl_ModulName.Text := 'Buchungen';
    dmmain.wfWaitFrame.Execute('Lade Buchungsübersicht...', 'Buchungsübersicht', True);
    TTask.Run(
    procedure()
    begin
      TThread.Synchronize(nil,
      procedure()
      begin
        try
          SetGrid(Date);
        except
          dmmain.wfWaitFrame.HideFW;
        end;
      end);
      dmmain.wfWaitFrame.HideFW;
    end);
    btn_Search.visible:= true;
    btn_AddData.Visible:= false;
  except
    on e:Exception do
      WriteLog('Fehler im Modul Buchungen ' + e.Message,0,false);
  end;
  {$IFDEF MSWINDOWS}
  btn_Search.visible:= false;
  cal_Calendar.Margins.Left:= 16;
  cal_Calendar.Margins.Right:= 16;
  btn_Calc.Margins.Left:= 16;
  btn_Calc.Margins.Right:= 16;
  strgrd_Buchungen.Margins.Left:= 16;
  strgrd_Buchungen.Margins.Right:= 16;
  strgrd_Tageswerte.Margins.Left:= 16;
  strgrd_Tageswerte.Margins.Right:= 16;
  lo_Buchungen.Margins.Left:= 16;
  lo_Buchungen.Margins.Right:= 16;
  lo_Tageswerte.Margins.Left:= 16;
  lo_Tageswerte.Margins.Right:= 16;
  {$ENDIF MSWINDOWS}

//  cal_Calendar.Model.Data['Events']:=TValue.From<TStringArray>(aryList);
  cal_Calendar.Model.ShowWeekends:= true;
  tc_MainApp.ActiveTab:= ti_4MainBuchungen;
end;
procedure Tfrm_PCM_Main.lstbxitm_105FehltageClick(Sender: TObject);
begin
  mv_Menu.HideMaster;
  itags:= 4;
  WriteLog('Modul Fehltage laden',0,false);
  try
    btn_FehltageFilter.Tag:= 0;
    btn_FehltageFilter.Text:= 'nur aktuelles Jahr';
    SetDisableToolButtons;
    lbl_ModulName.Text := 'Fehltage';
    lv_Fehltage.Items.Clear;
    dmmain.wfWaitFrame.Execute('Lade Fehltage...', 'Fehltage', True);
    TTask.Run(
    procedure()
    begin
      TThread.Synchronize(nil,
      procedure()
      begin
        try
          lv_Fehltage.BeginUpdate;
          CreateFTGridConfig(True);
          lv_Fehltage.EndUpdate;
        except
          dmmain.wfWaitFrame.HideFW;
        end;
      end);
      dmmain.wfWaitFrame.HideFW;
    end);
    btn_Search.visible:= true;
    btn_AddData.Visible:= True;
  except
    on e:Exception do
      WriteLog('Fehler im Modul Fehltage ' + e.Message,0,false);
  end;
  {$IFDEF MSWINDOWS}
  btn_Search.visible:= false;
  btn_FehltageFilter.Margins.Left:= 16;
  btn_FehltageFilter.Margins.Right:= 16;
  lv_Fehltage.Margins.Left:= 16;
  lv_Fehltage.Margins.Right:= 16;
  {$ENDIF MSWINDOWS}
  tc_MainApp.ActiveTab:= ti_5MainFehltage;
end;
procedure Tfrm_PCM_Main.lstbxitm_106AuswertungClick(Sender: TObject);
var
  iJahr: integer;
  iMonat: integer;
  iJahrfrom: integer;
  iJahrto,iM,iT: word;
  i,iCBXCount: integer;
begin
  mv_Menu.HideMaster;
  itags:= 5;
  WriteLog('Modul Auswertung laden',0,false);
  iJahr:= Yearof(Date);
  iMonat:= Monthof(Date);
  try
    SetDisableToolButtons;
    lbl_ModulName.Text := 'Auswertung';
    btn_Search.visible:= false;
    btn_AddData.Visible:= false;
    cmbbx_MonatJahr.OnChange:= nil;
    cmbbx_JahrJa.OnChange:= nil;
    iJahrfrom:= iJahr-1;
    iJahrto:= iJahr+1;
    qry_work.SQL.Text:= 'Select OffsetResturlaubJahr From kontakte';
    qry_work.open;
    if qry_work.RecordCount > 0 then
      iJahrfrom:=qry_work.FieldByName('OffsetResturlaubJahr').AsInteger;
    qry_work.Close;
    qry_work.SQL.Text:= 'Select Datum From buchungen ORDER BY Datum DESC LIMIT 1';
    qry_work.open;
    if qry_work.RecordCount > 0 then
    begin
      DecodeDate(qry_work.FieldByName('Datum').AsDateTime,iJahrto,iM,iT);
    end;
    qry_work.Close;
    iCBXCount:= iJahrto -iJahrFrom;
    cmbbx_MonatJahr.Items.Clear;
    for i := 0 to iCBXCount  do
      cmbbx_MonatJahr.Items.Add(IntToStr((iJahrfrom + i)));
    cmbbx_MonatJahr.ItemIndex:= cmbbx_MonatJahr.Items.IndexOf(IntToStr(iJahr));
      iCBXCount:= iJahrto - (iJahrFrom + 1);
    cmbbx_JahrJA.Items.Clear;
    for i := 0 to iCBXCount  do
      cmbbx_JahrJA.Items.Add(IntToStr((iJahrfrom + 1 + i)));
    cmbbx_JahrJA.ItemIndex:= cmbbx_JahrJa.Items.IndexOf(IntToStr(iJahr));
    cmbbx_MonatMonat.OnChange:= nil;
    cmbbx_MonatMonat.ItemIndex:=iMonat- 1;
    cmbbx_MonatJahr.OnChange:= cmbbx_MonatMonatChange;
    cmbbx_JahrJa.OnChange:= cmbbx_JahrJaChange;
    cmbbx_MonatMonat.OnChange:= cmbbx_MonatMonatChange;
    BerechneMonatsUebersicht(iMonat,iJahr);
    BerechneJahresUebersicht(iJahr);
  except
    on e:Exception do
      WriteLog('Fehler im Modul Auswertung ' + e.Message,0,false);
  end;
  {$IFDEF MSWINDOWS}
  btn_Search.visible:= false;
  tc_Auswertung.Margins.Left:= 16;
  tc_Auswertung.Margins.Right:= 16;
  {$ENDIF MSWINDOWS}
   tc_MainApp.ActiveTab:= ti_6MainMonatswerte;
end;
procedure Tfrm_PCM_Main.lstbxitm_107MoreClick(Sender: TObject);
begin
  mv_Menu.HideMaster;
  itags:= 6;
  tc_MainApp.ActiveTab := ti_7More;
  tc_More.ActiveTab:= ti_1ConfigMenu;
  WriteLog('Modul Weitere Optionen laden',0,false);
  try
    SetDisableToolButtons;
    lbl_ModulName.Text := 'Weitere Optionen';
//    btn_Synchronisation.Visible:= true;
  except
    on e:Exception do
      WriteLog('Fehler im Modul Finanzen ' + e.Message,0,false);
  end;
  {$IFDEF MSWINDOWS}
  btn_Search.visible:= false;
  tc_more.Margins.Left:= 16;
  tc_more.Margins.Right:= 16;
  {$ENDIF MSWINDOWS}
end;
{$EndRegion Multiview}
////////////////////////////////////////////////////////////////////////////////
// Modulgrids                                                                 //
////////////////////////////////////////////////////////////////////////////////
{$Region Modulgrids}
////////////////////////////////////////////////////////////////////////////////
// Personal                                                                   //
////////////////////////////////////////////////////////////////////////////////
{$Region Personal}
procedure Tfrm_PCM_Main.img_MapFirmaClick(Sender: TObject);
begin
  if (edt_StrasseFirma.text <> '') and (edt_PostleitzahlFirma.text <> '') then
  begin
    SendToMapApp(edt_StrasseFirma.text,edt_PostleitzahlFirma.text);
  end;
end;
procedure Tfrm_PCM_Main.img_MapPrivatClick(Sender: TObject);
begin
  if (edt_Strasse.text <> '') and (edt_Postleitzahl.text <> '') then
  begin
    SendToMapApp(edt_Strasse.text,edt_Postleitzahl.text);
  end;
end;
procedure Tfrm_PCM_Main.img_TelefonFirmaClick(Sender: TObject);
begin
  if edt_TelefonFirma.Text <> '' then
  begin
    frm_PCM_Main.sDisplayname:= edt_Vorname.Text + ' ' + edt_Nachname.Text;
    frm_PCM_Main.sPhoneNumber:= edt_TelefonFirma.Text;
    frm_PCM_Main.MakeCall(Self);
  end;
end;
procedure Tfrm_PCM_Main.img_TelefonPrivatClick(Sender: TObject);
begin
  if edt_Telefon.Text <> '' then
  begin
    frm_PCM_Main.sDisplayname:= edt_Vorname.Text + ' ' + edt_Nachname.Text;
    frm_PCM_Main.sPhoneNumber:= edt_Telefon.Text;
    frm_PCM_Main.MakeCall(Self);
  end;
end;
procedure Tfrm_PCM_Main.img_HandyClick(Sender: TObject);
begin
  if edt_Handy.Text <> '' then
  begin
    frm_PCM_Main.sDisplayname:= edt_Vorname.Text + ' ' + edt_Nachname.Text;
    frm_PCM_Main.sPhoneNumber:=  edt_Handy.Text;
    frm_PCM_Main.MakeCall(Self);
  end;
end;
procedure Tfrm_PCM_Main.img_HandyFirmaClick(Sender: TObject);
begin
  if edt_HandyFirma.Text <> '' then
  begin
    frm_PCM_Main.sDisplayname:= edt_Vorname.Text + ' ' + edt_Nachname.Text;
    frm_PCM_Main.sPhoneNumber:= edt_HandyFirma.Text;
    frm_PCM_Main.MakeCall(Self);
  end;
end;
procedure Tfrm_PCM_Main.img_EMailClick(Sender: TObject);
begin
  if (edt_Email.text <> '') then
  begin
    SendMail(edt_Email.text);
  end;
end;
procedure Tfrm_PCM_Main.img_EMailfirmaClick(Sender: TObject);
begin
  if (edt_EMailfirma.text <> '') then
  begin
    SendMail(edt_Email.text);
  end;
end;
{$EndRegion Personal}
////////////////////////////////////////////////////////////////////////////////
// Online                                                                     //
////////////////////////////////////////////////////////////////////////////////
{$Region Online}
procedure Tfrm_PCM_Main.btn_BookingBreakBeginClick(Sender: TObject);
var
  sText: String;
  dDate: TDate;
  tTimes: TTime;
  tp1,tp2: TTime;
  dtNow: TDateTime;
  iStd,iMin,iSec,iMSec: word;
begin
  dmmain.wfWaitFrame.Execute('Buche Pause Beginn...', 'Online', True);
  TTask.Run(
  procedure()
  begin
    TThread.Synchronize(nil,
    procedure()
    begin
      dtNow:= now;
      dDate:= dtNow;
      DecodeTime(dtNow,iStd,iMin,iSec,iMSec);
      tTimes:= EncodeTime(iStd,iMin,0,0);
      qry_Work.SQL.Text:= 'Select Pause1Beginn,Pause2Beginn From buchungen Where Datum = :Datum';
      qry_Work.ParamByName('Datum').AsDate:= dDate;
      qry_Work.open;
      tp1:= qry_Work.FieldByName('Pause1Beginn').AsDateTime;
      tp2:= qry_Work.FieldByName('Pause2Beginn').AsDateTime;
      qry_Work.Close;

      if tp1 = StrToTime('00:00') then
      begin
        qry_Work.SQL.Text:= 'Update buchungen Set Pause1Beginn = :Pause1Beginn Where Datum = :Datum';
        qry_Work.ParamByName('Pause1Beginn').AsTime:= tTimes;
        qry_Work.ParamByName('Datum').AsDate:= dDate;
        qry_Work.ExecSQL;
        sText:= 'Letzte Buchung: 1. Pause Beginn am ' + FormatDateTime('dd.MM.yyyy hh:mm',dtNow);
        qry_Work.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
        qry_Work.ParamByName('Text').AsString := sText;
        qry_Work.ExecSQL;
        SynchOnlineBooking_ToServer(dmmain.iUserID,dDate,tTimes,3,1,dmmain.wfWaitFrame,True);
        SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
      end
      else begin
        if tp2 = StrToTime('00:00') then
        begin
          qry_Work.SQL.Text:= 'Update buchungen Set Pause2Beginn = :Pause2Beginn Where Datum = :Datum';
          qry_Work.ParamByName('Pause2Beginn').AsTime:= tTimes;
          qry_Work.ParamByName('Datum').AsDate:= dDate;
          qry_Work.ExecSQL;
          sText:= 'Letzte Buchung: 2. Pause Beginn am ' + FormatDateTime('dd.MM.yyyy hh:mm',dtNow);
          qry_Work.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work.ParamByName('Text').AsString := sText;
          qry_Work.ExecSQL;
          SynchOnlineBooking_ToServer(dmmain.iUserID,dDate,tTimes,5,1,dmmain.wfWaitFrame,True);
          SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
        end
      end;
    end);
    dmmain.wfWaitFrame.HideFW;
  end);
end;
procedure Tfrm_PCM_Main.btn_BookingBreakendClick(Sender: TObject);
var
  sText: String;
  dDate: TDate;
  tTimes: TTime;
  tp1,tp2: TTime;
  dtNow: TDateTime;
  iStd,iMin,iSec,iMSec: word;
begin
  dmmain.wfWaitFrame.Execute('Buche Pause Ende...', 'Online', True);
  TTask.Run(
  procedure()
  begin
    TThread.Synchronize(nil,
    procedure()
    begin
      dtNow:= now;
      dDate:= dtNow;
      DecodeTime(dtNow,iStd,iMin,iSec,iMSec);
      tTimes:= EncodeTime(iStd,iMin,0,0);
      qry_Work.SQL.Text:= 'Select Pause1Ende,Pause2Ende From buchungen Where Datum = :Datum';
      qry_Work.ParamByName('Datum').AsDate:= dDate;
      qry_Work.open;
      tp1:= qry_Work.FieldByName('Pause1Ende').AsDateTime;
      tp2:= qry_Work.FieldByName('Pause2Ende').AsDateTime;
      qry_Work.Close;

      if tp1 = StrToTime('00:00') then
      begin
        qry_Work.SQL.Text:= 'Update buchungen Set Pause1ende = :Pause1ende Where Datum = :Datum';
        qry_Work.ParamByName('Pause1ende').AsTime:= tTimes;
        qry_Work.ParamByName('Datum').AsDate:= dDate;
        qry_Work.ExecSQL;
        sText:= 'Letzte Buchung: 1. Pause Ende am ' + FormatDateTime('dd.MM.yyyy hh:mm',dtNow);
        qry_Work.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
        qry_Work.ParamByName('Text').AsString := sText;
        qry_Work.ExecSQL;
        SynchOnlineBooking_ToServer(dmmain.iUserID,dDate,tTimes,4,1,dmmain.wfWaitFrame,True);
        SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
      end
      else begin
        if tp2 = StrToTime('00:00') then
        begin
          qry_Work.SQL.Text:= 'Update buchungen Set Pause2ende = :Pause2ende Where Datum = :Datum';
          qry_Work.ParamByName('Pause2ende').AsTime:= tTimes;
          qry_Work.ParamByName('Datum').AsDate:= dDate;
          qry_Work.ExecSQL;
          sText:= 'Letzte Buchung: 2. Pause Ende am ' + FormatDateTime('dd.MM.yyyy hh:mm',dtNow);
          qry_Work.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
          qry_Work.ParamByName('Text').AsString := sText;
          qry_Work.ExecSQL;
          SynchOnlineBooking_ToServer(dmmain.iUserID,dDate,tTimes,6,1,dmmain.wfWaitFrame,True);
          SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
        end
      end;
    end);
    dmmain.wfWaitFrame.HideFW;
  end);
end;
procedure Tfrm_PCM_Main.btn_BookingWorkBeginClick(Sender: TObject);
var
  sText: String;
  dDate: TDate;
  tTimes: TTime;
  dtNow: TDateTime;
  iStd,iMin,iSec,iMSec: word;
begin
  dmmain.wfWaitFrame.Execute('Buche Arbeitsbeginn...', 'Online', True);
  TTask.Run(
  procedure()
  begin
    TThread.Synchronize(nil,
    procedure()
    begin
      dtNow:= now;
      dDate:= dtNow;
      DecodeTime(dtNow,iStd,iMin,iSec,iMSec);
      tTimes:= EncodeTime(iStd,iMin,0,0);
      qry_Work.SQL.Text:= 'Update buchungen Set Kommen = :Kommen,Buchungsart = :BA Where Datum = :Datum';
      qry_Work.ParamByName('Kommen').AsTime:= tTimes;
      qry_Work.ParamByName('BA').asInteger:= 1;
      qry_Work.ParamByName('Datum').AsDate:= dDate;
      qry_Work.ExecSQL;
      sText:= 'Letzte Buchung: Kommen am ' + FormatDateTime('dd.MM.yyyy hh:mm',dtNow);
      qry_Work.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
      qry_Work.ParamByName('Text').AsString := sText;
      qry_Work.ExecSQL;
      SynchOnlineBooking_ToServer(dmmain.iUserID,dDate,tTimes,1,1,dmmain.wfWaitFrame,True);
      SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
    end);
    dmmain.wfWaitFrame.HideFW;
  end);
end;
procedure Tfrm_PCM_Main.btn_BookingWorkEndClick(Sender: TObject);
var
  sText: String;
  dDate: TDate;
  tTimes: TTime;
  dtNow: TDateTime;
  iStd,iMin,iSec,iMSec: word;
  iJahr,iMonat,iTag: word;
begin
  dmmain.wfWaitFrame.Execute('Buche Arbeitsende...', 'Online', True);
  TTask.Run(
  procedure()
  begin
    TThread.Synchronize(nil,
    procedure()
    begin
      dtNow:= now;
      dDate:= dtNow;
      DecodeDate(dDate,iJahr,iMonat,iTag);
      DecodeTime(dtNow,iStd,iMin,iSec,iMSec);
      tTimes:= EncodeTime(iStd,iMin,0,0);
      qry_Work.SQL.Text:= 'Update buchungen Set Gehen = :Gehen Where Datum = :Datum';
      qry_Work.ParamByName('Gehen').AsTime:= tTimes;
      qry_Work.ParamByName('Datum').AsDate:= dDate;
      qry_Work.ExecSQL;
      sText:= 'Letzte Buchung: Gehen am ' + FormatDateTime('dd.MM.yyyy hh:mm',dtNow);
      qry_Work.SQL.Text:= sSQL_UPDATE_TEXT_LASTBOOKING;
      qry_Work.ParamByName('Text').AsString := sText;
      qry_Work.ExecSQL;
      SynchOnlineBooking_ToServer(dmmain.iUserID,dDate,tTimes,2,1,dmmain.wfWaitFrame,True);
      SynchLastBooking_toServer(dmmain.iUserID,dmmain.wfWaitFrame,True);
      BerechneTage(iTag,iMonat,iJahr);
    end);
    dmmain.wfWaitFrame.HideFW;
  end);
end;
{$EndRegion Online}
////////////////////////////////////////////////////////////////////////////////
// Buchungsuebersicht                                                         //
////////////////////////////////////////////////////////////////////////////////
{$Region Buchungsuebersicht}
procedure Tfrm_PCM_Main.btn_CalcClick(Sender: TObject);
var
  iJahr,iMonat,iTag: word;
begin
  DecodeDate(cal_Calendar.Date,iJahr,iMonat,iTag);
  BerechneTage(iTag,iMonat,iJahr);
  SetGrid(cal_Calendar.Date)
end;
procedure Tfrm_PCM_Main.cal_CalendarDateSelected(Sender: TObject);
var
   qry_Booking: TFDQuery;
   wJahr,wMonat,wTag: word;
   wJahrCurr,wMonatCurr,wTagCurr: word;
   iAnzahl: integer;
begin
  DecodeDate(cal_Calendar.Date,wJahr,wMonat,wTag);
  DecodeDate(Date,wJahrCurr,wMonatCurr,wTagCurr);
  qry_Booking:= TFDQuery.Create(Self);
  qry_Booking.Connection:= dmmain.con_PCM;
  qry_Booking.SQL.Text:= 'SELECT Count(*) as Anzahl From Buchungen Where Year(Datum) = :Jahr and Month(Datum) = :Monat';
  qry_Booking.ParamByName('Jahr').AsInteger:= wJahr;
  qry_Booking.ParamByName('Monat').AsInteger:= wMonat;
  qry_Booking.open;
  iAnzahl:= qry_Booking.FieldByName('Anzahl').AsInteger;
  qry_Booking.Close;
  FreeandNil(qry_Booking);
  if iAnzahl = 0 then
  begin
    dmmain.wfWaitFrame.Execute('Lade Buchungsübersicht...', 'Buchungsübersicht', True);
    TTask.Run(
    procedure()
    begin
      TThread.Synchronize(nil,
      procedure()
      begin
        try
          SynchBookingYear_FromServer(dmmain.iUserID, iServerID, wJahr,dmmain.wfWaitFrame);
        except
          dmmain.wfWaitFrame.HideFW;
        end;
      end);
      dmmain.wfWaitFrame.HideFW;
    end);
  end;
  BerechneTage(wTag,wMonat,wJahr);
  SetGrid(cal_Calendar.Date);
end;
procedure Tfrm_PCM_Main.strgrd_BuchungenCellClick(const Column: TColumn; const Row: Integer);
begin
  {$IFDEF ANDROID}
  iID:= StrToInt(strgrd_Buchungen.Cells[6, 0]);
  Application.CreateForm(Tfrm_PCMAPP_BuchungenDetail,frm_PCMAPP_BuchungenDetail);
  frm_PCMAPP_BuchungenDetail.Show;
  {$ENDIF ANDROID}
end;
procedure Tfrm_PCM_Main.strgrd_BuchungenCellDblClick(const Column: TColumn; const Row: Integer);
begin
  {$IFDEF MSWINDOWS}
  iID:= StrToInt(strgrd_Buchungen.Cells[6, 0]);
  Application.CreateForm(Tfrm_PCMAPP_BuchungenDetail,frm_PCMAPP_BuchungenDetail);
  frm_PCMAPP_BuchungenDetail.Show;
  {$ENDIF MSWINDOWS}
end;
procedure Tfrm_PCM_Main.Button1Click(Sender: TObject);
begin
  rec_buchungenInfo.Visible:= true;
end;
procedure Tfrm_PCM_Main.Button2Click(Sender: TObject);
begin
  rec_buchungenInfo.Visible:= false;
end;
procedure Tfrm_PCM_Main.Button3Click(Sender: TObject);
begin
  dmmain.wfWaitFrame.Execute('Berechne Jahr...', 'Monatswerte', True);

  TTask.Run(
  procedure()
  begin
    TThread.Synchronize(nil,
    procedure()
    begin
      try
        BerechneTage(0,1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,2,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(2,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,3,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(3,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,4,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(4,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,5,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(5,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,6,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(6,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,7,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(7,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,8,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(8,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,9,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(9,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,10,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(10,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,11,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(11,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneTage(0,12,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(12,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));

        BerechneMonatsUebersicht(frm_PCM_Main.cmbbx_MonatMonat.ItemIndex+1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
      except
        dmmain.wfWaitFrame.HideFW;
      end;
    end);
    dmmain.wfWaitFrame.HideFW;
  end);
end;

{$EndRegion Buchungsuebersicht}
////////////////////////////////////////////////////////////////////////////////
// Fehltage                                                                   //
////////////////////////////////////////////////////////////////////////////////
{$Region Fehltage}
procedure Tfrm_PCM_Main.btn_FehltageFilterClick(Sender: TObject);
begin
  if btn_FehltageFilter.Tag = 0 then
  begin
    btn_FehltageFilter.Tag:= 1;
    btn_FehltageFilter.Text:= 'alle Einträge';
    lv_Fehltage.Items.Clear;
    lv_Fehltage.BeginUpdate;
    CreateFTGridConfig(False);
    lv_Fehltage.EndUpdate;
  end
  else begin
    btn_FehltageFilter.Tag:= 0;
    btn_FehltageFilter.Text:= 'nur aktuelles Jahr';
    lv_Fehltage.Items.Clear;
    lv_Fehltage.BeginUpdate;
    CreateFTGridConfig(true);
    lv_Fehltage.EndUpdate;
  end;
end;
{$EndRegion Fehltage}
////////////////////////////////////////////////////////////////////////////////
// Monatswerte                                                                //
////////////////////////////////////////////////////////////////////////////////
{$Region Monatswerte}
procedure Tfrm_PCM_Main.btn_AuswertungJahrCalcClick(Sender: TObject);
begin
  dmmain.wfWaitFrame.Execute('Berechne Monat...', 'Monatswerte', True);
  TTask.Run(
  procedure()
  begin
    TThread.Synchronize(nil,
    procedure()
    begin
      try
        BerechneTage(0,1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,2,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(2,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,3,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(3,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,4,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(4,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,5,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(5,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,6,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(6,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,7,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(7,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,8,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(8,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,9,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(9,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,10,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(10,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,11,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(11,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneTage(0,12,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(12,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneJahresUebersicht(StrToint(cmbbx_JahrJa.Items[cmbbx_JahrJa.ItemIndex]));
      except
        dmmain.wfWaitFrame.HideFW;
      end;
    end);
    dmmain.wfWaitFrame.HideFW;
  end);
end;
procedure Tfrm_PCM_Main.btn_AuswertungMonatCalcClick(Sender: TObject);
begin
  dmmain.wfWaitFrame.Execute('Berechne Monat...', 'Monatswerte', True);
  TTask.Run(
  procedure()
  begin
    TThread.Synchronize(nil,
    procedure()
    begin
      try
        BerechneTage(0,frm_PCM_Main.cmbbx_MonatMonat.ItemIndex+1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonat(frm_PCM_Main.cmbbx_MonatMonat.ItemIndex+1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
        BerechneMonatsUebersicht(frm_PCM_Main.cmbbx_MonatMonat.ItemIndex+1,StrToint(frm_PCM_Main.cmbbx_MonatJahr.Items[frm_PCM_Main.cmbbx_MonatJahr.ItemIndex]));
      except
        dmmain.wfWaitFrame.HideFW;
      end;
    end);
    dmmain.wfWaitFrame.HideFW;
  end);
end;
procedure Tfrm_PCM_Main.cmbbx_JahrJAChange(Sender: TObject);
begin
  BerechneJahresUebersicht(StrToint(cmbbx_JahrJa.Items[cmbbx_JahrJa.ItemIndex]));
end;
procedure Tfrm_PCM_Main.cmbbx_MonatMonatChange(Sender: TObject);
begin
  BerechneMonatsUebersicht(cmbbx_MonatMonat.ItemIndex+1,StrToint(cmbbx_MonatJahr.Items[cmbbx_MonatJahr.ItemIndex]));
  if (Sender is TComboBox) then
  begin
    if TComboBox(Sender).Name = 'cmbbx_MonatJahr' then
    begin
      cmbbx_MonatMonat.ItemIndex:= 0;;
    end
  end;

end;
{$EndRegion Monatswerte}
////////////////////////////////////////////////////////////////////////////////
// More                                                                       //
////////////////////////////////////////////////////////////////////////////////
{$Region More}
procedure Tfrm_PCM_Main.lstbxitm_101OptionenClick(Sender: TObject);
begin
  btn_Multiview.visible:= false;
  tc_MainApp.ActiveTab:= ti_7More;
  iTags:= 6;
  try
    CreateFrameSystem;
  except
  end;
end;
procedure Tfrm_PCM_Main.lstbxitm_102AbmeldenClick(Sender: TObject);
begin
  TDialogServiceAsync.MessageDialog('ACHTUNG: Wenn Sie sich abmelden, muss bei der nächsten Anmeldung ' + #13 + 'ein aktive Serververbindung bestehen! Möchten Sie fortfahren?',
  TMsgDlgType.mtWarning, mbYesNo, TMsgDlgBtn.mbNo, 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYes then
    begin
      try
        Logout;
        {$IFDEF MSWINDOWS}
        btn_CloseApp.Visible:= true;
        {$ENDIF MSWINDOWS}
        lo_Frame.DeleteChildren;
        lo_DetailFrame.DeleteChildren;
        tc_Main.ActiveTab := ti_1Login;
      except
      end;
    end;
  end);
end;
procedure Tfrm_PCM_Main.lstbxitm_103BeendenClick(Sender: TObject);
begin
  Application.Terminate;
end;
{$EndRegion More}
{$EndRegion Modulgrids}
end.

