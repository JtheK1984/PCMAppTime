call "C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\rsvars.bat"
echo "Build erstellen"
msbuild E:/Projekte/Mobile/PCMManagerAPP/PCMManagerAPP.dproj /t:Clean;Build /p:config=Release /p:platform=Win32
msbuild E:/Projekte/Mobile/PCMManagerAPP/PCMManagerAPP.dproj /p:config=Debug /p:platform=Android /t:Clean;Make;Deploy
msbuild E:/Projekte/Mobile/PCMManagerAPP/PCMManagerAPP.dproj /t:Clean;Build /p:config=Release /p:platform=Win64
msbuild E:/Projekte/Mobile/PCMManagerAPP/PCMManagerAPP.dproj /p:config=Debug /p:platform=Android64 /t:Clean;Make;Deploy

echo "Kopiere Datei ins Setupverzeichnis 32-Bit"
copy /y /v E:\Projekte\Mobile\PCMManagerAPP\Android\Debug\PCMManagerAPP\bin\PCMManagerAPP.apk "e:\Inno\Setupfiles\Programme\PCMManagerAPP"
copy /y /v E:\Projekte\Mobile\PCMManagerAPP\Win32\Release\PCMManagerAPP.exe "e:\Inno\Setupfiles\Programme\PCMManagerAPP"

echo "Kopiere Datei ins Setupverzeichnis 64-Bit"
copy /y /v E:\Projekte\Mobile\PCMManagerAPP\Android64\Debug\PCMManagerAPP\bin\PCMManagerAPP.apk "e:\Inno\Setupfiles\Programme\PCMManagerAPP_x64"
copy /y /v E:\Projekte\Mobile\PCMManagerAPP\Win64\Release\PCMManagerAPP.exe "e:\Inno\Setupfiles\Programme\PCMManagerAPP_x64"
