0 * * * * rsync -auv "$(ls -1t "$HOME/.local/share/Anki2/User 1/backups" |head -n 1)" "$HOME/Dropbox/bkp/rsr/anki.apkg"
