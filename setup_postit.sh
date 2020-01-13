#! /bin/bash
mode=''
while getopts 'u' flag; do
	case "${flag}" in
		u) mode='user_mode' ;;
		*) echo "Option not recognized"
			exit 1 ;;
	esac
done
if [[ $mode != 'user_mode' ]]; then
	# select current folder as default
	target_folder=$(pwd)

	# create default folders
	# (only if they do not already exist: switch folders easily)
	if [[ ! -d "$target_folder"/notes ]]; then
		mkdir "$target_folder"/notes
	fi
	if [[ ! -d "$target_folder"/personal ]]; then
		mkdir "$target_folder"/personal
	fi

	# create universal postit command 
	cp postit.sh ~/bin/postit.sh
	sudo chmod +x ~/bin/postit.sh

	# common folder
	# initiate 
	git init
	# create gitignore 
	echo "postit.sh" >> .gitignore
	echo "setup_postit.sh" >> .gitignore
	echo "personal/*" >> .gitignore
	# first commit
	git add .gitignore
	git add *
	git commit -m "Initial commit"

	# personal folder
	cd "$target_folder"/personal
	git init
	git add *
	git commit -m "Personal: initial commmit"
	cd "$target_folder"	
else
	# get user provided folder
	read -p "Do you want to use this folder as target?(y/n)" arg1
	case "$arg1" in
		y)	
			target_folder=$(pwd) 
			;;
		n)
			read -p "Provide target_folder path:" folder_path
			target_folder=$folder_path
			;;
	esac	
	# create default folders
	# (only if they do not already exist: switch folders easily)
	
	if [[ ! -d "$target_folder"/notes ]]; then
		mkdir "$target_folder"/notes
	fi
	if [[ ! -d "$target_folder"/personal ]]; then
		mkdir "$target_folder"/personal
	fi

	read -p "Do you want to save the script in the bin folder?(y/n)" arg1
	case "$arg1" in
		y)	
			echo "y: a copy of postit.sh has been saved in ~/bin/ and made executable"
			sudo chmod +x ~/bin/postit.sh 
			;;
		n)
			echo "n: the script will be usable only from this folder." 			
			;;
	esac	
	read -p "Do you want to initiate git in the target folder?(y/n)" arg1
	case "$arg1" in
		y)	
			echo "y: initiating git in the target folder"

			# common folder
			# initiate 
			cd "$target_folder"
			git init
			# create gitignore 
			echo "postit.sh" >> .gitignore
			echo "setup_postit.sh" >> .gitignore
			echo "personal/*" >> .gitignore
			# first commit
			git add .gitignore
			git add *
			git commit -m "Initial commit"
		
			# personal folder
			cd "$target_folder"/personal
			git init
			git add *
			git commit -m "Personal: initial commmit"
			cd "$target_folder"	
			;;
		n)
			echo "n: git has not been initiated. -c flag will fail to work. (suggestion: intiate git manually)"		
			;;
	esac		
fi

# save config file with target folder
config_folder="$HOME"/.config/postit
config_file="$config_folder"/postit.config
if [[ ! -d $config_folder ]]; then
	mkdir $config_folder
fi
echo postit_target_folder="$target_folder" > "$config_file"
# get a reference to setup_file for later configuration
echo postit_setup_file="$target_folder"/setup_postit.sh >> "$config_file"  
