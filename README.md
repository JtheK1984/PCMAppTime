# Projekt:
  PCMTimeApp.exe Version: 1.0.0.0

# Kurzbeschreibung:
  PCM - Time App

# Beschreibung
  reine Zeiterfassung mit Abwesenheitsverwaltung für Android, Synchronisierung über PCM-Restserver

# Entwicklungsumgebung:
  DELPHI 12.3 Athens

# Entwickler:
  Jens Henske

# Abhängigkeiten zu folgenden Sub-Modulen:
  - PCM-Functions
  (Dokumentation: [Azure DevOps](https://pcmapps.ddns.net:2443/PCM-DEV/PCM/PCMFunctions) [GitHub](https://github.com/JtheK1984/PCMFunctions))

# Abhängigkeiten zu folgenden DLLs:
  - 32-Bit 
    - libmysql.dll (DLL für Verbindung zur MySQL-Datenbank)
    - libeay32.dll (DLL für SSL-Verbindungen)
    - ssleay32.dll (DLL für SSL-Verbindungen)
  - 64-Bit 
    - libmysql.dll (DLL für Verbindung zur MySQL-Datenbank)
    - libeay32.dll (DLL für SSL-Verbindungen)
    - ssleay32.dll (DLL für SSL-Verbindungen)

# Erforderliche Komponenten (DELPHI-IDE):
  - Kastri-Master 11

# Erforderliche Scripte (nur für die Buildpipelines in Azure DevOps):
  - PrepareBuild.cmd (Umgebungsvariablen für Delphi anpassen, wird für den Build benötigt)
  - PrepareCopy.cmd (erzeugte Versionen werden in das Inno-Setupverzeichnis abgelgt)

# Stand:
  12.07.2026
