unit PCMAPP.Server;

interface

uses
  {$Region Uses}
  Data.DB,
  Data.SqlExpr,
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
  FMX.Dialogs,
  FMX.DialogService.Async,
  FMX.Edit,
  FMX.Effects,
  FMX.Forms,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Memo,
  FMX.Objects,
  FMX.Platform,
  FMX.ScrollBox,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  IdHash,
  IdHashMessageDigest,
  System.Classes,
  System.IOUtils,
  System.Math,
  System.SysUtils,
  System.Threading,
  System.Types,
  System.UITypes,
  System.Variants;
  {$EndRegion Uses}
type
  {$Region Type}
  Tfrm_PCMAPP_Server = class(TForm)
    btn_BenutzerImg: TButton;
    btn_BezeichnungImg: TButton;
    btn_ErstelleServer: TButton;
    btn_LoescheBenutzer: TRectangle;
    btn_LoescheServer: TRectangle;
    btn_LokalPasswortLock: TButton;
    btn_LokalPasswortUnlock: TButton;
    btn_LokalPasswortWiederholenLock: TButton;
    btn_LokalPasswortWiederholenUnlock: TButton;
    btn_PortImg: TButton;
    btn_ServerImg: TButton;
    btn_SpeichereBenutzer: TRectangle;
    btn_SpeichereServer: TRectangle;
    btn_Zurueck: TButton;
    edt_Bezeichnung: TEdit;
    edt_LokalBenutzer: TEdit;
    edt_LokalPasswort: TEdit;
    edt_LokalPasswortWiederholen: TEdit;
    edt_Port: TEdit;
    edt_Server: TEdit;
    img_Localaccount: TImage;
    img_ServerBenutzerkonto: TImage;
    lbl_LocalaccountBody: TLabel;
    lbl_LocalaccountHeader: TLabel;
    lbl_LoescheBenutzer: TLabel;
    lbl_LoescheServer: TLabel;
    lbl_ModulName: TLabel;
    lbl_ServerBenutzerkontoBody: TLabel;
    lbl_ServerBenutzerkontoHeader: TLabel;
    lbl_SpeichereBenutzer: TLabel;
    lbl_SpeichereServer: TLabel;
    lo_Links: TLayout;
    lo_LokalBenutzerkontoImg: TLayout;
    lo_LokalBenutzerkontoLabel: TLayout;
    lo_LokalesBenutzerkonto: TLayout;
    lo_Rechts: TLayout;
    lo_Server: TLayout;
    lo_ServerBenutzerkontoImg: TLayout;
    lo_ServerBenutzerkontoLabel: TLayout;
    lo_ServerKonfiguration: TLayout;
    lo_ServerMain: TLayout;
    lstbx_Server: TListBox;
    lstbx_SystemInformation: TListBox;
    lstbxitm_1LokalBenutzerkonto: TListBoxItem;
    lstbxitm_2ServerBenutzerkonto: TListBoxItem;
    tb_Server: TRectangle;
    tc_Server: TTabControl;
    ti_1Benutzerkonto: TTabItem;
    ti_2Auswahl: TTabItem;
    ti_3Einstellungen: TTabItem;
    ti_4ServerKonfiguration: TTabItem;
    vsbx_Server: TVertScrollBox;
    procedure btn_ErstelleServerClick(Sender: TObject);
    procedure btn_LoescheServerClick(Sender: TObject);
    procedure btn_LokalPasswortLockClick(Sender: TObject);
    procedure btn_LokalPasswortUnlockClick(Sender: TObject);
    procedure btn_SpeichereBenutzerClick(Sender: TObject);
    procedure btn_SpeichereServerClick(Sender: TObject);
    procedure btn_ZurueckClick(Sender: TObject);
    procedure btn_LokalPasswortWiederholenLockClick(Sender: TObject);
    procedure btn_LokalPasswortWiederholenUnlockClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject; KeyboardVisible: Boolean; const Bounds: TRect);
    procedure lstbx_ServerItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure lstbxitm_1LokalBenutzerkontoClick(Sender: TObject);
    procedure lstbxitm_2ServerBenutzerkontoClick(Sender: TObject);
    procedure tc_ServerChange(Sender: TObject);
  private
    { Private declarations }
    bNeedOffset: Boolean;
    dBounds: TRectF;
    iItemID: Integer;
    qry_Work: TFDQuery;
    procedure Back;
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure ClearEdits;
    procedure FillEdits(bEdit: Boolean);
    procedure FillServerListBox;
    procedure RestorePosition;
    procedure UpdateKBBounds;
  public
    { Public declarations }
  end;
  {$EndRegion Type}
