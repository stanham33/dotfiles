#!/bin/bash
REQUIRED_TOOLS="xclip rofi dmenu bw"

MODE="password"
EMAIL="emile.hammer@gmail.com"
SESSION=""

usage() {
    echo "USAGE: "
    echo ""
    echo "$0 EMAILADDRESS [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "     -t --timeout <HOURS>"
    echo "        Sets lastpass client session duration. Default value is 1 hour"
    echo "     -m --mode    <MODE>"
    echo "        Sets the copy mode [username, password, url, notes] (Defaults to password)."
}

# Check for required tools
for TOOL in $REQUIRED_TOOLS; do
    if ! [ -x "$(command -v "$TOOL")" ]; then
        echo "Tool not found: '$TOOL'"
        exit 1
    fi
done

while [ "$1" != "" ]; do
case $1 in
        -h|--help )    shift
                       usage; exit 0
                       ;;
        -t|--timeout ) shift
                       TIMEOUT=$1
                       ;;
        -m|--mode)     shift
                       MODE=$1
                       ;;
        * )            EMAIL=$1
    esac
    shift
done

# if [ -z "$EMAIL" ]; then
#     echo "Mandatory argument missing"
#     echo ""
#     usage
#     exit 1
# fi

# if [ -n "$TIMEOUT" ]; then
#     (( timeout_in_seconds=TIMEOUT * 60 * 60 ))
#     export LPASS_AGENT_TIMEOUT=$timeout_in_seconds
#     echo $timeout_in_seconds 
# fi

# if [ -z "$MODE" ]; then
#     MODE="password"
# else
#     if [ $MODE != 'password' ] && [ $MODE != 'username' ] && [ $MODE != 'url' ] && [ $MODE != 'notes' ]; then
#         echo "Mode parameter is not correct"
#         echo ""
#         usage
#         exit 1
#     fi
# fi
actions=(
    -kb-custom-1 "u"
)

msg="<b>Enter</b>: copy password | <b>u</b>: copy username"

if [ -f "/tmp/bwsession" ];then
    SESSION=$(cat /tmp/bwsession)
fi

status="$(bw --session $SESSION status | jq -r '.status')"
echo $status > /tmp/status

if [ "$status" = "unauthenticated" ]; then
    master_pass=$(rofi -dmenu -password -i -p "Enter Master Password to Login" "$@")
    SESSION=$(bw login $EMAIL $master_pass --raw)
    echo $session_key > /tmp/bwsession
elif [ "$status" = "locked" ] || [ "$status" = "" ]; then
    master_pass=$(rofi -dmenu -password -i -p "Enter Master Password to Unlock" "$@")
    SESSION=$(bw unlock $master_pass --raw)
    echo $SESSION > /tmp/bwsession
    bw --session $SESSION sync
fi

line=$(bw --session $SESSION list items | jq -r '.[] | (.name + " (" + .login.username+")"+" ["+.id+"]")' | rofi -dmenu -i -p "Select the $MODE to copy" "$@" "${actions[@]}" -mesg "$msg")

if [ $? -eq 10 ];then
    MODE="username"
fi

if [ -n "$line" ]; then
    item_id=$(echo "$line" | cut -d ' ' -f 3 | grep -Po '[0-9a-f-]+')
    bw --session $SESSION get $MODE $item_id | xclip -sel c
fi
