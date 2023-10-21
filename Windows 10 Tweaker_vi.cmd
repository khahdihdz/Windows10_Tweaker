chcp 65001 >nul
@echo off
title Windows 10 Tweaker
setlocal enabledelayedexpansion
color 3f
chcp 65001 >nul
cd /d %~dp0
cls
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%errorlevel%" NEQ "0" (
	echo: Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo: UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs" &	exit 
)
if exist "%temp%\getadmin.vbs" del /f /q "%temp%\getadmin.vbs"


:: Menu of tool.
:: /*************************************************************************************/
:Menu
cls
echo.Menu chính
echo.
echo.	ID	Tùy chọn				ID	Tùy chọn
echo.
echo.	1	Xem danh sách ứng dụng			11	Tùy chỉnh
echo.	2	Gỡ bỏ ứng dụng				12	Sao lưu drivers
echo.	3	Thêm ứng dụng				13	Dọn dẹp ổ đĩa hệ thống
echo.	4	Xem danh sách gói cài đặt ứng dụng	14	Thiết lập lại cập nhật Windows
echo.	5	Gỡ bỏ gói cài đặt ứng dụng		15	Sao lưu - Phục hồi
echo.	6	Gỡ bỏ gói tính năng hệ thống		16	Quét và sửa lỗi tập tin hệ thống
echo.	7	Bật tính năng của Windows		17	Gỡ cài đặt phần mềm
echo.	8	Tắt tính năng của Windows		18	Quản lý tài khoản người dùng
echo.	9	Bật Service				19	Thoát chương trình
echo.	10	Tắt Service				20	Khởi động máy tính
echo.	
set /p option=Chọn ID và nhấn Enter :
if %option% EQU 1 (
    goto Get-AppxPackage
) else if %option% EQU 2 (
    goto Remove-AppxPackage
) else if %option% EQU 3 (
    goto Add-AppxPackage
) else if %option% EQU 4 (
    goto Get-AppxProvisionedPackage
) else if %option% EQU 5 (
    goto Remove-AppxProvisionedPackage
) else if %option% EQU 6 (
    goto Set-Regitry
) else if %option% EQU 7 (
    goto Enable-WindowsOptionalFeature
) else if %option% EQU 8 (
    goto Disable-WindowsOptionalFeature
) else if %option% EQU 9 (
    goto Start-Service
) else if %option% EQU 10 (
    goto Stop-Service
) else if %option% EQU 11 (
    goto EnableTweaks
) else if %option% EQU 12 (
    goto BackupDrivers
) else if %option% EQU 13 (
    goto DiskCleanup
) else if %option% EQU 14 (
    goto ResetUpdate
) else if %option% EQU 15 (
    goto SystemRestore
) else if %option% EQU 16 (
    goto Repaircorruptfiles
) else if %option% EQU 17 (
    goto UninstallSoftware
) else if %option% EQU 18 (
    goto UserAccountManagement
) else if %option% EQU 19 (
    goto Exitprogram
) else if %option% EQU 20 (
    goto Restart
) else (
    goto Menu
)
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Get-AppxPackage.
:: /*************************************************************************************/
:Get-AppxPackage
cls
echo.Bạn mốn xem danh sách ứng dụng cho tài khoản hiện tại hay tất cả tài khoản?
choice /c EAM /n /m "Nhấn E cho tài khoản hiện tại, A cho tất cả tài khoản, M để quay về Menu chính: "
if %errorlevel% EQU 1 goto Currentuser
if %errorlevel% EQU 2 goto Allusers
if %errorlevel% EQU 3 goto Menu
:: --------------------------------------------------

:Currentuser
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Get-AppxPackage.ps1'"
cls
goto Menu
:: ------------------------------------------------------------------------------------

:Allusers
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Get-AppxPackageAll.ps1'"
cls
goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Remove-AppxPackage.
:: /*************************************************************************************/
:Remove-AppxPackage
cls
echo.Bạn muốn gỡ bỏ một hay tất cả ứng dụng?
choice /c EAM /n /m "Nhấn E cho mỗi ứng dụng, A cho tất cả, M để quay về Menu chính: "
if %errorlevel% EQU 1 goto Removeeachapp
if %errorlevel% EQU 2 goto Removeallapps
if %errorlevel% EQU 3 goto Menu
:: --------------------------------------------------

:Removeeachapp
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Remove-AppxPackage.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục gỡ bỏ ứng dụng? (Yes/No) "
if %errorlevel% EQU 1 goto Removeeachapp
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:Removeallapps
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Remove-AppxPackageAll.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Add-AppxPackage.
:: /*************************************************************************************/
:Add-AppxPackage
cls
echo.Bạn muốn thêm một hay tất cả ứng dụng?
choice /c EAM /n /m "Nhấn E cho mỗi ứng dụng, A cho tất cả, M để quay về Menu chính: "
if %errorlevel% EQU 1 goto Addeachapp
if %errorlevel% EQU 2 goto Addallapps
if %errorlevel% EQU 3 goto Menu
:: --------------------------------------------------

:Addeachapp
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Add-AppxPackage.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục thêm ứng dụng? (Yes/No) "
if %errorlevel% EQU 1 goto Addeachapp
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:Addallapps
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Add-AppxPackageAll.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Get-AppxProvisionedPackage.
:: /*************************************************************************************/
:Get-AppxProvisionedPackage
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Get-AppxProvisionedPackage.ps1'"
cls
goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Remove-AppxProvisionedPackage.
:: /*************************************************************************************/
:Remove-AppxProvisionedPackage
cls
echo.Bạn muốn gỡ bỏ một hay tất cả gói cài đặt ứng dụng?
choice /c EAM /n /m "Nhấn E cho mỗi gói cài đặt ứng dụng, A cho tất cả, M để quay về Menu chính: "
if %errorlevel% EQU 1 goto Removeeachpackage
if %errorlevel% EQU 2 goto Removeallpackages
if %errorlevel% EQU 3 goto Menu
:: --------------------------------------------------

:Removeeachpackage
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Remove-AppxProvisionedPackage.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục gỡ bỏ gói cài đặt ứng dụng? (Yes/No) "
if %errorlevel% EQU 1 goto Removeeachpackage
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:Removeallpackages
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Remove-AppxProvisionedPackageAll.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


