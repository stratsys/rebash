__rebash_echo_trace () {
    echo -e "\033[00;32m$1\033[0m";
}

__rebash_index_of () {
    local array=("${!1}") element=$2 index=0
    for item in ${array[@]}; do
        if [[ $item = $element ]]; then
            return $index
        fi
        let "index++"
    done
    
    return -1
}