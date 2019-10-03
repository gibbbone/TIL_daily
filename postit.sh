#! /bin/bash
while getopts 'zrc' flag; do
    case "${flag}" in
        z) mode='modify_it' ;;
        r) mode='read_it' ;;
        c) mode='commit_it' ;;    
        *) echo "Option: not recognized"
            exit 1 ;;
    esac
done

# define empty post
read -r -d '' POST << EOM
### Title
Tag:

Refs:
Useful characters: \`,~

---


EOM

TODAY=$(date +%Y-%m-%d)
if [ $# -eq 0 ]; then    
    # move to specific folder
    cd "$DESKTOP"/TIL_daily/notes

    # check if file exist
    if [[ ! -f  $TODAY.md ]]; then
        echo "##" $TODAY >> $TODAY.md
        echo "---" >> $TODAY.md    
        echo "$POST" >> $TODAY.md
    # else append
    else
        echo "$POST" >> $TODAY.md
    fi
    micro $TODAY.md:10000
else
    if [[ ! -f  "$DESKTOP"/TIL_daily/notes/"$TODAY".md ]]; then
        echo "Error. Cannot run with options: file does not exists."
        exit 1
    else
        case "$mode" in
            modify_it)        
                cd "$DESKTOP"/TIL_daily/notes
                micro $TODAY.md:10000
                ;;
            read_it)
                cd "$DESKTOP"/TIL_daily/notes
                cmd.exe /C start $TODAY.md
                exit 1
                ;;
            commit_it)
                echo "What do you wish to do? (provide number)"
                select yn in "Commit all changes" "Abort"; do
                    case "$yn" in
                        "Commit all changes" ) 
                            cd "$DESKTOP"/TIL_daily
                            git add *
                            git commit -m $TODAY
                            git push
                            break
                            ;;
                        "Abort" ) 
                            break
                            ;;
                    esac
                done
                exit
                ;;
        esac
    fi
fi