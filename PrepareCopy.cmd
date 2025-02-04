echo "Kopiere Datei ins Setupverzeichnis"
copy /y /v Win32\Release\PCMTimeApp.exe "e:\Inno\Setupfiles\Programme\PCMTimeApp"
copy /y /v Win64\Release\PCMTimeApp.exe "e:\Inno\Setupfiles\Programme\PCMTimeApp_x64"
copy /y /v Android\Debug\PCMTimeApp\bin\PCMTimeApp.apk "e:\Inno\Setupfiles\Programme\PCMTimeApp"
copy /y /v Android64\Debug\PCMTimeApp\bin\PCMTimeApp.apk "e:\Inno\Setupfiles\Programme\PCMTimeApp_x64"


