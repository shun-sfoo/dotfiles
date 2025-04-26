#!/usr/bin/bash

LOG_CACHE="$HOME/.cache/checkupdates.log"
ERR_CACHE="$HOME/.cache/checkupdates.err"
NUM_CACHE="$HOME/.cache/checkupdates.num"

# modified time in seconds since the Epoch
update_time=$(stat -c "%Y" "$LOG_CACHE")
# seconds since the Epoch
current_time=$(date +%s)
UPDATE_FREQUENCY=3600 # in seconds, 1H

update_cache() {
  # redirect stdout to the cache file, translate newline to space
  result="$(checkupdates --nocolor)"
  if [ -n "$result" ]; then
    checkupdates --nocolor && echo "$result" | awk '{print $1}' | tr '\n' ' ' >"$LOG_CACHE" || echo "$result" >"$ERR_CACHE"
  else
    # if no updates available, overwrite cache with empty string
    echo "" >"$LOG_CACHE"
  fi
  wc -w "$LOG_CACHE" | awk '{print $1}' >"$NUM_CACHE"
}

while [ -n "$1" ]; do
  case "$1" in
  -n | --now)
    echo "update now"
    update_cache
    exit 0
    ;;
  esac
  shift
done

if [ ! -f "$LOG_CACHE" ]; then
  touch "$LOG_CACHE"
  update_cache
  exit 0
fi

# check last update time
if ((current_time - update_time > UPDATE_FREQUENCY)); then
  update_cache
else
  echo "Already updated within past $((UPDATE_FREQUENCY / 3600)) hours"
  exit 1
fi
