call "C:\Program Files (x86)\Embarcadero\Studio\23.0\bin\rsvars.bat"
echo "Build erstellen"
msbuild E:/Projekte/Mobile/PCMTimeApp/PCMTimeApp.dproj /t:Clean;Build /p:config=Release /p:platform=Win32
msbuild E:/Projekte/Mobile/PCMTimeApp/PCMTimeApp.dproj /p:config=Debug /p:platform=Android /t:Clean;Make;Deploy
msbuild E:/Projekte/Mobile/PCMTimeApp/PCMTimeApp.dproj /t:Clean;Build /p:config=Release /p:platform=Win64
msbuild E:/Projekte/Mobile/PCMTimeApp/PCMTimeApp.dproj /p:config=Debug /p:platform=Android64 /t:Clean;Make;Deploy

echo "Kopiere Datei ins Setupverzeichnis 32-Bit"
copy /y /v E:\Projekte\Mobile\PCMTimeApp\Android\Debug\PCMTimeApp\bin\PCMTimeApp.apk "e:\Inno\Setupfiles\Programme\PCMTimeApp"
copy /y /v E:\Projekte\Mobile\PCMTimeApp\Win32\Release\PCMTimeApp.exe "e:\Inno\Setupfiles\Programme\PCMTimeApp"

echo "Kopiere Datei ins Setupverzeichnis 64-Bit"
copy /y /v E:\Projekte\Mobile\PCMTimeApp\Android64\Debug\PCMTimeApp\bin\PCMTimeApp.apk "e:\Inno\Setupfiles\Programme\PCMTimeApp_x64"
copy /y /v E:\Projekte\Mobile\PCMTimeApp\Win64\Release\PCMTimeApp.exe "e:\Inno\Setupfiles\Programme\PCMTimeApp_x64"
