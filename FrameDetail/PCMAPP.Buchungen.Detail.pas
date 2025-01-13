unit PCMAPP.Buchungen.Detail;

interface

uses
  {$Region uses}
  {$IFDEF ANDROID}
  Androidapi.Helpers,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Media,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Provider,
  Androidapi.JNI.Telephony,
  Androidapi.JNIBridge,
  FMX.Helpers.Android,
  FMX.PushNotification.Android,
  System.Android.Notification,
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  Shellapi,
  Winapi.Windows,
  {$ENDIF MSWINDOWS}
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DApt,
  FireDAC.DApt.Intf,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Async,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.DateTimeCtrls,
  FMX.Dialogs,
  FMX.DialogService.Async,
  FMX.Edit,
  FMX.EditBox,
  FMX.Effects,
  FMX.Forms,
  FMX.Graphics,
  FMX.ImgList,
  FMX.Layouts,
  FMX.ListBox,
  FMX.ListView,
  FMX.ListView.Adapters.Base,
  FMX.ListView.Appearances,
  FMX.ListView.Types,
  FMX.NumberBox,
  FMX.Objects,
  FMX.Platform,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  FMX.VirtualKeyboard,
  System.Classes,
  System.ImageList,
  system.math,
  System.SysUtils,
  System.Threading,
  System.Types,
  System.UITypes,
  System.Variants;
  {$EndRegion uses}
type
  {$Region Types}
  Tfrm_PCMAPP_BuchungenDetail = class(TForm)
    btn_Back: TButton;
    btn_Cancel: TButton;
    btn_Edit: TButton;
    btn_Save: TButton;
    cmbbx_Typ: TComboBox;
    dedt_datum: TDateEdit;
    edt_Fehltag: TEdit;
    edt_Feiertag: TEdit;
    lbl_Buchungsort: TLabel;
    lbl_Datum: TLabel;
    lbl_Fehltag: TLabel;
    lbl_Feiertag: TLabel;
    lbl_Gehen: TLabel;
    lbl_Kommen: TLabel;
    lbl_ModulName: TLabel;
    lbl_Pause1Beginn: TLabel;
    lbl_Pause1Ende: TLabel;
    lbl_Pause2Beginn: TLabel;
    lbl_Pause2Ende: TLabel;
    lo_Form: TLayout;
    lo_Left: TLayout;
    lo_Main: TLayout;
    lo_Right: TLayout;
    tb_Main: TRectangle;
    tedt_Gehen: TTimeEdit;
    tedt_Kommen: TTimeEdit;
    tedt_Pause1Beginn: TTimeEdit;
    tedt_Pause1Ende: TTimeEdit;
    tedt_Pause2Beginn: TTimeEdit;
    tedt_Pause2Ende: TTimeEdit;
    vsbx_main: TVertScrollBox;
    vsbx_PasswortDetailView: TVertScrollBox;
    procedure btn_BackClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
  private
    { Private-Deklarationen }
    bNeedOffset: Boolean;
    dBounds: TRectF;
    qry_Passwort: TFDQuery;
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
  public
    { Public-Deklarationen }
  end;
  {$EndRegion Types}
var
  {$Region var}
  frm_PCMAPP_BuchungenDetail: Tfrm_PCMAPP_BuchungenDetail;
  {$EndRegion var}
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
// HELPER FUNCTIONS                                                           //
////////////////////////////////////////////////////////////////////////////////
{$Region Helperfunctions}
procedure Tfrm_PCMAPP_BuchungenDetail.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
begin
  if bNeedOffset and (dBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - dBounds.Top);
  end;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.RestorePosition;
begin
  vsbx_main.ViewportPosition := PointF(vsbx_main.ViewportPosition.X, 0);
  lo_main.Align := TAlignLayout.Client;
  vsbx_main.RealignContent;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.UpdateKBBounds;
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  bNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(vsbx_main.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(dBounds))) and
       (LFocusRect.Bottom > dBounds.Top) then
    begin
      bNeedOffset := True;
      lo_main.Align := TAlignLayout.Horizontal;
      vsbx_main.RealignContent;
      Application.ProcessMessages;
      vsbx_main.ViewportPosition := PointF(vsbx_main.ViewportPosition.X,LFocusRect.Bottom - (dBounds.Top - 48));
    end;
  end;
  if not bNeedOffset then
    RestorePosition;