var
  {$Region Var}
  frm_PCMAPP_Server: Tfrm_PCMAPP_Server;
  {$EndRegion Var}
implementation

uses
  {$Region Uses}
  PCMAPP.Datamodul,
  PCMApp.Funktionen,
  PCMApp.Main,
  PCMApp.SQL;
  {$EndRegion Uses}
{$R *.fmx}
////////////////////////////////////////////////////////////////////////////////
// Helperfunctions                                                            //
////////////////////////////////////////////////////////////////////////////////
{$Region Helperfunctions}
procedure Tfrm_PCMAPP_Server.Back;
begin
  if tc_Server.ActiveTab = ti_2Auswahl then
  begin
    Close;
  end
  else begin
    iItemID := -1;
    tc_Server.ActiveTab := ti_2Auswahl;
    ClearEdits;
    btn_ErstelleServer.Visible := True;
  end;
end;
procedure Tfrm_PCMAPP_Server.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
begin
  if bNeedOffset and (dBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - dBounds.Top);
  end;
end;
procedure Tfrm_PCMAPP_Server.ClearEdits;
begin
  edt_Bezeichnung.Text := '';
  edt_Server.Text := '';
  edt_Port.Text := '';
  edt_Server.Enabled := True;
  edt_Port.Enabled := True;
end;
procedure Tfrm_PCMAPP_Server.FillEdits(bEdit: Boolean);
begin
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text := sSQL_SELECT_All_Server_Where_ID;
  qry_Work.ParamByName('ID').AsInteger := iItemID;
  qry_Work.Open;
  edt_Bezeichnung.Text := qry_Work.FieldByName('Bezeichnung').AsString;
  edt_Server.Text := qry_Work.FieldByName('Hostname').AsString;
  edt_Port.Text := qry_Work.FieldByName('Port').AsString;
  qry_Work.Close;
  Freeandnil(qry_Work);
  if bEdit then
  begin
    edt_Port.Enabled := true;
    edt_Server.Enabled := true;
  end;
end;
procedure Tfrm_PCMAPP_Server.FillServerListBox;
var
  iIndex: Integer;
begin
  lstbx_Server.Clear;
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text := sSQL_SELECT_All_Server;
  qry_Work.Open;
  while not qry_Work.Eof do
  begin
    iIndex := lstbx_Server.Items.Add(qry_Work.FieldByName('Bezeichnung').AsString);
    lstbx_Server.ItemByIndex(iIndex).Tag := qry_Work.FieldByName('ID').ASInteger;
    qry_Work.Next;
  end;
  qry_Work.Close;
  btn_ErstelleServer.Visible := True;
  Freeandnil(qry_Work);
end;
procedure Tfrm_PCMAPP_Server.RestorePosition;
begin
  vsbx_Server.ViewportPosition := PointF(vsbx_Server.ViewportPosition.X, 0);
  lo_ServerMain.Align := TAlignLayout.Client;
  vsbx_Server.RealignContent;
