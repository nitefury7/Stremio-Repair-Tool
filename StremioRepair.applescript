set appPath to "/Applications/Stremio.app"

-- Check if Stremio exists
set stremioExists to do shell script "if [ -d \"" & appPath & "\" ]; then echo 1; else echo 0; fi"

if stremioExists is "0" then
	display dialog "Stremio.app not found in Applications folder. Please install it first and do NOT open it before running this repair." buttons {"OK"} default button "OK" with icon stop
	return
end if

-- Confirmation dialog
set dlgText to "This tool will repair Stremio launch issues by:" & return & "- Removing quarantine attributes" & return & "- Cleaning hidden metadata files" & return & "- Re-signing the application" & return & return & "Administrator permission will be required."
set userChoice to display dialog dlgText buttons {"Cancel", "Repair"} default button "Repair" with icon note

if button returned of userChoice is "Cancel" then return

display dialog "Repairing Stremio" buttons {} giving up after 1

-- Run the fix commands with admin privileges
try
	do shell script "
xattr -cr /Applications/Stremio.app
find /Applications/Stremio.app -name '._*' -delete
find /Applications/Stremio.app -name '.DS_Store' -delete
codesign --force --deep --sign - /Applications/Stremio.app
" with administrator privileges
	
	display dialog "Stremio has been fixed! You can now open it normally." buttons {"OK"} default button "OK" with icon note
on error errMsg
	display dialog "Repair failed:" & return & errMsg buttons {"OK"} default button "OK" with icon stop
end try