end;
{$EndRegion Helperfunctions}
////////////////////////////////////////////////////////////////////////////////
// Button FUNCTIONS                                                           //
////////////////////////////////////////////////////////////////////////////////
{$Region ButtonFunctions}
procedure Tfrm_PCMAPP_BuchungenDetail.btn_BackClick(Sender: TObject);
begin
  frm_PCMAPP_BuchungenDetail.Close;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.btn_CancelClick(Sender: TObject);
begin
  if frm_PCM_Main.bNeu then
  begin
    btn_Back.Visible:= true;
    btn_Cancel.Visible:= false;
    btn_Edit.Visible:= true;
    btn_save.Visible:= false;
    frm_PCMAPP_BuchungenDetail.close;
    frm_PCM_Main.bNeu:= false;
  end
  else begin
    qry_Passwort.SQL.Text:= 'Select * From Buchungen Where ID = :ID';
    qry_Passwort.ParamByName('ID').asInteger:= frm_PCM_Main.iID;
    qry_Passwort.open;
    dedt_datum.Date:= qry_Passwort.FieldByName('Datum').AsDateTime;
    tedt_Kommen.Time:= qry_Passwort.FieldByName('Kommen').AsDateTime;
    tedt_Gehen.Time:= qry_Passwort.FieldByName('Gehen').AsDateTime;
    tedt_Pause1Beginn.Time:= qry_Passwort.FieldByName('Pause1Beginn').AsDateTime;
    tedt_Pause1Ende.Time:= qry_Passwort.FieldByName('Pause1Ende').AsDateTime;
    tedt_Pause2Beginn.Time:= qry_Passwort.FieldByName('Pause2Beginn').AsDateTime;
    tedt_Pause2Ende.Time:= qry_Passwort.FieldByName('Pause2Ende').AsDateTime;
    cmbbx_Typ.ItemIndex:= qry_Passwort.FieldByName('Buchungsart').asInteger;
    case qry_Passwort.FieldByName('Feiertag').AsInteger of
    0: edt_Feiertag.text:='';
    1: edt_Feiertag.text:='ganzer Feiertag';
    2: edt_Feiertag.text:='halber Feiertag';
    end;
    edt_Fehltag.text:= qry_Passwort.FieldByName('Fehltag').AsString;
    qry_Passwort.Close;
    tedt_Kommen.Enabled:= false;
    tedt_Gehen.Enabled:= false;
    tedt_Pause1Beginn.Enabled:= false;
    tedt_Pause1Ende.Enabled:= false;
    tedt_Pause2Beginn.Enabled:= false;
    tedt_Pause2Ende.Enabled:= false;
    cmbbx_Typ.Enabled:= false;
    btn_Back.Visible:= true;
    btn_Cancel.Visible:= false;
    btn_Edit.Visible:= true;
    btn_save.Visible:= false;
  end;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.btn_EditClick(Sender: TObject);
begin
  tedt_Kommen.Enabled:= true;
  tedt_Gehen.Enabled:= true;
  tedt_Pause1Beginn.Enabled:= true;
  tedt_Pause1Ende.Enabled:= true;
  tedt_Pause2Beginn.Enabled:= true;
  tedt_Pause2Ende.Enabled:= true;
  cmbbx_Typ.Enabled:= true;
  btn_Back.Visible:= false;
  btn_Cancel.Visible:= true;
  btn_Edit.Visible:= false;
  btn_save.Visible:= true;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.btn_SaveClick(Sender: TObject);
var
  iJahr,iMonat,iTag:word;
