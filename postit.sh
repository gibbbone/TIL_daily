#! /bin/bash
# move to specific folder
cd "$DESKTOP"/TIL_daily/notes

# define empty post
read -r -d '' POST << EOM
### Title
Tag:

Refs:
Useful characters: \`,~

---


EOM

TODAY=$(date +%Y-%m-%d)
# check if file exist
if [[ ! -f  $TODAY.md ]]; then
    echo "##" $TODAY >> $TODAY.md
    echo "---" >> $TODAY.md    
    echo "$POST" >> $TODAY.md
# else append
else
    echo "$POST" >> $TODAY.md
fi

micro $TODAY.md