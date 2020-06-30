@echo off 

:: this is the code to getAuth

@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"

::  code to add reg

@echo off
setlocal enabledelayedexpansion

for /f %%x in (target.txt)  do (
	for /f "tokens=1,2,3,4 delims=;" %%a in ('echo %%x') do (
		  REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\%%a" /d %%b
		  REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\%%a" /v "icon"  /d  %%c
		  REG ADD "HKEY_CLASSES_ROOT\Directory\Background\shell\%%a\command"  /d %%d
	)
) 

