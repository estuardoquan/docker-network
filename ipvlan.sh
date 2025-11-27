#!/bin/sh

usage() {
	printf "%s\n" \
		"Usage: ipvlan [COMMAND] [OPTIONS]" \
		"available commands: network, service" \
		"for more information ipvlan [COMMAND] -h|--help"
}

usage_network() {
	printf "%s\n" \
		"Usage: ipvlan network [OPTIONS] ADDR INT" \
		"Print (or temporarily create) IPVLAN L2 Link" "$(print_network ADDR/MASK DEV INT)" \
		"" \
		"Options:"

	printf "  %s\n" \
		"-d | --dev    Change the DEV name (Default: ipvlan0)" \
		"-m | --mask   Change the subnet MASK (Default: 24)" \
		"-r | --run    Temporarily create/run (Default: 0)"
}

usage_service() {
	printf "%s\n" \
		"Usage: ipvlan service NAME BIN" \
		"Print SYSTEMD Service Stub"
}

error_msg() {
	local funcname=${1:?$(error_msg ${FUNCNAME} "Missing parameter 'funcname'")}
	local msg=${2:?$(error_msg ${FUNCNAME} "Missing parameter 'msg'")}

	printf "[%s] Error: %s\n" "${funcname}" "${msg}"

	return 0
}

print_network() {
	local error=0

	if [ -z "${1}" ]; then
		error=1
		error_msg ${FUNCNAME} "Missing parameter 'addr'"
	fi

	if [ -z "${2}" ]; then
		error=1
		error_msg ${FUNCNAME} "Missing parameter 'dev'"
	fi

	if [ -z "${3}" ]; then
		error=1
		error_msg ${FUNCNAME} "Missing parameter 'int'"
	fi

	if [ ${error} == 1 ]; then
		printf "\n"
		return 1
	fi

	local addr=${1}
	local dev=${2}
	local int=${3}

	printf "%s\n" \
		"ip link add ${dev} link ${int} type ipvlan mode l2" \
		"ip addr add ${addr} dev ${dev}" \
		"ip link set ${dev} up"

	return 0
}

print_service() {

	if [[ "${1}" == '-h' || "${1}" == "--help" ]]; then
		return 1
	fi

	local error=0

	if [ -z "${1}" ]; then
		error=1
		error_msg ${FUNCNAME} "Missing parameter 'name'"
	fi

	if [ -z "${2}" ]; then
		error=1
		error_msg ${FUNCNAME} "Missing parameter 'bin'"
	fi

	if [ ${error} == 1 ]; then
		printf "\n"
		return 1
	fi

	local name=${1}
	local bin=${2}

	printf "%s\n" \
		"[Unit]" \
		"Description=Setup ${name}" \
		"After=network-online.target" \
		"Wants=network-online.target" \
		"" \
		"[Service]" \
		"Type=oneshot" \
		"ExecStart=${bin}" \
		"RemainAfterExit=yes" \
		"" \
		"[Install]" \
		"WantedBy=multi-user.target"

	return 0
}

make_network() {
	local opt="d:m:hr"
	local long="dev:,mask:,help,run"

	local o=$(getopt -o "${opt}" --long "${long}" -- "${@}")

	if [ $? != 0 ]; then
		error_msg ${FUNCNAME} "Unable to parse options"

		return 1
	fi

	set -- ${o}

	local dev=ipvlan0
	local mask=24
	local out=1

	while true; do
		case "${1}" in
		-d | --dev)
			dev="$2"
			shift 2
			;;
		-m | --mask)
			mask="$2"
			shift 2
			;;
		-r | --run)
			out=0
			shift 1
			;;
		--)
			shift 1
			break
			;;
		*)
			return 1
			;;
		esac
	done

	local error=0

	if [ -z "${1}" ]; then
		error=1
		error_msg ${FUNCNAME} "Missing parameter 'addr'"
	fi

	if [ -z "${2}" ]; then
		error=1
		error_msg ${FUNCNAME} "Missing parameter 'int'"
	fi

	if [ ${error} == 1 ]; then
		printf "\n"
		return 1
	fi

	local addr=$1
	local int=$2

	set -- ${addr}/${mask} ${dev} ${int}

	if [[ "${out}" == "0" ]]; then
		sh -c "$(print_network ${@})"

		if [ $? != 0 ]; then
			return 1
		fi
	else
		print_network "${addr}/${mask}" "${dev}" "${int}"
	fi

	return 0

}

check() {
	if [ -z "${1}" ]; then
		error_msg ${FUNCNAME} "Missing parameter 'name'"

		return 1
	fi

	local name=${1}

	if [[ -f "/etc/systemd/system/${name}.service" || -f "/bin/${name}" ]]; then
		return 1
	fi

	return 0
}

if [[ "${1}" == "check" ]]; then
	shift 1

	check ${@}

	if [ $? != 0 ]; then
		exit 1
	fi
fi

if [[ "${1}" == "network" ]]; then
	shift 1

	make_network ${@}

	if [ $? != 0 ]; then
		usage_network
		exit 1
	fi

	exit 0
fi

if [[ "${1}" == "service" ]]; then
	shift 1

	print_service ${@}

	if [ $? != 0 ]; then
		usage_service
		exit 1
	fi

	exit 0
fi

usage
