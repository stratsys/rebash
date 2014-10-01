remote_iis () {
    if [[ -z $1 ]]; then
        echo "Usage: remote_iis add <port> <site>"
        echo "       remote_iis remove <port> <site>"
    else
        # get IP address of the current computer.
        local ip=$(ipconfig | grep "IPv4" | head -1 | awk '{print $NF}')
        local port=$2 site=$3
    
        case $1 in
            add)
                echo -e "\033[00;32mAdding URL reservation for '$ip:$port'.\033[0m"
                netsh http add urlacl url=http://$ip:$port/ user=everyone
                
                echo -e "\033[00;32mOpening firewall on port $port.\033[0m"
                netsh advfirewall firewall add rule name="stratsys.comparison.service" dir=in action=allow protocol=tcp localport=$port
                
                echo -e "\033[00;32mAdding binding for $site in applicationhost.config.\033[0m"
                "C:\Program Files (x86)\IIS Express\appcmd.exe" set site /site.name:$site "/+bindings.[protocol='http',bindinginformation='*:$port:$ip']"
                ;;
            remove)
                echo -e "\033[00;32mRemoving URL reservation for '$ip:$port'.\033[0m"
                netsh http delete urlacl url=http://$ip:$port/

                echo -e "\033[00;32mClosing firewall on port $port.\033[0m"
                netsh advfirewall firewall delete rule name="Stratsys.Comparison.Service" protocol=TCP localport=$port

                echo -e "\033[00;32mRemoving binding for $site in applicationhost.config.\033[0m"
                "C:\Program Files (x86)\IIS Express\appcmd.exe" set site /site.name:$site "/-bindings.[protocol='http',bindingInformation='*:$port:$ip']"
                ;;
            *)
                echo "Unknown command."                
        esac      
    
    fi    
}