#!/bin/sh

PREFIX="%PREFIX%"
PRESETS_FILE="$PREFIX/share/outernet/presets"
PRESETS_URL="https://raw.githubusercontent.com/Outernet-Project/outernet-linux-lband/master/profiles.sh"

. "$PRESETS_FILE"

usage() {
  cat <<EOF
Usage: 
  $0 PROFILE
  $0 update

parameters:

  PROFILE   name of the tuner profile
  update    fetch the latest profiles

supported profiles:

  americas  North and South Americas
  eurasia   Europe, Africa, Middle East
  apac      Asia, Pacific
EOF
exit 0
}

updateprofiles() {
  printf "Fetching the profiles... "
  if wget "$PRESETS_URL" -O "$PRESETS_FILE" >/dev/null 2>/dev/null; then
    echo "OK"
  else
    echo "FAIL"
  fi
}

rundemod() {
  demod $ARGS
}

if [ "$USER" != root ]; then
  echo "This command must be run as root"
  exit 1
fi

[ -z "$1" ] && usage

case "$1" in
  americas)
    ARGS="$AMERICAS"
    rundemod
    ;;
  euraf)
    ARGS="$EURAF"
    rundemod
    ;;
  apac)
    ARGS="$APAC"
    rundemod
    ;;
  update)
    updateprofiles
    ;;
  *)
    echo "ERROR: Unknown profile"
    usage
esac