::Set Regitry
:: /*************************************************************************************/
:Set-Regitry
cls
IF %PROCESSOR_ARCHITECTURE% == AMD64 (
copy data\amd64\SetACL.exe C:\Windows\System32\SetACL.exe
) ELSE (
copy data\x86\SetACL.exe C:\Windows\System32\SetACL.exe
)
set key=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages
SetACL -on "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" -ot reg -actn setowner -ownr "n:%USERDOMAIN%\%USERNAME%"
SetACL -on "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" -ot reg -actn ace -ace "n:%USERDOMAIN%\%USERNAME%;p:full"
goto Remove-Package
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Remove-Package.
:: /*************************************************************************************/
:Remove-Package
cls
echo.Gỡ bỏ gói tính năng hệ thống
echo.
echo.ID	Tùy chọn		ID	Tùy chọn
echo.
echo.1	Connect			19	Media Features					
echo.2	Cortana			20	Microsoft Message Queue (MSMQ) Server
echo.3	Get Help		21	Microsoft Print to PDF		
echo.4	Microsoft Edge		22	MultiPoint Connector		
echo.5	Mixed Reality Portal	23	Print and Document Services	
echo.6	OneDrive		24	RAS Connection Manager Adminitration Kit (CMAK)		
echo.7	Quick Assist		25	Remove Differential Compression API Support		
echo.8	Windows Defender	26	RIP Listener	
echo.9	Windows Spotlight	27	Services for NFS
echo.10	Windows Photo Viewer	28	Simple Network Management Protocol (SNMP)
echo.11	Snipping Tool		29	Simple TCPIP services (i.e. echo daytime etc)	
echo.12	Active Directory	30	SMB 1.0/CIFS File Sharing Support			
echo.13	Containers		31	Telnet-TFTP Client			
echo.14	Assigned Access		32	Windows Identify Foundation 3.5
echo.15	Device Lockdown		33	Windows Powershell 2.0	
echo.16	Hyper-V			34	Windows TIFF IFilter							
echo.17	Internet Explorer	35	XPS Services	
echo.18	Legacy Components	36	XPS Viewer
echo.
echo.37	Về Menu chính
echo.				

set /p option=Chọn ID và nhấn Enter : 
if %option% EQU 1 (
    call :Connect
) else if %option% EQU 2 (
    call :Cortana
) else if %option% EQU 3 (
    call :GetHelp
) else if %option% EQU 4 (
    goto MicrosoftEdge
) else if %option% EQU 5 (
    goto MixedRealityPortal
) else if %option% EQU 6 (
    goto OneDrive
) else if %option% EQU 7 (
    goto QuickAssist
) else if %option% EQU 8 (
    goto WindowsDefender
) else if %option% EQU 9 (
    goto WindowsSpotlight
) else if %option% EQU 10 (
    goto PhotoViewer
) else if %option% EQU 11 (
    goto SnippingTool
) else if %option% EQU 12 (
    goto ActiveDirectory
) else if %option% EQU 13 (
    goto Containers
) else if %option% EQU 14 (
    goto AssignedAccess
) else if %option% EQU 15 (
    goto DeviceLockdown
) else if %option% EQU 16 (
    goto Hyper-V
) else if %option% EQU 17 (
    goto InternetExplorer11
) else if %option% EQU 18 (
    goto LegacyComponents
) else if %option% EQU 19 (
    goto MediaFeatures
) else if %option% EQU 20 (
    goto MessageQueue
) else if %option% EQU 21 (
    goto PrinttoPDF
) else if %option% EQU 22 (
    goto MultiPointConnector
) else if %option% EQU 23 (
    goto PrintandDocument
) else if %option% EQU 24 (
    goto RASConnectionManager
) else if %option% EQU 25 (
    goto DifferentialCompressionAPI
) else if %option% EQU 26 (
    goto RIPListener
) else if %option% EQU 27 (
    goto ServicesforNFS
) else if %option% EQU 28 (
    goto SimpleNetwork
) else if %option% EQU 29 (
    goto SimpleTCPIP
) else if %option% EQU 30 (
    goto FileSharingSupport
) else if %option% EQU 31 (
    goto TelnetClient
) else if %option% EQU 32 (
    goto IdentifyFoundation
) else if %option% EQU 33 (
    goto Powershell2.0
) else if %option% EQU 34 (
    goto TIFFIFilter
) else if %option% EQU 35 (
    goto XPSServices
) else if %option% EQU 36 (
    goto XPSViewer
) else if %option% EQU 37 (
    goto Menu
) else (
    goto Remove-Package
)
:: ------------------------------------------------------------------------------------

:Connect
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-Connect
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-Connect
cls
reg query "%key%" | findstr /c:PPIProjection
if %errorlevel% EQU 0 goto removeconnect
if %errorlevel% EQU 1 goto not-found

:removeconnect
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:PPIProjection ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:PPIProjection ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
: ------------------------------------------------------------------------------------

:Cortana
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-Cortana
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-Cortana
cls
reg query "%key%" | findstr /c:Cortana
if %errorlevel% EQU 0 goto removecortana
if %errorlevel% EQU 1 goto not-found

:removecortana
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Cortana ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Cortana ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
: ------------------------------------------------------------------------------------

:GetHelp
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-ContactSupport
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-ContactSupport
cls
reg query "%key%" | findstr /c:ContactSupport
if %errorlevel% EQU 0 goto removecontactsupport
if %errorlevel% EQU 1 goto not-found

:removecontactsupport
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:ContactSupport ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:ContactSupport ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
: ------------------------------------------------------------------------------------

:MicrosoftEdge
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-MicrosoftEdge
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-MicrosoftEdge
cls
reg query "%key%" | findstr /c:Internet-Browser
if %errorlevel% EQU 0 goto removeinternetbrowser
if %errorlevel% EQU 1 goto not-found

:removeinternetbrowser
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Internet-Browser ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Internet-Browser ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
: ------------------------------------------------------------------------------------

:MixedRealityPortal
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-MixedRealityPortal
if %errorlevel% EQU 2 goto Menu
: --------------------------------------------------

:Remove-MixedRealityPortal
cls
reg query "%key%" | findstr /c:Holographic
if %errorlevel% EQU 0 goto removeholographic
if %errorlevel% EQU 1 goto not-found

:removeholographic
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Holographic ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Holographic ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
: ------------------------------------------------------------------------------------