end;
procedure Tfrm_PCMAPP_Server.UpdateKBBounds;
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  bNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(vsbx_Server.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(dBounds))) and (LFocusRect.Bottom > dBounds.Top) then
    begin
      bNeedOffset := True;
      lo_ServerMain.Align := TAlignLayout.Horizontal;
      vsbx_Server.RealignContent;
      Application.ProcessMessages;
      vsbx_Server.ViewportPosition := PointF(vsbx_Server.ViewportPosition.X,LFocusRect.Bottom - dBounds.Top);
    end;
  end;
  if not bNeedOffset then
    RestorePosition;
end;
{$EndRegion HELPER FUNCTIONS}
////////////////////////////////////////////////////////////////////////////////
// COMPONENTS FUNCTIONS                                                       //
////////////////////////////////////////////////////////////////////////////////
{$Region COMPONENTS FUNCTIONS}
procedure Tfrm_PCMAPP_Server.btn_ErstelleServerClick(Sender: TObject);
begin
  tc_Server.ActiveTab := ti_4ServerKonfiguration;
  btn_ErstelleServer.Visible := False;
  btn_LoescheServer.Visible := False;
end;
procedure Tfrm_PCMAPP_Server.btn_LoescheServerClick(Sender: TObject);
begin
  TDialogServiceAsync.MessageDialog('ACHTUNG: Wenn der Server entfernt wird, ' + #13 + 'werden alle zum Server gespeicherten Userdaten ebenfalls entfernt! Möchten Sie fortfahren?', TMsgDlgType.mtWarning, mbYesNo, TMsgDlgBtn.mbNo, 0,
  procedure(const AResult: TModalResult)
  begin
    if AResult = mrYes then
    begin
      ClearAllTablesByID(iItemID, 'ID_Server');
      qry_Work:= TFDQuery.Create(nil);
      qry_Work.Connection:= dmmain.con_PCM;
      qry_Work.SQL.Text := sSQL_DELETE_All_Server;
      qry_Work.ExecSQL;
      Freeandnil(qry_Work);
      FillServerListBox;
      tc_Server.ActiveTab := ti_3Einstellungen;
      ClearEdits;
      btn_ErstelleServer.Visible := True;
    end;
  end);
  iItemID:= -1;
end;
procedure Tfrm_PCMAPP_Server.btn_LokalPasswortLockClick(Sender: TObject);
begin
  btn_LokalPasswortLock.Visible:= false;
  btn_LokalPasswortUnlock.Visible:= true;
  edt_LokalPasswort.Password:= false;
end;
procedure Tfrm_PCMAPP_Server.btn_LokalPasswortWiederholenLockClick(Sender: TObject);
begin
  btn_LokalPasswortWiederholenLock.Visible:= false;
  btn_LokalPasswortWiederholenUnlock.Visible:= true;
  edt_LokalPasswortWiederholen.Password:= true;
end;
procedure Tfrm_PCMAPP_Server.btn_SpeichereServerClick(Sender: TObject);
var
  iAnzahlAcc: integer;
