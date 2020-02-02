#!/bin/bash
#
# Title:      MHA-Team
# Author(s):  iDoMnCi
# URL:        https://github.com/MHA-Team/MHA-Team
# GNU:        General Public License v3.0
################################################################################

# FUNCTIONS START ##############################################################
source /opt/plexguide/menu/functions/functions.sh

queued() {
  echo
  read -p "⛔️ ERROR - $typed Already Queued! | Press [ENTER] " typed </dev/tty
  appselect
}

badinput() {
  echo ""
  echo "⛔️ ERROR - Bad Input! $typed not exist"
  echo ""
  read -p 'PRESS [ENTER] ' typed </dev/tty
}

startup() {
  rm -rf /var/plexguide/pgbox.output 1>/dev/null 2>&1
  rm -rf /var/plexguide/pgbox.buildup 1>/dev/null 2>&1
  rm -rf /var/plexguide/program.temp 1>/dev/null 2>&1
  rm -rf /var/plexguide/app.list 1>/dev/null 2>&1
  touch /var/plexguide/pgbox.output
  touch /var/plexguide/program.temp
  touch /var/plexguide/app.list
  touch /var/plexguide/pgbox.buildup

  file="/opt/coreapps/place.holder"
  waitvar=0
  while [ "$waitvar" == "0" ]; do
    sleep .5
    if [ -e "$file" ]; then waitvar=1; fi
  done
}

autoupdateall() {
  cp /var/plexguide/program.temp /var/plexguide/pgbox.output
  appselect
}

appselect() {

  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/pgbox.running
  docker ps | awk '{print $NF}' | tail -n +2 >/var/plexguide/app.list

  ### Clear out temp list
  rm -rf /var/plexguide/program.temp && touch /var/plexguide/program.temp

  ### List out installed apps
  num=0
  p="/var/plexguide/pgbox.running"
  while read p; do
    echo -n $p >>/var/plexguide/program.temp
    echo -n " " >>/var/plexguide/program.temp
    num=$((num + 1))
    if [[ "$num" == "7" ]]; then
      num=0
      echo " " >>/var/plexguide/program.temp
    fi
  done </var/plexguide/app.list

  notrun=$(cat /var/plexguide/program.temp)
  buildup=$(cat /var/plexguide/pgbox.output)

  if [ "$buildup" == "" ]; then buildup="NONE"; fi
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Multi-App Auto Updater
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📂 Potential Apps to Auto Update

$notrun

💾 Apps Queued for Auto Updating

$buildup

[A] Install

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↪️ Type App Name to Queue Auto Updating | Type ALL to select all | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "deploy" || "$typed" == "Deploy" || "$typed" == "DEPLOY" || "$typed" == "install" || "$typed" == "Install" || "$typed" == "INSTALL" || "$typed" == "a" || "$typed" == "A" ]]; then question2; fi

  if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" || "$typed" == "z" || "$typed" == "Z" ]]; then exit; fi

  current=$(cat /var/plexguide/pgbox.buildup | grep "\<$typed\>")
  if [ "$current" != "" ]; then queued && appselect; fi

  if [[ "$typed" == "all" || "$typed" == "All" || "$typed" == "ALL" ]]; then :;
  else
    current=$(cat /var/plexguide/program.temp | grep "\<$typed\>")
    if [ "$current" == "" ]; then badinput && appselect; fi;
  fi

  queueapp
}

queueapp() {
  if [[ "$typed" == "all" || "$typed" == "All" || "$typed" == "ALL" ]]; then autoupdateall ; else echo "$typed" >>/var/plexguide/pgbox.buildup; fi

  num=0

  touch /var/plexguide/pgbox.output && rm -rf /var/plexguide/pgbox.output && touch /var/plexguide/pgbox.output

  while read p; do
    echo -n $p >>/var/plexguide/pgbox.output
    echo -n " " >>/var/plexguide/pgbox.output
    num=$((num + 1))
    if [[ "$num" == 7 ]]; then
      num=0
      echo " " >>/var/plexguide/pgbox.output
    fi
  done </var/plexguide/pgbox.buildup

  sed -i "/^$typed\b/Id" /var/plexguide/app.list

  appselect
}

complete() {
  read -p '✅ Process Complete! | PRESS [ENTER] ' typed </dev/tty
  echo
  exit
}

question2() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Rebuilding Ouroboros!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  ansible-playbook /opt/plexguide/menu/functions/ouroboros.yml
  complete
}

start() {
    startup
    appselect
}

# FUNCTIONS END ##############################################################
echo "" >/tmp/output.info
start
