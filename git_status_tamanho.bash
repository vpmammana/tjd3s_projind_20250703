git status --porcelain | awk '{print $2}' | xargs -I{} du -h {} 2>/dev/null | sort  -h