begin
  if edt_Bezeichnung.Text = '' then
  begin
    TDialogServiceAsync.MessageDialog('Bitte tragen Sie eine Bezeichnung ein!',
    TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: TModalResult)
    begin
    end);
    exit;
  end;
  if edt_Server.Text = '' then
  begin
    TDialogServiceAsync.MessageDialog('Bitte tragen Sie einen Server ein!',
    TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: TModalResult)
    begin
    end);
    exit;
  end;
  if edt_Port.Text = '' then
  begin
    TDialogServiceAsync.MessageDialog('Bitte tragen Sie einen Port ein!',
    TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: TModalResult)
    begin
    end);
    exit;
  end;
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  if iItemID <= 0 then
  begin
    qry_Work.SQL.Text:= sSQL_INSERT_All_Server;
    qry_Work.ParamByName('Bez').AsString := edt_Bezeichnung.Text;
    qry_Work.ParamByName('Host').AsString := edt_Server.Text;
    qry_Work.ParamByName('Port').AsString := edt_Port.Text;
    qry_Work.ExecSQL;
  end else
  begin
    qry_Work.SQL.Text := sSQL_UPDATE_All_Server_WHERE_ID;
    qry_Work.ParamByName('Bez').AsString := edt_Bezeichnung.Text;
    qry_Work.ParamByName('Host').AsString := edt_Server.Text;
    qry_Work.ParamByName('Port').AsString := edt_Port.Text;
    qry_Work.ParamByName('ID').AsInteger := iItemID;
    qry_Work.ExecSQL;
  end;
  iAnzahlAcc:= GetCountFromTableAuto_Login;
  if iAnzahlAcc > 0 then
  begin
    qry_Work.SQL.Text := sSQL_UPDATE_LOCALACCOUNT_AUTOLOGIN;
    qry_Work.ParamByName('Localaccount').AsBoolean := false;
    qry_Work.ExecSQL;
  end;
  FreeAndNil(qry_Work);
  FillServerListBox;
  tc_Server.ActiveTab := ti_3Einstellungen;
  ClearEdits;
  btn_ErstelleServer.Visible := True;
  Close;
end;
procedure Tfrm_PCMAPP_Server.btn_SpeichereBenutzerClick(Sender: TObject);
var
  iAnzahlAcc: Integer;
  iAnzahlServer: Integer;
  iIDServer: Integer;
  idHMDHashMD5: TIdHashMessageDigest5;
  sHash: String;
  sPasswort: String;
begin
  if edt_LokalBenutzer.Text = '' then
  begin
    ShowMessage('Bitte vergeben Sie einen Benutzernamen');
    exit;
  end;
  if edt_LokalPasswort.Text = '' then
  begin
    ShowMessage('Bitte vergeben sie ein Passwort');
    exit;
  end;
  if edt_LokalPasswort.Text <> edt_LokalPasswortWiederholen.Text then
  begin
    ShowMessage('Die Passwörter stimmen nicht überein');
    exit;
  end;
  sPasswort := edt_LokalPasswort.Text;
  idHMDHashMD5 := TIdHashMessageDigest5.Create;
  try
    sHash := idHMDHashMD5.HashStringAsHex(sPasswort);
    sHash := LowerCase(sHash);
  finally
    idHMDHashMD5.Free;
  end;
  iAnzahlServer:= GetCountFromTableServer;
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  if iAnzahlServer = 0 then
  begin
    qry_work.SQL.Text := sSQL_INSERT_All_Server;
    qry_work.ParamByName('Bez').AsString := 'PCM';
    qry_work.ParamByName('Host').AsString := '127.0.0.1';
    qry_work.ParamByName('Port').AsString := '55700';
    qry_work.ExecSQL;
  end;
  qry_Work.SQL.Text:= sSQL_SELECT_ID_Server;
  qry_Work.open;
  iIDServer:= qry_Work.FieldByName('ID').AsInteger;
  qry_Work.Close;
  iAnzahlAcc:= GetCountFromTableAuto_Login;
  if iAnzahlAcc = 0 then
  begin
    qry_work.SQL.Text := sSQL_INSERT_All_AUTOLOGIN;
    qry_work.ParamByName('ID_Server').AsInteger := iIDServer;
    qry_work.ParamByName('Benutzername').AsString := edt_LokalBenutzer.Text;
    qry_work.ParamByName('Passwort').AsString := sHash;
    qry_work.ParamByName('Autologin').AsBoolean := True;
    qry_work.ParamByName('Design').AsInteger := 0;
    qry_work.ParamByName('DesignWin').AsInteger := 0;
    qry_work.ParamByName('DesignApp').AsInteger := 0;
    qry_work.ParamByName('Localaccount').AsBoolean := True;
    qry_work.ExecSQL;
  end else
  begin
    qry_work.SQL.Text := sSQL_UPDATE_ALL_AUTOLOGIN;
    qry_work.ParamByName('ID_Server').AsInteger := iIDServer;
    qry_work.ParamByName('Benutzername').AsString := edt_LokalBenutzer.Text;
    qry_work.ParamByName('Passwort').AsString := sHash;
    qry_work.ParamByName('Autologin').AsBoolean := True;
    qry_work.ParamByName('Design').AsInteger := 0;
    qry_work.ParamByName('Localaccount').AsBoolean := True;
    qry_work.ExecSQL;
  end;
  iAnzahlAcc:= GetCountFromTableLogin;
  if iAnzahlAcc = 0 then
  begin
    qry_work.SQL.Text := sSQL_INSERT_All_login;
    qry_work.ParamByName('ID_Server').AsInteger := iIDServer;
    qry_work.ParamByName('Benutzername').AsString := edt_Port.Text;
    qry_work.ParamByName('Passwort').AsString := sHash;
    qry_work.ParamByName('Firststart').AsBoolean := True;
    qry_work.ParamByName('ID_Benutzer').AsInteger := 0;
    qry_work.ExecSQL;
  end else
  begin
    qry_work.SQL.Text := sSQL_UPDATE_ALL_login;
    qry_work.ParamByName('ID_Server').AsInteger := iIDServer;
    qry_work.ParamByName('Benutzername').AsString := edt_Port.Text;
    qry_work.ParamByName('Passwort').AsString := sHash;
    qry_work.ParamByName('Firststart').AsBoolean := False;
    qry_work.ParamByName('ID_Benutzer').AsInteger := 0;
    qry_work.ExecSQL;
  end;
  frm_PCM_Main.edt_Benutzername.Text:= edt_LokalBenutzer.Text;
  frm_PCM_Main.edt_Passwort.Text:= edt_LokalPasswort.Text;
  Freeandnil(qry_Work);
  Close;