:OneDrive
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-OneDrive
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-OneDrive
cls
cd\
dir /b /s | findstr /c:OneDriveSetup.exe
if %errorlevel% EQU 0 goto uninstall-onedrive
if %errorlevel% EQU 1 goto file-not-found

:uninstall-onedrive
IF %PROCESSOR_ARCHITECTURE% == AMD64 (
reg delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
) ELSE (
reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
)
for /f %%a in ('dir /b /s ^| findstr /c:OneDriveSetup.exe') do (
	takeown /f %%a
	icacls %%a /grant %username%:F
	start /wait %%a /uninstall
	del /s /q %%a
	goto removeonedrive
)

:removeonedrive
cls
reg query "%key%" | findstr /c:OneDrive
if %errorlevel% EQU 0 goto removeonedrivepackage
if %errorlevel% EQU 1 goto not-found

:removeonedrivepackage
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:OneDrive ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:OneDrive ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package

:file-not-found
echo.Không tìm thấy OneDriveSetup.exe
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto removeonedrive
: ------------------------------------------------------------------------------------

:QuickAssist
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-QuickAssist
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-QuickAssist
cls
reg query "%key%" | findstr /c:QuickAssist
if %errorlevel% EQU 0 goto removequickassist
if %errorlevel% EQU 1 goto not-found

:removequickassist
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:QuickAssist ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:QuickAssist ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
: ------------------------------------------------------------------------------------

:WindowsDefender
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-WindowsDefender
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-WindowsDefender
cls
reg query "%key%" | findstr /c:Defender
if %errorlevel% EQU 0 goto removedefender
if %errorlevel% EQU 1 goto not-found

:removedefender
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Defender ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Defender ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v SettingsPageVisibility /t REG_SZ /d "hide:windowsdefender" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v Enabled /t REG_DWORD /d 0 /f
takeown /f "%SystemRoot%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy"
takeown /f "%SystemRoot%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\Assets"
takeown /f "%SystemRoot%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\pris"
icacls "%SystemRoot%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy" /grant %username%:F
icacls "%SystemRoot%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\Assets" /grant %username%:F
icacls "%SystemRoot%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\pris" /grant %username%:F
rd /s /q "%SystemRoot%\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy"
cls
echo.Hoạt động được hoàn tất thành công.
echo.Hướng dẫn xóa biểu tượng Windows Defender Security Center trong Start menu.
echo Xem chi tiết tại địa chỉ https://goo.gl/8HtNsc
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
:: ------------------------------------------------------------------------------------

:WindowsSpotlight
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-WindowsSpotlight
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-WindowsSpotlight
cls
reg query "%key%" | findstr /c:ContentDeliveryManager
if %errorlevel% EQU 0 goto removecontentdeliverymanager
if %errorlevel% EQU 1 goto not-found

:removecontentdeliverymanager
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:ContentDeliveryManager ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:ContentDeliveryManager ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:PhotoViewer
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-PhotoViewer
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-PhotoViewer
cls
reg query "%key%" | findstr /c:PhotoBasicPackage
if %errorlevel% EQU 0 goto removephotobasicpackage
if %errorlevel% EQU 1 goto not-found

:removephotobasicpackage
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:PhotoBasicPackage ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:PhotoBasicPackage ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:SnippingTool
cls
choice /c YN /n /m "CẢNH BÁO: Ứng dụng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-SnippingTool
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-SnippingTool
cls
reg query "%key%" | findstr /c:SnippingTool
if %errorlevel% EQU 0 goto removesnippingtool
if %errorlevel% EQU 1 goto not-found

:removesnippingtool
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:SnippingTool ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:SnippingTool ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:ActiveDirectory
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-ActiveDirectory
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-ActiveDirectory
cls
reg query "%key%" | findstr /c:DirectoryServices
if %errorlevel% EQU 0 goto removedirectoryservices
if %errorlevel% EQU 1 goto not-found

:removedirectoryservices
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:DirectoryServices ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:DirectoryServices ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:Containers
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-Containers
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-Containers
cls
reg query "%key%" | findstr /c:Containers-Opt
if %errorlevel% EQU 0 goto removecontainersopt
if %errorlevel% EQU 1 goto not-found

:removecontainersopt
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Containers-Opt ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Containers-Opt ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:AssignedAccess
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-AssignedAccess
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-AssignedAccess
cls
reg query "%key%" | findstr /c:AssignedAccess
if %errorlevel% EQU 0 goto removeassignedaccess
if %errorlevel% EQU 1 goto not-found

:removeassignedaccess
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:AssignedAccess ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:AssignedAccess ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
:: ------------------------------------------------------------------------------------

:DeviceLockdown
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-DeviceLockdown
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-DeviceLockdown
cls
reg query "%key%" | findstr /c:Embedded
if %errorlevel% EQU 0 goto removedevicelockdown
if %errorlevel% EQU 1 goto not-found

:removedevicelockdown
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Embedded ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Embedded ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
:: ------------------------------------------------------------------------------------

:Hyper-V
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-Hyper-V
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-Hyper-V
cls
reg query "%key%" | findstr /c:HyperV
if %errorlevel% EQU 0 goto removehyperv
if %errorlevel% EQU 1 goto not-found

:removehyperv
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:HyperV ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:HyperV ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
:: ------------------------------------------------------------------------------------

:InternetExplorer11
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-InternetExplorer11
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-InternetExplorer11
cls
reg query "%key%" | findstr /c:InternetExplorer
if %errorlevel% EQU 0 goto removeinternetexplorer
if %errorlevel% EQU 1 goto not-found

:removeinternetexplorer
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:InternetExplorer ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:InternetExplorer ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:LegacyComponents
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-LegacyComponents
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-LegacyComponents
cls
reg query "%key%" | findstr /c:Legacy-Components
if %errorlevel% EQU 0 goto removelegacycomponents
if %errorlevel% EQU 1 goto not-found

:removelegacycomponents
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Legacy-Components ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Legacy-Components ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:MediaFeatures
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-MediaFeatures
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-MediaFeatures
cls
reg query "%key%" | findstr /c:MediaPlayback
if %errorlevel% EQU 0 goto removemediaplayback
if %errorlevel% EQU 1 goto not-found

:removemediaplayback
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:MediaPlayback ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:MediaPlayback ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
:: ------------------------------------------------------------------------------------

