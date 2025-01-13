unit PCMAPP.Kalender.Feiertage.Funktionen;

interface

uses
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
  FMX.Calendar,
  FMX.Calendar.Style,
  FMX.Controls.Model,
  FMX.Controls.Presentation,
  FMX.Presentation.Messages,
  FMX.ListBox,
  PCMAPP.Datamodul,
  PCMAPP.SQL,
  System.UITypes;
type

  TStyledCalendarWithHolidayDays = class(TStyledCalendar)
  protected
    { Messages from Model }
    /// <summary>Notification about changing value of DataSource of a model of <c>PresentedControl</c> </summary>
    procedure MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>); message MM_DATA_CHANGED;
  protected
    procedure FillDays; override;
    procedure CreateBackground(ADayItem: TListBoxItem; const AColor: TAlphaColor); virtual;
    procedure RemoveDaysBackgrounds;
    procedure PaintWeekends; virtual;
    procedure PaintEventswithReccurrence; virtual;
    procedure PaintEvents; virtual;
  end;

implementation

uses
  System.SysUtils, System.DateUtils, System.Math, System.Types, FMX.Presentation.Factory, FMX.Controls, FMX.Presentation.Style, FMX.Types, FMX.Objects, FMX.Graphics, PCMAPP.Kalender.Funktionen;

{ TStyledCalendarWithHolidayDays }


procedure TStyledCalendarWithHolidayDays.CreateBackground(ADayItem: TListBoxItem; const AColor: TAlphaColor);
var
  Hightlight: TCircle;
begin
  Hightlight := TCircle.Create(nil);
  Hightlight.Name := 'HightlightBackground';
  Hightlight.HitTest := False;
  Hightlight.Align := TAlignLayout.Contents;
  Hightlight.Margins.Rect := TRectF.Create(3, 3, 3, 3);
  Hightlight.Stroke.Kind := TBrushKind.None;
  Hightlight.Fill.Color := AColor;
  ADayItem.InsertObject(0, Hightlight);
end;
procedure TStyledCalendarWithHolidayDays.FillDays;
begin
  inherited;
  // Paint holidays
  RemoveDaysBackgrounds;
  if Model.ShowWeekends then
  begin
    PaintWeekends;
    PaintEventswithReccurrence;
  end;
  Repaint;
end;
procedure TStyledCalendarWithHolidayDays.MMDataChanged(var AMessage: TDispatchMessageWithValue<TDataRecord>);
begin
  if SameText(AMessage.Value.Key, 'ShowWeekends') or
     SameText(AMessage.Value.Key, 'ShowEvents') or
     SameText(AMessage.Value.Key, 'EventsColor') or
     SameText(AMessage.Value.Key, 'WeekendsColor') or
     SameText(AMessage.Value.Key, 'Events') then
    FillCalendar
  else
    inherited;
end;
procedure TStyledCalendarWithHolidayDays.PaintEvents;
var
  Events: TArray<TDateTime>;
  Event: TDateTime;
  DayItem: TListBoxItem;
begin
  if Model.Data['Events'].IsType<TArray<TDateTime>> then
  begin
    Events := Model.Data['Events'].AsType<TArray<TDateTime>>;
    for Event in Events do
    begin
      DayItem := TryFindDayItem(Event);
      if DayItem <> nil then
        CreateBackground(DayItem, Model.EventsColor);
    end;
  end;
end;
procedure TStyledCalendarWithHolidayDays.PaintEventswithReccurrence;
var
  DayItem: TListBoxItem;
  FirstDate: TDateTime;
  i: Integer;
  dtDateTimeEvent: TDateTime;
  dtLoopDate: TDateTime;
  wMonthDaysCount: Word;
  qry_Buchungen: TFDQuery;
  tConstTime: TTime;
begin
  tConstTime:= StrToTime('00:00');
  FirstDate := StartOfTheMonth(Self.Date);
  wMonthDaysCount := DaysInMonth(FirstDate);
  qry_Buchungen:= TFDQuery.Create(Self);
  qry_Buchungen.Connection:= dmmain.con_PCM;
  qry_Buchungen.SQL.Text:= 'SELECT Datum,Fehltag,Feiertag,Kommen,Gehen From Buchungen Where Datum between :Von and :Bis';
