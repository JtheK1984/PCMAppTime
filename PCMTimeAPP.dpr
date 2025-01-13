program PCMTimeAPP;

uses
  FMX.Forms,
  System.StartUpCopy,
  PCMAPP.Main in 'PCMAPP.Main.pas' {frm_PCM_Main},
  PCMAPP.Datamodul in 'DB\PCMAPP.Datamodul.pas' {dmmain: TDataModule},
  PCMAPP.SQL in 'SQL\PCMAPP.SQL.pas',
  PCMAPP.Funktionen in 'Helper\PCMAPP.Funktionen.pas',
  PCMAPP.Kalender.Funktionen in 'Helper\PCMAPP.Kalender.Funktionen.pas',
  PCMAPP.Kalender.Feiertage.Funktionen in 'Helper\PCMAPP.Kalender.Feiertage.Funktionen.pas',
  PCMAPP.Server in 'Frame\PCMAPP.Server.pas' {frm_PCMAPP_Server},
  PCMAPP.System in 'Frame\PCMAPP.System.pas' {frm_PCMAPP_System: TFrame},
  PCMAPP.WaitForm in 'Frame\PCMAPP.WaitForm.pas' {WaitForm: TFrame},
  PCMAPP.Buchungen.Detail in 'FrameDetail\PCMAPP.Buchungen.Detail.pas' {frm_PCMAPP_BuchungenDetail},
  PCMAPP.Fehltage.Detail in 'FrameDetail\PCMAPP.Fehltage.Detail.pas' {frm_PCMAPP_FehltageDetail};
begin
//  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(Tdmmain, dmmain);
  Application.CreateForm(Tfrm_PCM_Main, frm_PCM_Main);
  Application.Run;
end.