:MessageQueue
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-MessageQueue
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-MessageQueue
cls
reg query "%key%" | findstr /c:MSMQ
if %errorlevel% EQU 0 goto removemsqm
if %errorlevel% EQU 1 goto not-found

:removemsqm
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:MSMQ ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:MSMQ ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:PrinttoPDF
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-PrinttoPDF
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-PrinttoPDF
cls
reg query "%key%" | findstr /c:PrintToPDFServices
if %errorlevel% EQU 0 goto removeprinttopdfservices
if %errorlevel% EQU 1 goto not-found

:removeprinttopdfservices
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:PrintToPDFServices ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:PrintToPDFServices ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:MultiPointConnector
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-MultiPointConnector
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-MultiPointConnector
cls
reg query "%key%" | findstr /c:MultiPoint
if %errorlevel% EQU 0 goto removemultipoint
if %errorlevel% EQU 1 goto not-found

:removemultipoint
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:MultiPoint ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:MultiPoint ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:PrintandDocument
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-PrintandDocument
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-PrintandDocument
cls
reg query "%key%" | findstr /c:Printer /c:Printing
if %errorlevel% EQU 0 goto removeprinting
if %errorlevel% EQU 1 goto not-found

:removeprinting
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Printer /c:Printing ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Printer /c:Printing ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Remove-Package
:: ------------------------------------------------------------------------------------

:RASConnectionManager
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-RASConnectionManager
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-RASConnectionManager
cls
reg query "%key%" | findstr /c:RasCMAK
if %errorlevel% EQU 0 goto removerascmak
if %errorlevel% EQU 1 goto not-found

:removerascmak
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:RasCMAK ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:RasCMAK ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:DifferentialCompressionAPI
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-DifferentialCompressionAPI
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-DifferentialCompressionAPI
cls
reg query "%key%" | findstr /c:RDC
if %errorlevel% EQU 0 goto removerdc
if %errorlevel% EQU 1 goto not-found

:removerdc
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:RDC ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:RDC ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:RIPListener
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-RIPListener
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-RIPListener
cls
reg query "%key%" | findstr /c:RasRip
if %errorlevel% EQU 0 goto removerasrip
if %errorlevel% EQU 1 goto not-found

:removerasrip
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:RasRip ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:RasRip ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:ServicesforNFS
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-ServicesforNFS
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-ServicesforNFS
cls
reg query "%key%" | findstr /c:NFS-ClientSKU
if %errorlevel% EQU 0 goto removenfsclientsku
if %errorlevel% EQU 1 goto not-found

:removenfsclientsku
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:NFS-ClientSKU ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:NFS-ClientSKU ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:SimpleNetwork
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-SimpleNetwork
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-SimpleNetwork
cls
reg query "%key%" | findstr /c:SNMP
if %errorlevel% EQU 0 goto removesnmp
if %errorlevel% EQU 1 goto not-found

:removesnmp
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:SNMP ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:SNMP ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:SimpleTCPIP
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-SimpleTCPIP
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-SimpleTCPIP
cls
reg query "%key%" | findstr /c:SimpleTCP
if %errorlevel% EQU 0 goto removesimpletcp
if %errorlevel% EQU 1 goto not-found

:removesimpletcp
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:SimpleTCP ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:SimpleTCP ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:FileSharingSupport
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-FileSharingSupport
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-FileSharingSupport
cls
reg query "%key%" | findstr /c:SMB1
if %errorlevel% EQU 0 goto removesmb1
if %errorlevel% EQU 1 goto not-found

:removesmb1
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:SMB1 ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:SMB1 ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:TelnetClient
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-TelnetClient
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-TelnetClient
cls
reg query "%key%" | findstr /c:Telnet /c:TFTP
if %errorlevel% EQU 0 goto removetelnetclient
if %errorlevel% EQU 1 goto not-found

:removetelnetclient
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Telnet /c:TFTP ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Telnet /c:TFTP ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:IdentifyFoundation
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-IdentifyFoundation
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-IdentifyFoundation
cls
reg query "%key%" | findstr /c:Identity-Foundation
if %errorlevel% EQU 0 goto removeidentityfoundation
if %errorlevel% EQU 1 goto not-found

:removeidentityfoundation
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Identity-Foundation ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Identity-Foundation ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:Powershell2.0
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-Powershell2.0
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-Powershell2.0
cls
reg query "%key%" | findstr /c:PowerShell-V2
if %errorlevel% EQU 0 goto removepowershellv2
if %errorlevel% EQU 1 goto not-found

:removepowershellv2
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:PowerShell-V2 ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:PowerShell-V2 ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:TIFFIFilter
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-TIFFIFilter
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-TIFFIFilter
cls
reg query "%key%" | findstr /c:WinOcr
if %errorlevel% EQU 0 goto removewinocr
if %errorlevel% EQU 1 goto not-found

:removewinocr
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:WinOcr ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:WinOcr ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:XPSServices
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-XPSServices
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-XPSServices
cls
reg query "%key%" | findstr /c:XPSServices
if %errorlevel% EQU 0 goto removexpservices
if %errorlevel% EQU 1 goto not-found

:removexpservices
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:XPSServices ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:XPSServices ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:XPSViewer
cls
choice /c YN /n /m "CẢNH BÁO: Tính năng này không thể cài đặt lại được nếu bị gỡ bỏ. Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto Remove-XPSViewer
if %errorlevel% EQU 2 goto Remove-Package
: --------------------------------------------------

:Remove-XPSViewer
cls
reg query "%key%" | findstr /c:Xps-Foundation
if %errorlevel% EQU 0 goto removexpsfoundation
if %errorlevel% EQU 1 goto not-found

:removexpsfoundation
cls
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /c:Xps-Foundation ') do (
	reg delete "%%a\Owners" /f
	reg add "%%a" /v "Visibility" /t REG_DWORD /d 1 /f
)
for /f "tokens=4" %%a in ('dism /online /get-packages ^| findstr /c:Xps-Foundation ') do (				
	dism /online /remove-package /packagename:"%%a" /norestart
)
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------