end;
procedure Tfrm_PCMAPP_Server.btn_LokalPasswortUnlockClick(Sender: TObject);
begin
  btn_LokalPasswortLock.Visible:= true;
  btn_LokalPasswortUnlock.Visible:= false;
  edt_LokalPasswort.Password:= true;
end;
procedure Tfrm_PCMAPP_Server.btn_ZurueckClick(Sender: TObject);
begin
  if tc_Server.ActiveTab = ti_2Auswahl then Back;
  if tc_Server.ActiveTab = ti_1Benutzerkonto then tc_Server.ActiveTab:= ti_2Auswahl;
  if tc_Server.ActiveTab = ti_3Einstellungen then tc_Server.ActiveTab:= ti_2Auswahl;
  if tc_Server.ActiveTab = ti_4ServerKonfiguration then tc_Server.ActiveTab:= ti_3Einstellungen;
end;
procedure Tfrm_PCMAPP_Server.btn_LokalPasswortWiederholenUnlockClick(Sender: TObject);
begin
  btn_LokalPasswortWiederholenLock.Visible:= true;
  btn_LokalPasswortWiederholenUnlock.Visible:= false;
  edt_LokalPasswortWiederholen.Password:= false;
end;
procedure Tfrm_PCMAPP_Server.lstbx_ServerItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  tc_Server.ActiveTab := ti_4ServerKonfiguration;
  iItemID := Item.Tag;
  FillEdits(True);
  btn_ErstelleServer.Visible := False;
  btn_LoescheServer.Visible := True;
end;
procedure Tfrm_PCMAPP_Server.lstbxitm_1LokalBenutzerkontoClick(Sender: TObject);
begin
  btn_ErstelleServer.Visible:= false;
  tc_Server.ActiveTab := ti_1Benutzerkonto;
  qry_Work:= TFDQuery.Create(nil);
  qry_Work.Connection:= dmmain.con_PCM;
  qry_Work.SQL.Text:= sSQL_SELECT_All_AUTOLOGIN;
  qry_Work.open;
  edt_LokalBenutzer.Text:= qry_work.FieldByName('Benutzername').AsString;
  edt_LokalPasswort.Text:= qry_work.FieldByName('Passwort').AsString;
  edt_LokalPasswortWiederholen.Text:= qry_work.FieldByName('Passwort').AsString;
  qry_work.close;
  Freeandnil(qry_work);
