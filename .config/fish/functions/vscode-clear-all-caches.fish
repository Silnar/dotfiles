# Defined in - @ line 2
function vscode-clear-all-caches
	if test -d ~/Library/Application\ Support/Code/User/workspaceStorage
        rm -r ~/Library/Application\ Support/Code/User/workspaceStorage/*
    end
end
