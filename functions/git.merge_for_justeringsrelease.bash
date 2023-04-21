merge_for_justeringsrelease() {
    echo -e 'Vill du merga in \033[1;35mdev/test\033[0m till \033[1;36m7.6/master\033[0m för att släppa justeringsrelease?'
    read -p '(ja/nej): ' confirmed
    if [ $confirmed = 'ja' ]
    then
        echo Påbörjar merge...
        gtestto76
    else
        echo Avbryter. Ingen merge gjord.
    fi
}