:not-found
echo.Ứng dụng hoặc tính năng không được tìm thấy.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Remove-Package
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Enable-WindowsOptionalFeature.
:: /*************************************************************************************/
:Enable-WindowsOptionalFeature
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Enable-WindowsOptionalFeature.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục bật tính năng của Windows? (Yes/No) "
if %errorlevel% EQU 1 goto Enable-WindowsOptionalFeature
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Disable-WindowsOptionalFeature.
:: /*************************************************************************************/
:Disable-WindowsOptionalFeature
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Disable-WindowsOptionalFeature.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục tắt tính năng của Windows? (Yes/No) "
if %errorlevel% EQU 1 goto Disable-WindowsOptionalFeature
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Start-Service.
:: /*************************************************************************************/
:Start-Service
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Start-Service.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục bật service? (Yes/No) "
if %errorlevel% EQU 1 goto Start-Service
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Stop-Service.
:: /*************************************************************************************/
:Stop-Service
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Stop-Service.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục tắt service? (Yes/No) "
if %errorlevel% EQU 1 goto Stop-Service
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/

:: Enable Tweaks.
:: /*************************************************************************************/
:EnableTweaks
cls
echo.Tùy chỉnh
echo.
echo.	Tùy chọn					       Tắt   Mặc định
echo.
echo.	Cortana							1	23	
echo.	Cortana ngoài màn hình khóa				2	24	
echo.	Tìm kiếm và Cortana sử dụng vị trí			3	25	
echo.	Ứng dụng được đề xuất trong Windows Ink	 	 4	 26
echo.	Tắt Windows Ink Workspace				5	27
echo.	Tìm kiếm web						6	28
echo.	Không chỉ mẹo Windows					7	29
echo.	Tải và tự động cài đặt cập nhật	từ Windows Update	8	30
echo.	Loại bỏ trung tâm thông báo Action Center		9	31
echo.	Hiển thị hoạt họa đăng nhập đầu tiên			10	32	
echo.	Tắt Autoplay						11	33	
echo.	Tắt vị trí						12	34
echo.	Tắt OneDrive						13	35
echo.	Tắt tự động cài đặt ứng dụng được đề xuất		 14	 36		
echo.	Tắt Microsoft consumer experiences			15	37
echo.	Tắt ứng dụng tự tải và cài đặt cập nhật trong Store	16	38
echo.	Tắt ứng dụng Store 					17	39
echo.	Tắt tự động bảo trì hệ thống				18	40
echo.	Tắt Windows Defender Antivirus				19	41
echo.	Tắt bảo vệ thời gian thực				20	42
echo.	Tắt bộ lọc Windows Defender				21	43
echo.	Tắt Media Sharing					22	44
echo.	
echo.	Về Menu chính (45)
echo.

set /p option=Chọn ID và nhấn Enter : 
if %option% EQU 1 (
    goto TurnoffCortana
) else if %option% EQU 2 (
    goto TurnoffCortanaabovelockscreen
) else if %option% EQU 3 (
    goto TurnoffsearchandCortanauselocation
) else if %option% EQU 4 (
    goto TurnoffsuggestedappsinWindowsInkWorkspace
) else if %option% EQU 5 (
    goto TurnoffWindowsInkWorkspace
) else if %option% EQU 6 (
    goto Donotallowwebsearch
) else if %option% EQU 7 (
    goto DonotshowWindowstips
) else if %option% EQU 8 (
    goto TurnonNotifyfordownloadandautoinstall
) else if %option% EQU 9 (
    goto RemovesActionCenter
) else if %option% EQU 10 (
    goto Disableshowfirstsign-inanimation
) else if %option% EQU 11 (
    goto TurnoffAutoplay
) else if %option% EQU 12 (
    goto Turnofflocation
) else if %option% EQU 13 (
    goto TurnoffOneDrive
) else if %option% EQU 14 (
    goto Turnoffautoinstallsuggestapps
) else if %option% EQU 15 (
    goto TurnoffMicrosoftconsumerexperiences
) else if %option% EQU 16 (
    goto Turnoffappsdownloadandinstallupdate
) else if %option% EQU 17 (
    goto TurnofftheStoreapplication
) else if %option% EQU 18 (
    goto TurnoffAutomaticMaintenance
) else if %option% EQU 19 (
    goto TurnoffWindowsDefenderAntivirus
) else if %option% EQU 20 (
    goto TurnoffReal-timeprotection
) else if %option% EQU 21 (
    goto TurnoffWindowsDefenderSmartScreen
) else if %option% EQU 22 (
    goto TurnoffMediaSharing
) else if %option% EQU 23 (
    goto TurnonCortana
) else if %option% EQU 24 (
    goto TurnonCortanaabovelockscreen
) else if %option% EQU 25 (
    goto TurnonsearchandCortanauselocation
) else if %option% EQU 26 (
    goto TurnonsuggestedappsinWindowsInkWorkspace
) else if %option% EQU 27 (
    goto TurnonWindowsInkWorkspace
) else if %option% EQU 28 (
    goto Allowwebsearch
) else if %option% EQU 29 (
    goto ShowWindowstips
) else if %option% EQU 30 (
    goto TurnoffNotifyfordownloadandautoinstall
) else if %option% EQU 31 (
    goto TurnonActionCenter
) else if %option% EQU 32 (
    goto Enableshowfirstsign-inanimation
) else if %option% EQU 33 (
    goto TurnonAutoplay
) else if %option% EQU 34 (
    goto Turnonlocation
) else if %option% EQU 35 (
    goto TurnonOneDrive
) else if %option% EQU 36 (
    goto Turnonautoinstallsuggestapps
) else if %option% EQU 37 (
    goto TurnoffMicrosoftconsumerexperiences
) else if %option% EQU 38 (
    goto Turnonappsdownloadandinstallupdate
) else if %option% EQU 39 (
    goto TurnontheStoreapplication
) else if %option% EQU 40 (
    goto TurnonAutomaticMaintenance
) else if %option% EQU 41 (
    goto TurnonWindowsDefenderAntivirus
) else if %option% EQU 42 (
    goto TurnonReal-timeprotection
) else if %option% EQU 43 (
    goto TurnonWindowsDefenderSmartScreen
) else if %option% EQU 44 (
    goto TurnonMediaSharing
) else if %option% EQU 45 (
    goto Menu
) else (
    goto EnableTweaks
)
:: ------------------------------------------------------------------------------------

:TurnonCortana
cls
reg add "HKCU\Control Panel\International\Geo" /v "Nation" /t REG_SZ /d 244 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 2 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /f
taskkill /f /im explorer.exe
explorer.exe
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffCortana
cls
reg add "HKCU\Control Panel\International\Geo" /v "Nation" /t REG_SZ /d 251 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
taskkill /f /im explorer.exe
explorer.exe
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------


