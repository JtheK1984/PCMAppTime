unit PCMAPP.Fehltage.Detail;

interface

uses
  {$Region uses}
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
  FMX.NumberBox,
  FMX.Objects,
  FMX.Platform,
  FMX.StdCtrls,
  FMX.Types,
  FMX.VirtualKeyboard,
  System.Classes,
  System.DateUtils,
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
  Tfrm_PCMAPP_FehltageDetail = class(TForm)
    btn_Back: TButton;
    btn_Cancel: TButton;
    btn_Edit: TButton;
    btn_Save: TButton;
    cbx_Fehltag: TComboBox;
    dedt_Bis: TDateEdit;
    dedt_Von: TDateEdit;
    lbl_Bis: TLabel;
    lbl_Fehltag: TLabel;
    lbl_ModulName: TLabel;
    lbl_Von: TLabel;
    lo_Form: TLayout;
    lo_Left: TLayout;
    lo_Main: TLayout;
    lo_Right: TLayout;
    tb_Main: TRectangle;
    vsbx_main: TVertScrollBox;
    vsbx_SerialDetailView: TVertScrollBox;
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
    qry_Serial: TFDQuery;
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
  public
    { Public-Deklarationen }
  end;
  {$EndRegion Types}
var
  {$Region Var}
  frm_PCMAPP_FehltageDetail: Tfrm_PCMAPP_FehltageDetail;
  {$EndRegion Var}
implementation

{$R *.fmx}

uses
  {$Region uses}
  PCMAPP.Datamodul,
  PCMApp.Main,
  PCMAPP.SQL;
  {$EndRegion uses}
////////////////////////////////////////////////////////////////////////////////
// HELPER FUNCTIONS                                                           //
////////////////////////////////////////////////////////////////////////////////
{$Region Helperfunctions}
procedure Tfrm_PCMAPP_FehltageDetail.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
begin
  if bNeedOffset and (dBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - dBounds.Top);
  end;
end;
procedure Tfrm_PCMAPP_FehltageDetail.RestorePosition;
begin
  vsbx_main.ViewportPosition := PointF(vsbx_main.ViewportPosition.X, 0);
  lo_main.Align := TAlignLayout.Client;
  vsbx_main.RealignContent;
end;
procedure Tfrm_PCMAPP_FehltageDetail.UpdateKBBounds;
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
      vsbx_main.ViewportPosition :=
        PointF(vsbx_main.ViewportPosition.X,
               LFocusRect.Bottom - (dBounds.Top - 48));
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
procedure Tfrm_PCMAPP_FehltageDetail.btn_BackClick(Sender: TObject);
begin
  frm_PCMAPP_FehltageDetail.close;
end;
procedure Tfrm_PCMAPP_FehltageDetail.btn_CancelClick(Sender: TObject);
begin
  if frm_PCM_Main.bNeu then
  begin
    btn_Back.Visible:= true;
    btn_Cancel.Visible:= false;
    btn_Edit.Visible:= true;
    btn_save.Visible:= false;
    frm_PCM_Main.bNeu:= false;
  end
  else begin
    qry_Serial.SQL.Text:= 'Select * From Fehltage Where ID =:ID';
    qry_Serial.ParamByName('ID').asInteger:= frm_PCM_Main.iID;
    qry_Serial.open;
    dedt_Von.date:= qry_Serial.FieldByName('Von').AsDateTime;
    dedt_Bis.date:= qry_Serial.FieldByName('Bis').AsDateTime;
    cbx_Fehltag.ItemIndex:= cbx_Fehltag.Items.IndexOf(qry_Serial.FieldByName('Kuerzel').AsString  + ' - ' + qry_Serial.FieldByName('Beschreibung').AsString);
    qry_Serial.Close;

    dedt_Von.enabled:= false;
    dedt_Bis.Enabled:= false;
    cbx_Fehltag.Enabled:= false;

    btn_Back.Visible:= true;
    btn_Cancel.Visible:= false;
    btn_Edit.Visible:= true;
    btn_save.Visible:= false;
  end;
end;
procedure Tfrm_PCMAPP_FehltageDetail.btn_EditClick(Sender: TObject);
begin
  dedt_Von.enabled:= true;
  dedt_Bis.enabled:= true;
  cbx_Fehltag.Enabled:= true;
  btn_Back.Visible:= false;
  btn_Cancel.Visible:= true;
  btn_Edit.Visible:= false;
  btn_save.Visible:= true;
