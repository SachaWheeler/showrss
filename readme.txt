sudo apt-get install transmission-cli transmission-common transmission-daemon

Configuration of Transmission: Ensure the Transmission daemon is running. You might need to configure the Transmission daemon to accept remote commands. Edit the settings file typically found at ~/.config/transmission-daemon/settings.json (or /etc/transmission-daemon/settings.json on some systems). Set the following values:


"rpc-enabled": true,
"rpc-bind-address": "0.0.0.0",
"rpc-whitelist-enabled": false,
"rpc-authentication-required": false

