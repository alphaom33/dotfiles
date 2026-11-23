local last_session
last_session=$(zellij list-sessions -s | grep -v "EXITED" | tail -n 1)

if [ -n "$last_session" ]; then
zellij attach "$last_session"
else
zellij
fi