:TurnonCortanaabovelockscreen
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------


:TurnoffCortanaabovelockscreen
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonsearchandCortanauselocation
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffsearchandCortanauselocation
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonsuggestedappsinWindowsInkWorkspace
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowSuggestedAppsInWindowsInkWorkspace" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffsuggestedappsinWindowsInkWorkspace
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowSuggestedAppsInWindowsInkWorkspace" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonWindowsInkWorkspace
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowWindowsInkWorkspace" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffWindowsInkWorkspace
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v "AllowWindowsInkWorkspace" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Allowwebsearch
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Donotallowwebsearch
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:ShowWindowstips
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:DonotshowWindowstips
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonNotifyfordownloadandautoinstall
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallDay" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallTime" /t REG_DWORD /d 3 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WindowsUpdate.Notification" /v "Enabled" /t REG_DWORD /d 0 /f
takeown /f MusNotification.exe
takeown /f MusNotificationUx.exe
icacls MusNotification.exe /grant %username%:F
icacls MusNotificationUx.exe /grant %username%:F
rename MusNotification.exe MusNotification_backup.exe
rename MusNotificationUx.exe MusNotificationUx_backup.exe
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffNotifyfordownloadandautoinstall
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WindowsUpdate.Notification" /f
takeown /f MusNotification_backup.exe
takeown /f MusNotificationUx_backup.exe
icacls MusNotification_backup.exe /grant %username%:F
icacls MusNotificationUx_backup.exe /grant %username%:F
rename MusNotification_backup.exe MusNotification.exe
rename MusNotificationUx_backup.exe MusNotificationUx.exe
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonActionCenter
cls
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /f
taskkill /f /im explorer.exe
explorer.exe
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:RemovesActionCenter
cls
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f
taskkill /f /im explorer.exe
explorer.exe
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Enableshowfirstsign-inanimation
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Disableshowfirstsign-inanimation
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonAutoplay
cls
net start PlugPlay
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PlugPlay" /v "DelayedAutoStart" /t REG_DWORD /d 1 /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /f
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffAutoplay
cls
net stop PlugPlay
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PlugPlay" /v "DelayedAutoStart" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 0x00000FF /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 0x00000FF /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v Enabled /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Turnonlocation
cls
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Turnofflocation
cls
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonOneDrive
cls
reg delete "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /f
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /t REG_SZ /d ""C:\Users\%USERNAME%\AppData\Local\Microsoft\OneDrive\OneDrive.exe" /background" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffOneDrive
cls
taskkill /f /im OneDrive.exe
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Turnonautoinstallsuggestapps
cls
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonMicrosoftconsumerexperiences
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Turnoffautoinstallsuggestapps
cls
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Turnonappsdownloadandinstallupdate
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffMicrosoftconsumerexperiences
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnontheStoreapplication
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /f
reg delete "HKCU\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:Turnoffappsdownloadandinstallupdate
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnofftheStoreapplication
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonAutomaticMaintenance
cls
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffAutomaticMaintenance
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonWindowsDefenderAntivirus
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy!SecHealthUI" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t REG_EXPAND_SZ /d "%ProgramFiles%\Windows Defender\MSASCuiL.exe" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "DelayedAutoStart" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 2 /f
net start SecurityHealthService
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
echo.Sau khi Windows khởi động lại, mở Start menu click vào biểu tượng Windows Defender Security Center
echo.và truy cập đường dẫn C:\Program Files\Windows Defender chạy file MSASCuiL.exe
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto EnableTweaks
:: --------------------------------------------------

:TurnoffWindowsDefenderAntivirus
cls
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy!SecHealthUI" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "DelayedAutoStart" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /t REG_SZ /d "hide:windowsdefender" /f
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto EnableTweaks
:: --------------------------------------------------

:TurnonReal-timeprotection
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy!SecHealthUI" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffReal-timeprotection
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy!SecHealthUI" /v "Enabled" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonWindowsDefenderSmartScreen
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy!SecHealthUI" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffWindowsDefenderSmartScreen
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy!SecHealthUI" /v "Enabled" /t REG_DWORD /d 0 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnonMediaSharing
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:TurnoffMediaSharing
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v "PreventLibrarySharing" /t REG_DWORD /d 1 /f
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto EnableTweaks
:: --------------------------------------------------

:: /*************************************************************************************/


:: Backup Drivers.
:: /*************************************************************************************/
:BackupDrivers

cls
md DriversBackup
Dism /Online /Export-Driver /Destination:%~dp0\DriversBackup
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Reset Windows Update.
:: /*************************************************************************************/
:ResetUpdate

cls
set b=0

:bits
set /a b=%b%+1
if %b% equ 3 (
   goto end1
) 
net stop bits
echo Checking the bits service status.
sc query bits | findstr /I /C:"STOPPED" 
if not %errorlevel%==0 ( 
    goto bits 
) 
goto loop2

:end1
cls
echo.
echo Failed to reset Windows Update due to bits service failing to stop
echo Please run the script as administartor by right clicking the WuReset file or your BITS service isn't responding.
echo.
pause
goto Start


:loop2
set w=0

:wuauserv
set /a w=%w%+1
if %w% equ 3 (
   goto end2
) 
net stop wuauserv
echo Checking the wuauserv service status.
sc query wuauserv | findstr /I /C:"STOPPED" 
if not %errorlevel%==0 ( 
    goto wuauserv 
) 
goto loop3

:end2
cls
echo.
echo Failed to reset Windows Update due to wuauserv service failing to stop.
echo.
pause
goto Start



:loop3
set app=0

:appidsvc
set /a app=%app%+1
if %app% equ 3 (
   goto end3
) 
net stop appidsvc
echo Checking the appidsvc service status.
sc query appidsvc | findstr /I /C:"STOPPED" 
if not %errorlevel%==0 ( 
    goto appidsvc 
) 
goto loop4

:end3
cls
echo.
echo Failed to reset Windows Update due to appidsvc service failing to stop.
echo.
pause
goto Start


:loop4
set c=0

:cryptsvc
set /a c=%c%+1
if %c% equ 3 (
   goto end4
) 
net stop cryptsvc
echo Checking the cryptsvc service status.
sc query cryptsvc | findstr /I /C:"STOPPED" 
if not %errorlevel%==0 ( 
    goto cryptsvc 
) 
goto Reset