//  qry_Buchungen.ParamByName('Kommen').AsTime:= tConstTime;
//  qry_Buchungen.ParamByName('Gehen').AsTime:= tConstTime;
  qry_Buchungen.ParamByName('Von').AsDate:= StartOfTheMonth(Self.Date);
  qry_Buchungen.ParamByName('Bis').AsDate:= EndOfTheMonth(Self.Date);
  qry_Buchungen.open;
  while not qry_Buchungen.Eof do
  begin
    for I := 0 to wMonthDaysCount - 1 do
    begin
      dtLoopDate:= FirstDate + i;
      if Dateof(qry_Buchungen.FieldByName('Datum').AsDateTime) = dtLoopDate then
      begin
        DayItem := TryFindDayItem(dtLoopDate);
        // Feiertage
        if (qry_Buchungen.FieldByName('Feiertag').Asinteger > 0) then
        begin
          CreateBackground(DayItem,TAlphaColors.Darkseagreen);
        end
        else
          // Fehltage
          if (qry_Buchungen.FieldByName('Fehltag').AsString <> ' ') and (qry_Buchungen.FieldByName('Fehltag').AsString <> '') then
          begin
            if (qry_Buchungen.FieldByName('Fehltag').AsString = 'UL') or (qry_Buchungen.FieldByName('Fehltag').AsString = 'ULH') then
              CreateBackground(DayItem, TAlphaColors.Dodgerblue);
            if (qry_Buchungen.FieldByName('Fehltag').AsString = 'K') or (qry_Buchungen.FieldByName('Fehltag').AsString = 'KHT') then
              CreateBackground(DayItem, TAlphaColors.Indianred);
            if (qry_Buchungen.FieldByName('Fehltag').AsString = 'KiK') or (qry_Buchungen.FieldByName('Fehltag').AsString = 'UUL') then
              CreateBackground(DayItem, TAlphaColors.Goldenrod);
          end
          else begin
            if (qry_Buchungen.FieldByName('Kommen').AsDateTime <> StrToTime('00:00')) and (qry_Buchungen.FieldByName('Gehen').AsDateTime <> StrToTime('00:00')) then
              CreateBackground(DayItem, TAlphaColors.Grey);
          end;
      end;
    end;
    qry_Buchungen.Next;
  end;
  qry_Buchungen.Close;
  FreeandNil(qry_Buchungen);
end;
procedure TStyledCalendarWithHolidayDays.PaintWeekends;
var
  DayItem: TListBoxItem;
  FirstDate: TDateTime;
  FirstDay: Word;
  LWeek: Integer;
  WeekendDate: TDateTime;
  FirstWeekendDay: Integer;
  MonthDaysCount: Word;
  SaturdayDay: Word;
  SundayDay: Word;
begin
  FirstDate := StartOfTheMonth(Self.Date);
  FirstDay := DayOfTheWeek(FirstDate);
  MonthDaysCount := DaysInMonth(FirstDate);
  FirstWeekendDay := DaysPerWeek - FirstDay + 1;

  for LWeek := 0 to 4 do
  begin
    // Saturday
    SaturdayDay := FirstWeekendDay - 1 + LWeek * DaysPerWeek;
    if InRange(SaturdayDay, 1, MonthDaysCount) then
    begin
      WeekendDate := RecodeDay(FirstDate, SaturdayDay);
      DayItem := TryFindDayItem(WeekendDate);
      if DayItem <> nil then
        CreateBackground(DayItem, Model.WeekendsColor);
    end;
    // Sunday
    SundayDay := FirstWeekendDay + LWeek * DaysPerWeek;
    if InRange(SundayDay, 1, MonthDaysCount) then
    begin
      WeekendDate := RecodeDay(FirstDate, SundayDay);
      DayItem := TryFindDayItem(WeekendDate);
      if DayItem <> nil then
        CreateBackground(DayItem, Model.WeekendsColor);
    end;
  end;
end;
procedure TStyledCalendarWithHolidayDays.RemoveDaysBackgrounds;
  procedure RemoveBackground(ADayItem: TListBoxItem);
  var
    I: Integer;
    Background: TControl;
  begin
    for I := ADayItem.ControlsCount - 1 downto 0 do
      if ADayItem.Controls[I].Name = 'HightlightBackground' then
      begin
        Background := ADayItem.Controls[I];
        Background.Parent := nil;
        Background.Free;
      end;
  end;

var
  I: Integer;
  DayItem: TListBoxItem;
begin
  if Days <> nil then
    for I := 0 to Days.Count - 1 do
    begin
      DayItem := Days.ListItems[I];
      RemoveBackground(DayItem);
    end;
end;
initialization
  TPresentationProxyFactory.Current.Replace(TCalendar, TControlType.Styled, TStyledPresentationProxy<TStyledCalendarWithHolidayDays>);
finalization
  TPresentationProxyFactory.Current.Replace(TCalendar, TControlType.Styled, TStyledPresentationProxy<TStyledCalendar>);

end.

