# Kill any running ssh-agent for this session
[ -z "${SSH_AGENT_PID}" ] || ssh-agent -k