begin
  if not frm_PCM_Main.bNeu then
  begin
    qry_Passwort.SQL.Text:= 'Update Buchungen Set Kommen =:Kommen, Gehen =:Gehen, Pause1Beginn =:Pause1Beginn, Pause1Ende =:Pause1Ende, Pause2Beginn =:Pause2Beginn, Pause2Ende =:Pause2Ende, Buchungsart =:Buchungsart Where ID = :ID';
    qry_Passwort.ParamByName('Kommen').AsTime:= tedt_Kommen.Time;
    qry_Passwort.ParamByName('Gehen').AsTime := tedt_Gehen.Time;
    qry_Passwort.ParamByName('Pause1Beginn').AsTime:= tedt_Pause1Beginn.Time;
    qry_Passwort.ParamByName('Pause1Ende').AsTime:= tedt_Pause1Ende.Time;
    qry_Passwort.ParamByName('Pause2Beginn').AsTime:= tedt_Pause2Beginn.Time;
    qry_Passwort.ParamByName('Pause2Ende').AsTime:= tedt_Pause2Ende.Time;
    if (cmbbx_Typ.ItemIndex = -1) or (cmbbx_Typ.ItemIndex > 1) then
      qry_Passwort.ParamByName('Buchungsart').AsInteger:= -1
    else
      qry_Passwort.ParamByName('Buchungsart').AsInteger:= cmbbx_Typ.ItemIndex;
    qry_Passwort.ParamByName('ID').AsInteger:= frm_PCM_Main.iID;
    try
      qry_Passwort.ExecSQl;
    except
    end;
    DecodeDate(dedt_datum.date,iJahr,iMonat,iTag);
    BerechneTage(iTag,iMonat,iJahr);
    SynchBooking_ToServer(frm_PCM_Main.iID);
    frm_PCM_Main.SetGrid(dedt_Datum.date);
    FreeAndNil(qry_Passwort);
    frm_PCMAPP_BuchungenDetail.Close;
  end;
  tedt_Kommen.Enabled:= false;
  tedt_Gehen.Enabled:= false;
  tedt_Pause1Beginn.Enabled:= false;
  tedt_Pause1Ende.Enabled:= false;
  tedt_Pause2Beginn.Enabled:= false;
  tedt_Pause2Ende.Enabled:= false;
  cmbbx_Typ.Enabled:= false;
  btn_Back.Visible:= true;
  btn_Cancel.Visible:= false;
  btn_Edit.Visible:= true;
  btn_save.Visible:= false;
end;
{$EndRegion ButtonFunctions}
////////////////////////////////////////////////////////////////////////////////
// FORM FUNCTIONS                                                             //
////////////////////////////////////////////////////////////////////////////////
{$Region Formfunctions}
procedure Tfrm_PCMAPP_BuchungenDetail.FormCreate(Sender: TObject);
begin
  vsbx_main.OnCalcContentBounds := CalcContentBoundsProc;
  {$IFDEF MSWINDOWS}
  frm_PCMAPP_BuchungenDetail.BorderStyle:=TFmxFormBorderStyle.None;
  {$ENDIF MSWINDOWS}
