#!/bin/sh

hermes_pid_file="tmp/hermes.pid"

run() {
  if [ -f $hermes_pid_file ]
  then
    echo "Hermes is already running"
    exit 1
  else
    export RAILS_ENV=production
    SECRET_KEY_BASE=$(cat .secret_key_base)
    export SECRET_KEY_BASE

    if ! [ $HERMES_PORT ]
    then
      export HERMES_PORT=3000
    fi

    rails s --binding 0.0.0.0 -p $HERMES_PORT -P $hermes_pid_file -d
    sleep 2

    if [ -f $hermes_pid_file ]
    then
      echo "Hermes is now running on port $HERMES_PORT"
    else
      echo "ERROR: Hermes could not start, see log/production.log for more informations"
      exit 1
    fi
  fi
}

stop() {
  if [ -f $hermes_pid_file ]
  then
    kill "$(cat $hermes_pid_file)"
    rm $hermes_pid_file
    echo "Hermes stopped"
  else
    echo "No instances of Hermes were found"
    exit 1
  fi
}

print_usage() {
  echo "${0##/*} --run:\t\tRun Hermes"
  echo "${0##/*} --stop:\tStop Hermes"
  echo "${0##/*} --restart:\tRestart Hermes"
}

case "$1" in
  --run) run;;
  --stop) stop;;
  --restart) stop; sleep 2; run;;
  *) print_usage; exit 1;;
esac

exit 0
