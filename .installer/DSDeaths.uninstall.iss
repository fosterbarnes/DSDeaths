[Code]
var
  RemoveLogsAndSettings: Boolean;

function InitializeUninstall(): Boolean;
var
  AppDir: String;
begin
  RemoveLogsAndSettings := False;
  AppDir := ExpandConstant('{app}');

  if FileExists(AppDir + '\DSDeaths.txt') and not UninstallSilent() then
    RemoveLogsAndSettings := MsgBox(
      'Do you also want to remove your death logs (DSDeaths.txt) and all settings stored in:' + #13#10 + #13#10 +
      AppDir + #13#10 + #13#10 +
      'This cannot be undone.',
      mbConfirmation, MB_YESNO) = IDYES;

  Result := True;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  AppDir: String;
begin
  if (CurUninstallStep = usPostUninstall) and RemoveLogsAndSettings then
  begin
    AppDir := ExpandConstant('{app}');
    if DirExists(AppDir) then
      DelTree(AppDir, True, True, True);
  end;
end;