:end4
cls
echo.
echo Failed to reset Windows Update due to cryptsvc service failing to stop.
echo.
pause
goto Start

:Reset
Ipconfig /flushdns
del /s /q /f "%ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat"
del /s /q /f "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat" 

cd /d %windir%\system32

if exist "%SYSTEMROOT%\winsxs\pending.xml.bak" del /s /q /f "%SYSTEMROOT%\winsxs\pending.xml.bak" 
if exist "%SYSTEMROOT%\winsxs\pending.xml" ( 
    takeown /f "%SYSTEMROOT%\winsxs\pending.xml" 
    attrib -r -s -h /s /d "%SYSTEMROOT%\winsxs\pending.xml" 
    ren "%SYSTEMROOT%\winsxs\pending.xml" pending.xml.bak 
) 
  
if exist "%SYSTEMROOT%\SoftwareDistribution.bak" rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution.bak"
if exist "%SYSTEMROOT%\SoftwareDistribution" ( 
    attrib -r -s -h /s /d "%SYSTEMROOT%\SoftwareDistribution" 
    ren "%SYSTEMROOT%\SoftwareDistribution" SoftwareDistribution.bak 
) 
 
if exist "%SYSTEMROOT%\system32\Catroot2.bak" rmdir /s /q "%SYSTEMROOT%\system32\Catroot2.bak" 
if exist "%SYSTEMROOT%\system32\Catroot2" ( 
    attrib -r -s -h /s /d "%SYSTEMROOT%\system32\Catroot2" 
    ren "%SYSTEMROOT%\system32\Catroot2" Catroot2.bak 
) 
  
if exist "%SYSTEMROOT%\WindowsUpdate.log.bak" del /s /q /f "%SYSTEMROOT%\WindowsUpdate.log.bak" 
if exist "%SYSTEMROOT%\WindowsUpdate.log" ( 
    attrib -r -s -h /s /d "%SYSTEMROOT%\WindowsUpdate.log" 
    ren "%SYSTEMROOT%\WindowsUpdate.log" WindowsUpdate.log.bak 
) 
  
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)

regsvr32.exe /s atl.dll 
regsvr32.exe /s urlmon.dll 
regsvr32.exe /s mshtml.dll 
regsvr32.exe /s shdocvw.dll 
regsvr32.exe /s browseui.dll 
regsvr32.exe /s jscript.dll 
regsvr32.exe /s vbscript.dll 
regsvr32.exe /s scrrun.dll 
regsvr32.exe /s msxml.dll 
regsvr32.exe /s msxml3.dll 
regsvr32.exe /s msxml6.dll 
regsvr32.exe /s actxprxy.dll 
regsvr32.exe /s softpub.dll 
regsvr32.exe /s wintrust.dll 
regsvr32.exe /s dssenh.dll 
regsvr32.exe /s rsaenh.dll 
regsvr32.exe /s gpkcsp.dll 
regsvr32.exe /s sccbase.dll 
regsvr32.exe /s slbcsp.dll 
regsvr32.exe /s cryptdlg.dll 
regsvr32.exe /s oleaut32.dll 
regsvr32.exe /s ole32.dll 
regsvr32.exe /s shell32.dll 
regsvr32.exe /s initpki.dll 
regsvr32.exe /s wuapi.dll 
regsvr32.exe /s wuaueng.dll 
regsvr32.exe /s wuaueng1.dll 
regsvr32.exe /s wucltui.dll 
regsvr32.exe /s wups.dll 
regsvr32.exe /s wups2.dll 
regsvr32.exe /s wuweb.dll 
regsvr32.exe /s qmgr.dll 
regsvr32.exe /s qmgrprxy.dll 
regsvr32.exe /s wucltux.dll 
regsvr32.exe /s muweb.dll 
regsvr32.exe /s wuwebv.dll
regsvr32 /s wudriver.dll
netsh winsock reset
netsh winsock reset proxy

:Start
net start bits
net start wuauserv
net start appidsvc
net start cryptsvc
echo Task completed sucessfully!
echo Bạn hãy khởi động lại máy tính và kiểm tra lại cập nhật trong Windows Update.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 go to Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Disk Cleanup.
:: /*************************************************************************************/
:DiskCleanup

cls
DISM.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: System Restore.
:: /*************************************************************************************/
:SystemRestore

cls
echo.Sao lưu - Phục hồi
echo.
echo.	ID	Tùy chọn
echo.
echo.	1	Tạo một điểm khôi phục hệ thống
echo.	2	Phục hồi Windows nếu như bạn đã tạo một điểm khôi phục hệ thống
echo.	3	Về Menu chính
echo.
choice /c:123 /n /m "Chọn ID để tiếp tục : "

if %errorlevel% EQU 1 goto Checkpoint-Computer
if %errorlevel% EQU 2 goto Restore-Computer
if %errorlevel% EQU 3 goto Menu
:: --------------------------------------------------

:Checkpoint-Computer
cls
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Checkpoint-Computer.ps1'"
cls
echo.Hoạt động được hoàn tất thành công.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto Menu
:: --------------------------------------------------

:Restore-Computer
cls
echo.CẢNH BÁO: Máy tính cần phải được khởi động và mất một thời gian để hoàn tất
echo.quá trình phục hồi Windows.
choice /c YN /n /m "Bạn có chắc không? (Yes/No): "
if %errorlevel% EQU 1 powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Restore-Computer.ps1'"
if %errorlevel% EQU 2 goto Menu
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Scan and Repair corrupt files.
:: /*************************************************************************************/
:Repaircorruptfiles

cls
sfc /scannow
cls
echo.Hoạt động được hoàn tất thành công.
echo.Windows cần được khởi động lại để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn khởi động máy tính ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto Restart
if %errorlevel% EQU 2 goto Menu
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Uninstall Software.
:: /*************************************************************************************/
:UninstallSoftware
cls
IF %PROCESSOR_ARCHITECTURE% == AMD64 (
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Remove-InstalledSoftwaresx64.ps1'"
) ELSE (
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dp0data\scripts\Remove-InstalledSoftwaresx86.ps1'"
)
cls
echo.Hoạt động được hoàn tất thành công.
choice /c YN /n /m "Bạn có muốn tiếp tục gỡ cài đặt phần mềm? (Yes/No) "
if %errorlevel% EQU 1 goto UninstallSoftware
if %errorlevel% EQU 2 goto Menu
:: --------------------------------------------------

