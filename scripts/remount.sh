#!/system/bin/sh
##########################################################################
#
#
#
#

##########################################################################
# FUNCTIONS
##########################################################################

remount() {
	local path=${1:-/system}
	local option=${2:-rw}
	local result_code=1
	local oIFS=$IFS
	# set the internal field seperator to new line
	IFS="
"
	# read /proc/mounts line by line to get the correct device
	while read line
	do
		local mount_point=$(echo $line | cut -d' ' -f2)
		if [ "$path" == "$mount_point" ]
		then
			local device=$(echo $line | cut -d' ' -f1)
			result_code=$(mount -o remount,$option $device $mount_point)
			break
		fi
	done < /proc/mounts
	IFS=$oIFS # restore internal field seperator
	return $result_code
}

##########################################################################
# MAIN
##########################################################################

remount $@
