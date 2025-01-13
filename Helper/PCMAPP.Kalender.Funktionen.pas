unit PCMAPP.Kalender.Funktionen;

interface

uses
  System.Rtti, FMX.Calendar, System.UITypes;

type
  TCalendarModelHelpers = class helper for TCalendarModel
  public const
//    DefaultEventsColor = $FF005AB4;
//    DefaultWeekendsColor = $FF034A6F;
  private
    function GetShowEvents: Boolean;
    procedure SetShowEvents(const Value: Boolean);
    function GetShowWeekends: Boolean;
    procedure SetShowWeekends(const Value: Boolean);
    function GetEventsColor: TAlphaColor;
    procedure SetEventsColor(const Value: TAlphaColor);
    function GetWeekendsColor: TAlphaColor;
    procedure SetWeekendsColor(const Value: TAlphaColor);
  public
    property ShowEvents: Boolean read GetShowEvents write SetShowEvents;
    property ShowWeekends: Boolean read GetShowWeekends write SetShowWeekends;
    property EventsColor: TAlphaColor read GetEventsColor write SetEventsColor;
    property WeekendsColor: TAlphaColor read GetWeekendsColor write SetWeekendsColor;
  end;

implementation

uses PCMAPP.Main;
{ TCalendarModelHelpers }

function TCalendarModelHelpers.GetEventsColor: TAlphaColor;
var
  Value: TValue;
  DetailColor: cardinal;
  iDesignStyle: Integer;
begin
  DetailColor:= TAlphaColorRec.White;
  {$IFDEF ANDROID}
  iDesignStyle:= frm_PCM_Main.iDesignapp;
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  iDesignStyle:= frm_PCM_Main.iDesignwin;
  {$ENDIF MSWINDOWS}
  case iDesignStyle of
    0: // Calypso
    begin
      DetailColor:=$FF4D82BB;
    end;
    1: // Diamond
    begin
      DetailColor:= $FF93C4E5;
    end;
    2:
    begin
      DetailColor:= $FF5062A9;
    end;
    3:
    begin
      DetailColor:= $FF76B4F0;
    end;
    {$IFDEF MSWINDOWS}
    4:
    begin
      DetailColor:= $FF889CD1;
    end;
    {$ENDIF MSWINDOWS}
  end;
  Value := Data['EventsColor'];
  if Value.IsEmpty or Value.TryAsType<TAlphaColor>(Result) then
    Result := DetailColor;
end;
function TCalendarModelHelpers.GetShowEvents: Boolean;
begin
  Result := Data['ShowEvents'].AsBoolean;
end;
function TCalendarModelHelpers.GetShowWeekends: Boolean;
begin
  Result := Data['ShowWeekends'].AsBoolean;
end;
function TCalendarModelHelpers.GetWeekendsColor: TAlphaColor;
var
  Value: TValue;
  DetailColor: cardinal;
  iDesignStyle: Integer;
begin
  {$IFDEF ANDROID}
  iDesignStyle:= frm_PCM_Main.iDesignapp;
  {$ENDIF ANDROID}
  {$IFDEF MSWINDOWS}
  iDesignStyle:= frm_PCM_Main.iDesignwin;
  {$ENDIF MSWINDOWS}
  DetailColor:=TAlphaColorRec.White;
  case iDesignStyle of
    0: // Calypso
    begin
      DetailColor:=$FF405B78;
    end;
    1: // Diamond
    begin
      DetailColor:= $FFB1E2FF;
    end;
    2:
    begin
      DetailColor:= $FF6E80C7;
    end;
    3:
    begin
      DetailColor:= $FF94D2FF;
    end;
    {$IFDEF MSWINDOWS}
    4:
    begin
      DetailColor:= $FFA6BAEF;
    end;
    {$ENDIF MSWINDOWS}
  end;
  Value := Data['WeekendsColor'];
  if Value.IsEmpty or not Value.TryAsType<TAlphaColor>(Result) then
    Result := DetailColor;
end;
procedure TCalendarModelHelpers.SetEventsColor(const Value: TAlphaColor);
begin
  Data['EventsColor'] := TValue.From<TAlphaColor>(Value);
end;
procedure TCalendarModelHelpers.SetShowEvents(const Value: Boolean);
begin
  Data['ShowEvents'] := Value;
end;
procedure TCalendarModelHelpers.SetShowWeekends(const Value: Boolean);
begin
  Data['ShowWeekends'] := Value;
end;
procedure TCalendarModelHelpers.SetWeekendsColor(const Value: TAlphaColor);
begin
  Data['WeekendsColor'] := TValue.From<TAlphaColor>(Value);
end;

end.
