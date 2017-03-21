#!/bin/bash
# Nombre: run.sh
# Description: Initial Script that get permissions, prepare the system for the tool and launch main script (main.sh)
#############################

# Global Parameters
set -e # No errors allowed

#############################

# Check no root privileges. The command "id -u" return 0 if the user has root privileges
if [ "$(id -u)" != "0" ]; then
	$PWD/bashFiles/init/getRoot.sh # Run the script getRoot.sh to obtain root permission
fi

#############################

# Launch main script
sudo bashFiles/main.sh