:: /*************************************************************************************/


::User Account Management
:: /*************************************************************************************/
:UserAccountManagement
cls
echo.Quản lý tài khoản người dùng
echo.
echo.Bạn đang đăng nhập bằng tài khoản tên: %username%
echo.
echo.ID	Tùy chọn
echo.
echo.1	Xem danh sách tài khoản người dùng
echo.2	Tạo người dùng mới
echo.3	Xóa tài khoản người dùng
echo.4	Kích hoạt tài khoản người dùng
echo.5	Vô hiệu hóa tài khoản người dùng
echo.6	Thay đổi mật khẩu
echo.7	Xóa mật khẩu
echo.8	Về Menu chính
echo.
choice /c:12345678 /n /m "Select ID for continue : "
if %errorlevel% EQU 1 goto list-user-accounts
if %errorlevel% EQU 2 goto create-a-new-user
if %errorlevel% EQU 3 goto delete-user-account
if %errorlevel% EQU 4 goto enable-user-account
if %errorlevel% EQU 5 goto disable-user-account
if %errorlevel% EQU 6 goto change-password
if %errorlevel% EQU 7 goto delete-password
if %errorlevel% EQU 8 goto Menu
:: ------------------------------------------------------------------------------------

:list-user-accounts
cls
echo.Danh sách tài khoản người dùng
echo.
wmic useraccount where domain='%computername%' get Name,Status
echo.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto UserAccountManagement
:: ------------------------------------------------------------------------------------

:create-a-new-user
cls
choice /c:YN /n /m "Bạn có chắc không? (Yes/No) "
if %errorlevel% EQU 1 goto username
if %errorlevel% EQU 2 goto UserAccountManagement

:username
cls
echo.Tạo người dùng mới
echo.
echo.Bạn không thể tạo được người dùng mới trong danh sách tài khoản người dùng đã có dưới đây:
echo.
wmic useraccount where domain='%computername%' get Name,Status
set /p usr=Điền tiên cho người dùng mới :
if [!usr!]==[] goto username
:: --------------------------------------------------

:password
set /p pwd=Điền mật khẩu cho người dùng mới (có thể bỏ trống) :
:: --------------------------------------------------

echo.
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
net user /add "%usr%" %pwd%
net localgroup administrators /add "%usr%"
goto user-account-information

:user-account-information
cls
echo.Tên của người dùng mới là: %usr%
echo.Mật khẩu của người dùng mới là: %pwd%
echo.
echo.Bạn phải đăng xuất và đăng nhập bằng tài khoản vừa tạo mới để hoàn tất hoạt động này.
choice /c YN /n /m "Bạn có muốn đăng xuất ngay bây giờ? (Yes/No) "
if %errorlevel% EQU 1 goto signout
if %errorlevel% EQU 2 goto UserAccountManagement
:: ------------------------------------------------------------------------------------

:delete-user-account
cls
echo.Xóa tài khoản người dùng
echo.
echo.Name
for /f "delims=" %%a in ('net localgroup Administrators^|more +6^|find /v "The command completed successfully."') do (
	echo.%%a
)
echo.
echo.LƯU Ý: Bạn không thể xóa những tài khoản có tên: Administrator và %username%
set /p usr1=Điền tên tài khoản muốn xóa nếu không gõ M để quay về Menu :
if [!usr1!]==[] goto enable-user-account
if [!usr1!]==[M] goto UserAccountManagement
net user "%usr1%" /del
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto UserAccountManagement
:: ------------------------------------------------------------------------------------

:enable-user-account
cls
echo.Kích hoạt tài khoản người dùng
echo.
wmic useraccount where Status='Degraded' get Name
set /p usr2=Điền tên tài khoản muốn kích hoạt nếu không gõ M để quay về Menu :
if [!usr2!]==[] goto enable-user-account
if [!usr2!]==[M] goto UserAccountManagement
net user "%usr2%" /active:yes
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto UserAccountManagement
:: ------------------------------------------------------------------------------------

:disable-user-account
cls
echo.Vô hiệu hóa tài khoản người dùng
echo.
wmic useraccount where Status='OK' get Name
echo.LƯU Ý: Bạn không được vô hiệu hóa tài khoản đang đăng nhập: %username%
set /p usr3=Điền tên tài khoản muốn vô hiệu hóa nếu không gõ M để quay về Menu :
if [!usr3!]==[] goto disable-user-account
if [!usr3!]==[M] goto UserAccountManagement
net user "%usr3%" /active:no
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto UserAccountManagement
:: ------------------------------------------------------------------------------------

:change-password
cls
echo.Thay đổi mật khẩu
echo.
wmic useraccount where Status='OK' get Name
set /p usr4=Điền tên tài khoản muốn thay đổi mật khẩu nếu không gõ M để quay về Menu :
if [!usr4!]==[] goto change-password
if [!usr4!]==[M] goto UserAccountManagement
net user "%usr4%" *
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto UserAccountManagement
:: ------------------------------------------------------------------------------------

:delete-password
cls
echo.Xóa mật khẩu
echo.
wmic useraccount where Status='OK' get Name
set /p usr5=Điền tên tài khoản muốn xóa mật khẩu nếu không gõ M để quay về Menu :
if [!usr5!]==[] goto delete-password
if [!usr5!]==[M] goto UserAccountManagement
net user "%usr5%" ""
set /p="Gõ bất kỳ phím nào để tiếp tục . . . "<nul
pause >nul
goto UserAccountManagement
:: ------------------------------------------------------------------------------------

:signout
shutdown /l
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/


:: Exit the program.
:: /*************************************************************************************/
:Exitprogram
cls
echo.Chương trình sẽ tự động tắt sau 15 giây.
echo.Cảm ơn bạn đã sử dụng chương trình.
echo.Mọi thắc mắc vui lòng liên lạc với tôi qua Facebook theo địa chỉ: fb.com/kequaduongvodanh
echo.Tạm biệt và hẹn gặp lại!
timeout /t 15 /nobreak
exit
:: ------------------------------------------------------------------------------------

:: /*************************************************************************************/

:: Restart the computer.
:: /*************************************************************************************/
:Restart
shutdown /r /f /t 00
:: --------------------------------------------------

:: /*************************************************************************************/