end;
procedure Tfrm_PCMAPP_FehltageDetail.btn_SaveClick(Sender: TObject);
var
  iID_FT: Integer;
  sKuerzel: String;
  sDesc: String;
  iNextID: Integer;
begin
  if (cbx_Fehltag.ItemIndex < 0 ) then
  begin
    TDialogServiceAsync.MessageDialog('Bitte wählen Sie einen Fehltag aus!',
    TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: TModalResult)
    begin
    end);
    exit;
  end;
  if dedt_Von.Date > dedt_bis.date then
  begin
    TDialogServiceAsync.MessageDialog('Start des Zeitraums liegt nach Ende des Zeitraums!',
    TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: TModalResult)
    begin
    end);
    exit;
  end;
  if Yearof(dedt_Von.Date) <> Yearof(dedt_bis.date) then
  begin
    TDialogServiceAsync.MessageDialog('Fehltage können nicht Jahresübergreifend eingetragen werden!',
    TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: TModalResult)
    begin
    end);
    exit;
  end;
  iID_FT:= Integer(cbx_Fehltag.Items.Objects[cbx_Fehltag.ItemIndex]);
  qry_Serial.SQL.Text:= 'Select Kuerzel, Beschreibung From Fehltag Where ID = :ID';
  qry_Serial.ParamByName('ID').AsInteger:= iID_FT;
  qry_Serial.Open;
  sKuerzel:= qry_Serial.FieldByName('Kuerzel').AsString;
  sDesc:= qry_Serial.FieldByName('Beschreibung').AsString;
  qry_Serial.Close;

  qry_Serial.SQL.Text:= 'Select Max(ID) + 1 as ID From Fehltage';
  qry_Serial.Open;
  iNextID:= qry_Serial.FieldByName('id').AsInteger;
  qry_Serial.Close;

  qry_Serial.SQL.Text:= 'Insert into Fehltage (ID,Von,Bis,Kuerzel,Beschreibung) Values (:ID,:Von,:Bis,:Kuerzel,:Beschreibung)';
  qry_Serial.ParamByName('ID').AsInteger:= iNextID;
  qry_Serial.ParamByName('Von').AsDateTime:= dedt_Von.Date;
  qry_Serial.ParamByName('Bis').AsDateTime:= dedt_Bis.Date;
  qry_Serial.ParamByName('Kuerzel').asString:= sKuerzel;
  qry_Serial.ParamByName('Beschreibung').AsString:= sDesc;
  qry_Serial.ExecSQl;
  frm_PCM_Main.lv_Fehltage.Items.Clear;
  frm_PCM_Main.lv_Fehltage.BeginUpdate;
  frm_PCM_Main.CreateFTGridConfig(true);
  frm_PCM_Main.lv_Fehltage.EndUpdate;
  frm_PCM_Main.bNeu:= FALSE;


  dedt_Von.enabled:= FALSE;
  dedt_Bis.enabled:= FALSE;
  cbx_Fehltag.Enabled:= FALSE;

  btn_Back.Visible:= true;
  btn_Cancel.Visible:= false;
  btn_Edit.Visible:= true;
  btn_save.Visible:= false;
  Close;
end;
{$EndRegion ButtonFunctions}
////////////////////////////////////////////////////////////////////////////////
// FORM FUNCTIONS                                                             //
////////////////////////////////////////////////////////////////////////////////
{$Region Formfunctions}
procedure Tfrm_PCMAPP_FehltageDetail.FormCreate(Sender: TObject);
begin
  qry_Serial:= TFDQuery.Create(nil);
  qry_Serial.Connection:= dmmain.con_PCM;
  vsbx_main.OnCalcContentBounds := CalcContentBoundsProc;
  {$IFDEF MSWINDOWS}
  frm_PCMAPP_FehltageDetail.BorderStyle:=TFmxFormBorderStyle.None;
  {$ENDIF MSWINDOWS}