end;
procedure Tfrm_PCMAPP_Server.lstbxitm_2ServerBenutzerkontoClick(Sender: TObject);
var
  iCount: integer;
begin
  iCount:= GetCountFromTableServer;
  if iCount > 0 then
  begin
    btn_ErstelleServer.Visible:= false;
    tc_Server.ActiveTab := ti_3Einstellungen;
  end
  else
  begin
    tc_Server.ActiveTab := ti_4ServerKonfiguration;
    btn_ErstelleServer.Visible := False;
    btn_LoescheServer.Visible := False;
  end;
end;
procedure Tfrm_PCMAPP_Server.tc_ServerChange(Sender: TObject);
var
  iCount: integer;
begin
  if tc_Server.ActiveTab = ti_3Einstellungen then
  begin
    iCount:= GetCountFromTableServer;
    if iCount > 0 then
      btn_ErstelleServer.Visible:= false
    else
      btn_ErstelleServer.Visible:= true;
  end
  else begin
    btn_ErstelleServer.Visible:= false;
  end;
end;
{$EndRegion COMPONENTS FUNCTIONS}
////////////////////////////////////////////////////////////////////////////////
// FORM FUNCTIONS                                                             //
////////////////////////////////////////////////////////////////////////////////
{$Region Form FUNCTIONS}
procedure Tfrm_PCMAPP_Server.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frm_PCM_Main.SetServerList;
  Action := TCloseAction.caFree;
end;
procedure Tfrm_PCMAPP_Server.FormCreate(Sender: TObject);
begin
  vsbx_Server.OnCalcContentBounds := CalcContentBoundsProc;
end;
procedure Tfrm_PCMAPP_Server.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;
procedure Tfrm_PCMAPP_Server.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkHardwareBack) and (Sender.ClassName = 'TfrmServer') then
  begin
    Key := 0;
    Back;
  end;
