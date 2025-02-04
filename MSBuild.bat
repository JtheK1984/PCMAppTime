call "C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\rsvars.bat"
echo "Build erstellen"
msbuild E:/Projekte/Mobile/PCMTimeAPP/PCMTimeAPP.dproj /t:Clean;Build /p:config=Release /p:platform=Win32
msbuild E:/Projekte/Mobile/PCMTimeAPP/PCMTimeAPP.dproj /p:config=Debug /p:platform=Android /t:Clean;Make;Deploy
msbuild E:/Projekte/Mobile/PCMTimeAPP/PCMTimeAPP.dproj /t:Clean;Build /p:config=Release /p:platform=Win64
msbuild E:/Projekte/Mobile/PCMTimeAPP/PCMTimeAPP.dproj /p:config=Debug /p:platform=Android64 /t:Clean;Make;Deploy

echo "Kopiere Datei ins Setupverzeichnis 32-Bit"
copy /y /v E:\Projekte\Mobile\PCMTimeAPP\Android\Debug\PCMTimeAPP\bin\PCMManagerAPP.apk "e:\Inno\Setupfiles\Programme\PCMTimeAPP"
copy /y /v E:\Projekte\Mobile\PCMTimeAPP\Win32\Release\PCMTimeAPP.exe "e:\Inno\Setupfiles\Programme\PCMTimeAPP"

echo "Kopiere Datei ins Setupverzeichnis 64-Bit"
copy /y /v E:\Projekte\Mobile\PCMTimeAPP\Android64\Debug\PCMTimeAPP\bin\PCMManagerAPP.apk "e:\Inno\Setupfiles\Programme\PCMTimeAPP_x64"
copy /y /v E:\Projekte\Mobile\PCMTimeAPP\Win64\Release\PCMTimeAPP.exe "e:\Inno\Setupfiles\Programme\PCMTimeAPP_x64"
