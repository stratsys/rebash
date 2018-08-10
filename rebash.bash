ORIGINAL_IFS=$IFS
IFS=$(echo -en "\n\b")
 
source ~/.rebash/rebash.command.bash
 
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

env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

IFS=$ORIGINAL_IFS