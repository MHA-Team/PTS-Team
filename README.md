
_**Table of Contents**_

1. [Install](#1-install)
2. [Project Statement](#2-project-statement)
3. [Functional Use](#3-functional-use)
4. [Testimonials](#4-testimonials)
5. [Recommended Reading](#5-recommended-reading)
6. [Having Issues?](#6-having-issues)


----

# 1. Install

## (i) Backup your current server using PTS Vault before installing PTS-Team.   

Your PTS backup can be used to restore your applications in PTS fork after install (see later)  
**NOTE**  Tested and working for PG v8.5-8.7

Type the following to access your current build's menu: `sudo pgblitz`    
Select  `[7] PG vault [Backup & Restore]`  then  
Select  `[1] Utilize PG Vault`  then  
Select  `[1] Data Backup`

At this stage you can either type `all` (to backup all apps) OR `appname` (to queue/stack apps which you would like to backup) followed by typing `A`.  


**IMPORTANT**
If you have an encrypted drive and have forgotten, not documented or not backed up your SALT/password for PG Clone, you should at this stage also backup your keys/rclone.config to gdrive. This can be done by the following:  

Type or paste the following to backup your keys:
```
sudo wget -N https://raw.githubusercontent.com/MHA-Team/PTS-Clone/final/functions/backup-keys.sh

```  


## (ii) Installing PTS

**NOTE**
The ideal method of installing the PTS fork is to delete your current build and install PTS fork on a clean system.
PTS fork works best on **ubuntu 18.XX** and this tutorial will assume you are using ubuntu 18.XX.
If you are unsure on how to do this, please refer to the documentation provided by your server provider.  

Once your server has an OS installed, login to your server using SSH.  

Type or paste the following to install PTS fork:  

```
sudo apt-get update -yqq
sudo apt-get upgrade -yqq
sudo apt-get autoclean -yqq
sudo apt-get install wget -y
sudo wget -qO- https://raw.githubusercontent.com/MHA-Team/Install/master/install.sh | sudo bash

```

The installation will then take you through the setup which is self-explanatory.  


### Alternative method of installing PTS fork (without removing your current build)

**NOTE** This has currently only been tested with PG v8.5-8.7  

Type or paste the following:

```
sudo apt-get update -yqq
sudo apt-get upgrade -yqq
sudo apt-get autoclean -yqq
sudo apt-get install wget -y
sudo wget -qO- https://raw.githubusercontent.com/MHA-Team/Install/master/install.sh | sudo bash

```    
### Optional - updating your PTS-Team fork to the new MHA-Team fork
IDoMnCi came up with a great script to change all the links on an existing PTS-Team fork (NOT PG 8.x) to the MHA-Team fork.
Details - https://github.com/MHA-Team/Install/pull/4
```
sudo wget -qO- https://raw.githubusercontent.com/MHA-Team/Install/master/relocate.sh | sudo bash

sudo ptsupdate

```

## Configuring PTS

Configuring PTS fork is the same as configuring PG / PlexGuide.

Then type the following to run the PTS menu: `sudo pts`

* Set up and deploy Traefik ([see here](https://github.com/MHA-Team/PTS-Team/wiki/Traefik))   

* Close ports using Port Guard ([see here](https://github.com/MHA-Team/PTS-Team/wiki/PTS-Port-Guard))  

* Deploy PTS Shield (GOAuth - all apps supported) [see here](https://github.com/MHA-Team/PTS-Team/wiki/PTS-Shield)

* Set up and deploy PTS-Clone. You can restore you backup keys at this stage. [see here](https://github.com/MHA-Team/PTS-Team/wiki/PTS-Clone)

* (Optional) Restore PTS backup (created in step 1) using PTS-Vault. [see here](https://github.com/MHA-Team/PTS-Team/wiki/PTS-Vault---Data-Storage)

* Install desired core/community applications (Do this regardless of whether it is a fresh install with restore or overwrite)  [see here](https://github.com/MHA-Team/PTS-Team/wiki/core-apps)

* (Optional) If overwriting/restoring, you will need to change 2 remote path mappings in applications (NZB clients / Torrent clients / radarr / sonarr / lidarr etc)    [see here](https://github.com/MHA-Team/PTS-Team/wiki/Remote-Path-Mappings)


**Why do I need to change remote paths?**  
PTS will create one download folder for completed downloads using any NZB client `/mnt/downloads/nzb` and one download folder for completed downloads using any torrent client `/mnt/downloads/torrent`. Both folder names are different to those used in previous versions of PTS. This remote paths need to be changed in your configuration settings (nzbget/radarr/sonarr etc) which you can do in either in terminal or webUI.  

**NOTE**  PTS fork does **not** install PGUI by default.   

# 2. Project Statement

PTS  is a **fork** of PG / Plexguide, an all-in-one media solution that deploys a Media Server through the use of either your local HDD or Google Drive; serving as unlimited back-end storage. PTS utilizes Ansible and Docker to streamline your Media Server while deploying multiple tools for your server operations.

# 3. Functional Use

1. Deploys multiple programs/apps and functional within 10 - 30 seconds
1. Deploy PTS on a remote machine, local machine, VPS, or virtual machines
1. Deploy PTS utilizing Google's GSuite for unlimited space or through the solo or multiple HD editions
1. Deploys a Reverse Proxy (Traefik) so you can obtain https:// certificates on all your containers
1. Backup and Restore data through your Google Drive
1. Aligns data and ports for efficiency
1. Deploys with a simple installer and a GUI like interface (commands do not have to be typed out)

# 4. Testimonials

.....


# 5. Recommended Reading

[**[Click Here]**](https://github.com/MHA-Team/PTS-Team/wiki/Pre-Reading) to view the list!

## 6. Having Issues?

[**[Click Here]**](https://github.com/MHA-Team/PTS-Team/wiki/Common-Issues) for more information!