end;
procedure Tfrm_PCMAPP_Server.FormShow(Sender: TObject);
  procedure SetDesign;
  var
    iDesignStyle: Integer;
  begin
    {$IFDEF ANDROID}
    iDesignStyle:= frm_PCM_Main.iDesignapp;
    {$ENDIF ANDROID}
    {$IFDEF MSWINDOWS}
    iDesignStyle:= frm_PCM_Main.iDesignwin;
    {$ENDIF MSWINDOWS}
    case iDesignStyle of
      0: // Calypso
      begin
        frm_PCMAPP_Server.StyleBook:= dmMain.stB_0;
        btn_Zurueck.ImageIndex:= 3;
        btn_ErstelleServer.ImageIndex:= 7;
        btn_LokalPasswortLock.ImageIndex:= 15;
        btn_LokalPasswortUnlock.ImageIndex:= 17;
        btn_LokalPasswortWiederholenLock.ImageIndex:= 15;
        btn_LokalPasswortWiederholenUnlock.ImageIndex:= 17;
        btn_BenutzerImg.ImageIndex:= 13;
        btn_BezeichnungImg.ImageIndex:= 25;
        btn_PortImg.ImageIndex:= 27;
        btn_ServerImg.ImageIndex:= 29;
      end;
      1: // Diamond
      begin
        frm_PCMAPP_Server.StyleBook:= dmMain.stB_1;
        btn_Zurueck.ImageIndex:= 2;
        btn_ErstelleServer.ImageIndex:= 6;
        btn_LokalPasswortLock.ImageIndex:= 14;
        btn_LokalPasswortUnlock.ImageIndex:= 16;
        btn_LokalPasswortWiederholenLock.ImageIndex:= 14;
        btn_LokalPasswortWiederholenUnlock.ImageIndex:= 16;
        btn_BenutzerImg.ImageIndex:= 12;
        btn_BezeichnungImg.ImageIndex:= 24;
        btn_PortImg.ImageIndex:= 26;
        btn_ServerImg.ImageIndex:= 28;
      end;
      2:
      begin
        frm_PCMAPP_Server.StyleBook:= dmMain.stB_2;
        btn_Zurueck.ImageIndex:= 3;
        btn_ErstelleServer.ImageIndex:= 7;
        btn_LokalPasswortLock.ImageIndex:= 15;
        btn_LokalPasswortUnlock.ImageIndex:= 17;
        btn_LokalPasswortWiederholenLock.ImageIndex:= 15;
        btn_LokalPasswortWiederholenUnlock.ImageIndex:= 17;
        btn_BenutzerImg.ImageIndex:= 13;
        btn_BezeichnungImg.ImageIndex:= 25;
        btn_PortImg.ImageIndex:= 27;
        btn_ServerImg.ImageIndex:= 29;
      end;
      3:
      begin
        frm_PCMAPP_Server.StyleBook:= dmMain.stB_3;
        btn_Zurueck.ImageIndex:= 3;
        btn_ErstelleServer.ImageIndex:= 7;
        btn_LokalPasswortLock.ImageIndex:= 15;
        btn_LokalPasswortUnlock.ImageIndex:= 17;
        btn_LokalPasswortWiederholenLock.ImageIndex:= 15;
        btn_LokalPasswortWiederholenUnlock.ImageIndex:= 17;
        btn_BenutzerImg.ImageIndex:= 13;
        btn_BezeichnungImg.ImageIndex:= 25;
        btn_PortImg.ImageIndex:= 27;
        btn_ServerImg.ImageIndex:= 29;
      end;
      {$IFDEF MSWINDOWS}
      4:
      begin
        frm_PCMAPP_Server.StyleBook:= dmMain.stB_4;
        btn_Zurueck.ImageIndex:= 3;
        btn_ErstelleServer.ImageIndex:= 7;
        btn_LokalPasswortLock.ImageIndex:= 15;
        btn_LokalPasswortUnlock.ImageIndex:= 17;
        btn_LokalPasswortWiederholenLock.ImageIndex:= 15;
        btn_LokalPasswortWiederholenUnlock.ImageIndex:= 17;
        btn_BenutzerImg.ImageIndex:= 13;
        btn_BezeichnungImg.ImageIndex:= 25;
        btn_PortImg.ImageIndex:= 27;
        btn_ServerImg.ImageIndex:= 29;
      end;
      {$ENDIF MSWINDOWS}
    end;
  end;
begin
  SetDesign;
  {$IFDEF MSWINDOWS}
  FMX.Types.VKAutoShowMode :=TVKAutoShowMode.Never;
  tb_Server.Margins.Top:= 0;
  frm_PCMApp_Server.BorderStyle:= TFmxFormBorderStyle.None;
  {$ENDIF MSWINDOWS}
  tc_Server.ActiveTab := ti_2Auswahl;
  FillServerListBox;
  btn_ErstelleServer.Visible:= false;
end;
procedure Tfrm_PCMAPP_Server.FormVirtualKeyboardHidden(Sender: TObject;KeyboardVisible: Boolean;const Bounds: TRect);
begin
  dBounds.Create(0, 0, 0, 0);
  bNeedOffset := False;
  RestorePosition;
end;
procedure Tfrm_PCMAPP_Server.FormVirtualKeyboardShown(Sender: TObject;KeyboardVisible: Boolean;const Bounds: TRect);
begin
  dBounds := TRectF.Create(Bounds);
  dBounds.TopLeft := ScreenToClient(dBounds.TopLeft);
  dBounds.BottomRight := ScreenToClient(dBounds.BottomRight);
  UpdateKBBounds;
end;
{$EndRegion Form FUNCTIONS}
end.
