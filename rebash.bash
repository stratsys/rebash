__update_rebash () {
    rebash go
    count=$(git rev-list --count head..origin/master)
    if [[ $count -ne 0 ]]; then
        echo -e "\033[00;32mUpdating 'rebash'...\033[0m"        
        rebash update
        rebash return
        return 0 # true is zero
    else
        rebash return
        return 1 # false is one
    fi
}

ORIGINAL_IFS=$IFS
IFS=$(echo -en "\n\b")
 
source ~/.rebash/rebash.command.bash

__update_rebash
 
for script_file_type in "config" "lib" "aliases" "functions"; do
    if [ ! -d ~/.rebash/${script_file_type} ]; then
		continue;
    fi

    for script_file in ~/.rebash/${script_file_type}/*.bash; do
        source $script_file
    done
done

if [ -d ~/.rebash/scripts ]; then
    for dir in ~/.rebash/scripts/*; do
        for script_file in ${dir}/*.bash; do
            script=${script_file##*/}
            target="/usr/bin/${script/.bash/}"
            
            if [ -e $target ]; then
                rm $target
            fi
            
            ln -s $script_file $target
        done
    done
fi

if [[ -e ~/.bash_profile_custom ]]; then
    source ~/.bash_profile_custom
fi

IFS=$ORIGINAL_IFS