end;
procedure Tfrm_PCMAPP_BuchungenDetail.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qry_Passwort);
end;
procedure Tfrm_PCMAPP_BuchungenDetail.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.FormShow(Sender: TObject);
  procedure SetDesign;
  var
    iDesignStyle,icbxCount: integer;
    TextColor: Cardinal;
  begin
    {$IFDEF ANDROID}
    iDesignStyle:= frm_PCM_Main.iDesignapp;
    {$ENDIF ANDROID}
    {$IFDEF MSWINDOWS}
    iDesignStyle:= frm_PCM_Main.iDesignwin;
    {$ENDIF MSWINDOWS}
    TextColor:= TAlphaColorRec.White;
    case iDesignStyle of
      0: // Calypso
      begin
        frm_PCMAPP_BuchungenDetail.StyleBook:= dmMain.stB_0;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
      1: // Diamond
      begin
        frm_PCMAPP_BuchungenDetail.StyleBook:= dmMain.stB_1;
        TextColor:= TAlphaColorRec.Black;
        btn_Back.ImageIndex:= 2;
        btn_Cancel.ImageIndex:= 18;
        btn_Edit.ImageIndex:= 20;
        btn_Save.ImageIndex:= 22;
      end;
      2:
      begin
        frm_PCMAPP_BuchungenDetail.StyleBook:= dmMain.stB_2;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
      3:
      begin
        frm_PCMAPP_BuchungenDetail.StyleBook:= dmMain.stB_3;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
     {$IFdef MSWINDOWS}
      4:
      begin
        frm_PCMAPP_BuchungenDetail.StyleBook:= dmMain.stB_4;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
      {$ENDIF MSWINDOWS}
    end;
    for icbxCount := 0 to cmbbx_Typ.count - 1 do
    begin
      cmbbx_Typ.ListBox.ListItems[icbxCount].StyledSettings:= cmbbx_Typ.ListBox.ListItems[icbxCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cmbbx_Typ.ListBox.ListItems[icbxCount].TextSettings.Font.Size:= 14;
      cmbbx_Typ.ListBox.ListItems[icbxCount].TextSettings.FontColor:= TextColor;
    end;
  end;
begin
  SetDesign;
  qry_Passwort:= TFDQuery.Create(nil);
  qry_Passwort.Connection:= dmmain.con_PCM;
  dmmain.wfWaitFrame.Execute('Buchungen laden...', 'Buchungen', True);
  {$IFDEF MSWINDOWS}
  FMX.Types.VKAutoShowMode :=TVKAutoShowMode.Never;
  tb_main.Margins.Top:= 0;
  {$ENDIF MSWINDOWS}
  qry_Passwort.SQL.Text:= 'Select * From Buchungen Where ID = :ID';
  qry_Passwort.ParamByName('ID').asInteger:= frm_PCM_Main.iID;
  qry_Passwort.open;
  dedt_datum.Date:= qry_Passwort.FieldByName('Datum').AsDateTime;
  tedt_Kommen.Time:= qry_Passwort.FieldByName('Kommen').AsDateTime;
  tedt_Gehen.Time:= qry_Passwort.FieldByName('Gehen').AsDateTime;
  tedt_Pause1Beginn.Time:= qry_Passwort.FieldByName('Pause1Beginn').AsDateTime;
  tedt_Pause1Ende.Time:= qry_Passwort.FieldByName('Pause1Ende').AsDateTime;
  tedt_Pause2Beginn.Time:= qry_Passwort.FieldByName('Pause2Beginn').AsDateTime;
  tedt_Pause2Ende.Time:= qry_Passwort.FieldByName('Pause2Ende').AsDateTime;
  cmbbx_Typ.ItemIndex:= qry_Passwort.FieldByName('Buchungsart').AsInteger;
  case qry_Passwort.FieldByName('Feiertag').AsInteger of
    0: edt_Feiertag.text:='';
    1: edt_Feiertag.text:='ganzer Feiertag';
    2: edt_Feiertag.text:='halber Feiertag';
  end;
  edt_Fehltag.text:= qry_Passwort.FieldByName('Fehltag').AsString;
  qry_Passwort.Close;
  if frm_PCM_Main.iID= 0 then
  begin
    tedt_Kommen.Enabled:= true;
    tedt_Gehen.Enabled:= true;
    tedt_Pause1Beginn.Enabled:= true;
    tedt_Pause1Ende.Enabled:= true;
    tedt_Pause2Beginn.Enabled:= true;
    tedt_Pause2Ende.Enabled:= true;
    cmbbx_Typ.Enabled:= true;
    btn_Back.Visible:= false;
    btn_Cancel.Visible:= true;
    btn_Edit.Visible:= false;
    btn_save.Visible:= true;
  end;
  dmmain.wfWaitFrame.HideFW;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  dBounds.Create(0, 0, 0, 0);
  bNeedOffset := False;
  RestorePosition;
end;
procedure Tfrm_PCMAPP_BuchungenDetail.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  dBounds := TRectF.Create(Bounds);
  dBounds.TopLeft := ScreenToClient(dBounds.TopLeft);
  dBounds.BottomRight := ScreenToClient(dBounds.BottomRight);
  UpdateKBBounds;
end;
{$EndRegion Formfunctions}
end.
