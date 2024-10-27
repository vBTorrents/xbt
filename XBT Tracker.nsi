!define VERSION "0.3.0"

Name "XBT Tracker ${VERSION} for vBTorrents"
OutFile "XBT_Tracker-${VERSION}-vbt.exe"
Icon "Tracker\res\XBT Tracker.ico"
InstallDir "$PROGRAMFILES\XBT Tracker"
InstallDirRegKey HKLM "Software\XBT Tracker" "InstallDir"
XPStyle on
Page directory
Page instfiles
UninstPage uninstConfirm
UninstPage instfiles

Section "Install"
  SetShellVarContext all
  SetOutPath "$INSTDIR"

  Delete "$INSTDIR\XBT Tracker.exe"
  Delete "$INSTDIR\XBT Tracker Old.exe"
  Rename "$INSTDIR\XBT Tracker.exe" "$INSTDIR\XBT Tracker Old.exe"
  File "release\XBT Tracker.exe"
  File "release\libmariadb.dll"
  File "release\zlib1.dll"
  File "Tracker\xbt_tracker.conf.default"
  SetOverwrite off
  File /oname=xbt_tracker.conf "Tracker\xbt_tracker.conf.default"
  Exec "$INSTDIR\XBT Tracker.exe --install"
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  CreateShortcut "$SMPROGRAMS\XBT Tracker.lnk" "$INSTDIR\XBT Tracker.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\XBT Tracker" "DisplayName" "XBT Tracker ${VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\XBT Tracker" "UninstallString" '"$INSTDIR\Uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\XBT Tracker" "NoModify" 1
  WriteRegStr HKLM "Software\XBT Tracker" "InstallDir" "$INSTDIR"
SectionEnd

Section "Uninstall"
  SetShellVarContext all
  ExecWait 'net stop "XBT Tracker"'
  ExecWait "$INSTDIR\XBT Tracker.exe --uninstall"
  Delete "$SMPROGRAMS\XBT Tracker.lnk"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\XBT Tracker"
  DeleteRegKey HKLM "Software\XBT Tracker"
  RMDir /r "$INSTDIR"
SectionEnd
