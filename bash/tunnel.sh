#!/bin/bash
#-------------------SET EVERYTHING BELOW-------------------
# whatever you type after ssh to connect to SOURCE/TARGE host 
# (e.g. 1.2.3.4:22, user@host:22000, ssh_config_alias, etc)
# So if you use "ssh foo" to connect to SOURCE then 
# you must set SOURCE_HOST=foo

template="
SOURCE_HOST=jo@UMR-BACCI-WF006 \\n
TARGET_HOST=admin@10.100.233.33 &&

SOURCE_PASSWORD=... &&
TARGET_PASSWORD=... &&

# The IP address or hostname and ssh port of TARGET AS SEEN FROM LOCALHOST
# So if ssh -p 5678 someuser@1.2.3.4 will connect you to TARGET then
# you must set TARGET_ADDR_PORT=1.2.3.4:5678 and
# you must set TARGET_USER=someuser
TARGET_ADDR_PORT=10.100.233.33:22
TARGET_USER=admin

SOURCE_PATH=/mnt/f/imaging_suite2p/* # Path to rsync FROM
TARGET_PATH=/volume1/Yann/CB1/data-Joana/2023  # Path to rsync TO

RSYNC_OPTS=\"--exclude *.bin -avhP --bwlimit=14M --progress\" # rsync options
FREE_PORT=54321 # just a free TCP port on localhost
"

echo $template

transfer_via_tunnel() {

    #---------------------------------------------------------

    echo -n "Test: ssh to $TARGET_HOST: "
    sshpass -p $TARGET_PASSWORD ssh $TARGET_HOST echo PASSED| grep PASSED || exit 2

    echo -n "Test: ssh to $SOURCE_HOST: "
    sshpass -p $SOURCE_PASSWORD ssh $SOURCE_HOST echo PASSED| grep PASSED || exit 3

    echo -n "Verifying path in $SOURCE_HOST "
    sshpass -p $SOURCE_PASSWORD ssh $SOURCE_HOST stat $SOURCE_PATH | grep "File:" || exit 5

    echo -n "Verifying path in $TARGET_HOST "
    sshpass -p $TARGET_PASSWORD ssh $TARGET_HOST stat $TARGET_PATH | grep "File:" || exit 5

    echo "configuring ssh from $SOURCE_HOST to $TARGET_HOST via locahost"
    sshpass -p $SOURCE_PASSWORD ssh $SOURCE_HOST "echo \"Host tmpsshrs; ControlMaster auto; ControlPath /tmp/%u_%r@%h:%p; hostname localhost; port $FREE_PORT; user $TARGET_USER\" | tr ';' '\n'  > /tmp/tmpsshrs"

    # The ssh options that will setup the tunnel
    TUNNEL="-R localhost:$FREE_PORT:$TARGET_ADDR_PORT"

    echo 
    echo -n "Test: ssh to $SOURCE_HOST then to $TARGET_HOST: "
    if ! sshpass -p $SOURCE_PASSWORD ssh -A $TUNNEL $SOURCE_HOST "ssh -A -F /tmp/tmpsshrs tmpsshrs echo PASSED" | grep PASSED ; then
            echo
            echo "Direct authentication failed, will use plan #B:"
            echo "Please open another terminal, execute the following command"
            echo "and leave the session running until rsync finishes"
            echo "(if you're asked for password use the one for $TARGET_USER@$TARGET_HOST)"
            echo "   sshpass -p $SOURCE_PASSWORD ssh -t -A $TUNNEL $SOURCE_HOST ssh -F /tmp/tmpsshrs tmpsshrs"
            read -p "Press [Enter] when done..."
    fi

    echo "Starting rsync"
    sshpass -p $SOURCE_PASSWORD ssh -A $TUNNEL $SOURCE_HOST "rsync -avhP --exclude *.bin -e 'ssh -F /tmp/tmpsshrs' $RSYNC_OPTS $SOURCE_PATH tmpsshrs:$TARGET_PATH"

    echo
    echo "Cleaning up"
    sshpass -p $SOURCE_PASSWORD ssh $SOURCE_HOST "rm /tmp/tmpsshrs"

}
