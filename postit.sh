#! /bin/bash
personal='False'
setup='False'
mode='default'
day='False'
t='False'
while getopts ':zrcpsd:D:' flag; do
    case "${flag}" in
        z) mode='modify_it' ;;
        r) mode='read_it' ;;
        c) mode='commit_it' ;;    
        p) personal='True' ;;
        s) setup='True' ;;
        d) day=$(($OPTARG)) ;;        
        D) t=$OPTARG
        	day='True' ;;
        :) day=2 ;;
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

# read config file
source "$HOME"/.config/postit/postit.config

if [[ $setup == 'True' ]]; then
	bash $postit_setup_file -u
	exit 1 
fi

if [[ $personal == 'True' ]]; then
	tf="$postit_target_folder/personal"
else
	tf="$postit_target_folder/notes"
fi
if [[ $day == 'False' ]]; then
	TODAY=$(date +%Y-%m-%d)
else
	if [[ $t != 'False' ]]; then
		TODAY=$(ls "$tf" | xargs -n 1 basename -s .md | grep $t | awk 'NR==1' )			
	else
		TODAY=$(ls -r "$tf" | basename -s .md $(awk -v d=$day 'NR==d' ))	
	fi
	if [[ $mode == 'default' ]]; then    	
		mode='modify_it'
	fi
fi

if [[ $mode == 'default' ]]; then    
    # move to specific folder
    cd $tf

    # check if file exist
    if [[ ! -f  $TODAY.md ]]; then
        echo "##" $TODAY >> $TODAY.md
        echo "---" >> $TODAY.md    
        echo "$POST" >> $TODAY.md
    # else append
    else
        echo "$POST" >> $TODAY.md
    fi
    # open editor on the last line
    micro $TODAY.md:10000
else
    if [[ ! -f  "$tf/$TODAY".md ]]; then
        echo "Error. Cannot run with options: file does not exists."
        exit 1
    else
        case "$mode" in
            modify_it)        
                cd "$tf" 
                micro $TODAY.md:10000
                ;;
            read_it)
            	cd "$tf"
                cmd.exe /C start $TODAY.md
                exit 1
                ;;
            commit_it)
                echo "What do you wish to do? (provide number)"
                select yn in "Commit all changes" "Abort"; do
                    case "$yn" in
                        "Commit all changes" ) 
                 	        cd "$postit_target_folder"                        
                        	if [[ $personal == 'True' ]]; then
                        		cd $tf
                        		git add *
                        		git commit -m $TODAY
                        		cd ../$tf
                        		break                        		
                        	else
                        		git ../$tf
    	                        git add *
        	                    git commit -m $TODAY
            	                git push
                	            break
                	        fi
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