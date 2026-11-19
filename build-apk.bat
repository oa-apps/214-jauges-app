@echo off
REM Compile l'APK de Jauge ST214 sous Windows.
REM Prerequis : Node.js 20, JDK 17, Android Studio (SDK installe). Voir LISEZMOI.md.
setlocal
cd /d "%~dp0"

if "%JAVA_HOME%"=="" (
  echo JAVA_HOME n'est pas defini. Installez JDK 17 puis definissez JAVA_HOME. Voir LISEZMOI.md.
  pause & exit /b 1
)
if "%ANDROID_HOME%"=="" set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
if not exist "%ANDROID_HOME%" (
  echo SDK Android introuvable : %ANDROID_HOME%
  echo Installez Android Studio ou definissez ANDROID_HOME. Voir LISEZMOI.md.
  pause & exit /b 1
)

call npm install || (pause & exit /b 1)
if not exist android (
  call npx cap add android || (pause & exit /b 1)
)
call npx cap sync android || (pause & exit /b 1)

> android\local.properties echo sdk.dir=%ANDROID_HOME:\=\\%

cd android
call gradlew.bat assembleDebug || (pause & exit /b 1)
cd ..

echo.
echo APK pret : %~dp0android\app\build\outputs\apk\debug\app-debug.apk
explorer "%~dp0android\app\build\outputs\apk\debug"
pause
