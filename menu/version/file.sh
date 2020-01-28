#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mainstart() {
mkdir -p /opt/ptsupdate 1>/dev/null 2>&1
git clone --single-branch https://github.com/MHA-Team/PTS-Update.git /opt/ptsupdate 1>/dev/null 2>&1
chown -cR 100:1000 /opt/ptsupdate 1>/dev/null 2>&1
chmod -cR 775 /opt/ptsupdate 1>/dev/null 2>&1
apt-get install dos2unix -yqq && dos2unix /opt/ptsupdate/update.sh 1>/dev/null 2>&1
ansible-playbook /opt/plexguide/menu/alias/alias.yml 1>/dev/null 2>&1
}

endline() {
  tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PTS Now has a new update panel!
If you're seeing this all you need to do is the follwing,

1.) Read below
2.) Type, "sudo ptsupdate" once more!
3.) That's it!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Confirm Info | PRESS [ENTER] ' typed </dev/tty
}

mainstart
endline