end;
procedure Tfrm_PCMAPP_FehltageDetail.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qry_Serial);
end;
procedure Tfrm_PCMAPP_FehltageDetail.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;
procedure Tfrm_PCMAPP_FehltageDetail.FormShow(Sender: TObject);
  procedure FillCombobox;
  begin
    cbx_Fehltag.Items.Clear;
    qry_Serial.SQL.Text:= 'Select ID,Kuerzel, Beschreibung from Fehltag Where Kuerzel <> ''''';
    qry_Serial.open;
    while not qry_Serial.Eof do
    begin
      cbx_Fehltag.Items.AddObject(qry_Serial.FieldByName('Kuerzel').AsString  + ' - ' + qry_Serial.FieldByName('Beschreibung').AsString ,Tobject(qry_Serial.FieldByName('ID').AsInteger));
      qry_Serial.Next;
    end;
    qry_Serial.Close;
  end;
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
        frm_PCMAPP_FehltageDetail.StyleBook:= dmMain.stB_0;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
      1: // Diamond
      begin
        frm_PCMAPP_FehltageDetail.StyleBook:= dmMain.stB_1;
        TextColor:= TAlphaColorRec.Black;
        btn_Back.ImageIndex:= 2;
        btn_Cancel.ImageIndex:= 18;
        btn_Edit.ImageIndex:= 20;
        btn_Save.ImageIndex:= 22;
      end;
      2:
      begin
        frm_PCMAPP_FehltageDetail.StyleBook:= dmMain.stB_2;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
      3:
      begin
        frm_PCMAPP_FehltageDetail.StyleBook:= dmMain.stB_3;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
      {$IFDEF MSWINDOWS}
      4:
      begin
        frm_PCMAPP_FehltageDetail.StyleBook:= dmMain.stB_4;
        TextColor:= TAlphaColorRec.White;
        btn_Back.ImageIndex:= 3;
        btn_Cancel.ImageIndex:= 19;
        btn_Edit.ImageIndex:= 21;
        btn_Save.ImageIndex:= 23;
      end;
      {$ENDIF MSWINDOWS}
    end;
    for icbxCount := 0 to cbx_Fehltag.count - 1 do
    begin
      cbx_Fehltag.ListBox.ListItems[icbxCount].StyledSettings:= cbx_Fehltag.ListBox.ListItems[icbxCount].StyledSettings - [TStyledSetting.Size,TStyledSetting.Style,TStyledSetting.FontColor,TStyledSetting.Other];
      cbx_Fehltag.ListBox.ListItems[icbxCount].TextSettings.Font.Size:= 14;
      cbx_Fehltag.ListBox.ListItems[icbxCount].TextSettings.FontColor:= TextColor;
    end;
  end;
begin
  FillCombobox;
  SetDesign;
  dmmain.wfWaitFrame.Execute('Fehltage laden...', 'Fehltage', True);
  {$IFDEF MSWINDOWS}
  FMX.Types.VKAutoShowMode :=TVKAutoShowMode.Never;
  tb_main.Margins.Top:= 0;
  {$ENDIF MSWINDOWS}
  qry_Serial.SQL.Text:= 'Select * From Fehltage Where ID =:ID';
  qry_Serial.ParamByName('ID').asInteger:= frm_PCM_Main.iID;
  qry_Serial.open;
  dedt_Von.date:= Date;//qry_Serial.FieldByName('Von').AsDateTime;
  dedt_Bis.date:= Date;//qry_Serial.FieldByName('Bis').AsDateTime;
  cbx_Fehltag.ItemIndex:= 0;//cbx_Fehltag.Items.IndexOf(qry_Serial.FieldByName('Kuerzel').AsString  + ' - ' + qry_Serial.FieldByName('Beschreibung').AsString);
  qry_Serial.Close;
  if frm_PCM_Main.bNeu  then
  begin
    dedt_Von.enabled:= true;
    dedt_Bis.enabled:= true;
    cbx_Fehltag.Enabled:= true;
    btn_Back.Visible:= false;
    btn_Cancel.Visible:= true;
    btn_Edit.Visible:= false;
    btn_save.Visible:= true;
  end;
  dmmain.wfWaitFrame.HideFW;
end;
procedure Tfrm_PCMAPP_FehltageDetail.FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  dBounds.Create(0, 0, 0, 0);
  bNeedOffset := False;
  RestorePosition;
end;
procedure Tfrm_PCMAPP_FehltageDetail.FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
begin
  dBounds := TRectF.Create(Bounds);
  dBounds.TopLeft := ScreenToClient(dBounds.TopLeft);
  dBounds.BottomRight := ScreenToClient(dBounds.BottomRight);
  UpdateKBBounds;
end;
{$EndRegion Formfunctions}
end.



