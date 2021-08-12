```
          __  ___ ______ ______ ______
   _____ /  |/  // ____// ____//_  __/
  / ___// /|_/ // / __ / __/    / /
 (__  )/ /  / // /_/ // /___   / /
/____//_/  /_/ \____//_____/  /_/

A smbclient/smbmap wrapper that recusively downloads files from readable SMB/Samba shares on a client
```
---
### Usage
This script has two different modes

Null Authentication
```
./smget 10.11.1.231
```

Authentication with credentials
```
./smget 10.11.1.231 kali password123
```

I was too lazy to make command line arguments work, so the following configuration options are available in the script
```
#Port to connect on
port=445

#Name of the folder to save downloads to
saveFolder="smbloot"

#If the number of files on the share is greater than or equal to this value,
#the program will give the user an option to skip downloading that share.
fileLimit=5
```

### Demo
```
(Output will be colorized if terminal supports it)
kali@kali ~/sMGET$ ./smget 10.11.1.231 kali password123
          __  ___ ______ ______ ______
   _____ /  |/  // ____// ____//_  __/
  / ___// /|_/ // / __ / __/    / /
 (__  )/ /  / // /_/ // /___   / /
/____//_/  /_/ \____//_____/  /_/

Created by jakesss
Finding readable shares on 10.11.1.231
home
docs
tmp
Counting number of files on \\10.11.1.231\home (This can take a while)
This share has ~10 files. Proceed to download? [y/n] y
Downloading...
getting file \user02\user02.txt of size 1024 as user02/user02.txt (8.0 KiloBytes/sec) (average 8.0 KiloBytes/sec)
getting file \user05\user05.txt of size 1024 as user05/user05.txt (7.9 KiloBytes/sec) (average 8.0 KiloBytes/sec)
getting file \useradm\.bashrc of size 3428 as useradm/.bashrc (26.4 KiloBytes/sec) (average 14.1 KiloBytes/sec)
getting file \useradm\.bash_logout of size 220 as useradm/.bash_logout (1.7 KiloBytes/sec) (average 11.0 KiloBytes/sec)
NT_STATUS_ACCESS_DENIED opening remote file \useradm\.bash_history
getting file \useradm\file.txt of size 10000 as useradm/file.txt (73.4 KiloBytes/sec) (average 24.1 KiloBytes/sec)
getting file \useradm\.procmailrc of size 280 as useradm/.procmailrc (2.1 KiloBytes/sec) (average 20.3 KiloBytes/sec)
getting file \useradm\.profile of size 675 as useradm/.profile (5.2 KiloBytes/sec) (average 18.2 KiloBytes/sec)
getting file \useradm\Procmail\log of size 1 as useradm/Procmail/log (0.0 KiloBytes/sec) (average 15.6 KiloBytes/sec)
NT_STATUS_ACCESS_DENIED listing \useradm\Maildir\*
getting file \useradm\scripts\cleanup.sh of size 26 as useradm/scripts/cleanup.sh (0.1 KiloBytes/sec) (average 11.7 KiloBytes/sec)
Counting number of files on \\10.11.1.231\docs (This can take a while)
This share has ~5023 files. Proceed to download? [y/n] n
Skipping download
Counting number of files on \\10.11.1.231\tmp (This can take a while)
This share has ~21 files. Proceed to download? [y/n] y
Downloading...
getting file \out.24956.txt of size 1024 as out.24956.txt (7.9 KiloBytes/sec) (average 7.9 KiloBytes/sec)
getting file \out.4727.txt of size 1024 as out.4727.txt (7.8 KiloBytes/sec) (average 7.9 KiloBytes/sec)
getting file \out.16072.txt of size 1024 as out.16072.txt (7.9 KiloBytes/sec) (average 7.9 KiloBytes/sec)
getting file \out.28120.txt of size 1024 as out.28120.txt (7.9 KiloBytes/sec) (average 7.9 KiloBytes/sec)
getting file \out.22529.txt of size 1024 as out.22529.txt (7.8 KiloBytes/sec) (average 7.9 KiloBytes/sec)
getting file \out.32470.txt of size 1024 as out.32470.txt (7.5 KiloBytes/sec) (average 7.8 KiloBytes/sec)
getting file \out.15716.txt of size 1024 as out.15716.txt (7.7 KiloBytes/sec) (average 7.8 KiloBytes/sec)
getting file \out.15654.txt of size 1024 as out.15654.txt (7.8 KiloBytes/sec) (average 7.8 KiloBytes/sec)
getting file \out.18360.txt of size 1024 as out.18360.txt (7.9 KiloBytes/sec) (average 7.8 KiloBytes/sec)
getting file \out.6934.txt of size 1024 as out.6934.txt (7.4 KiloBytes/sec) (average 7.7 KiloBytes/sec)
getting file \out.22850.txt of size 1024 as out.22850.txt (7.2 KiloBytes/sec) (average 7.7 KiloBytes/sec)
getting file \out.17664.txt of size 1024 as out.17664.txt (7.0 KiloBytes/sec) (average 7.6 KiloBytes/sec)
getting file \out.23888.txt of size 1024 as out.23888.txt (7.5 KiloBytes/sec) (average 7.6 KiloBytes/sec)
getting file \out.26396.txt of size 1024 as out.26396.txt (7.8 KiloBytes/sec) (average 7.6 KiloBytes/sec)
getting file \out.29375.txt of size 1024 as out.29375.txt (7.6 KiloBytes/sec) (average 7.6 KiloBytes/sec)
getting file \out.49.txt of size 1024 as out.49.txt (7.2 KiloBytes/sec) (average 7.6 KiloBytes/sec)
getting file \out.451.txt of size 1024 as out.451.txt (6.4 KiloBytes/sec) (average 7.5 KiloBytes/sec)
getting file \out.21940.txt of size 1024 as out.21940.txt (7.7 KiloBytes/sec) (average 7.5 KiloBytes/sec)
getting file \out.20365.txt of size 1024 as out.20365.txt (7.7 KiloBytes/sec) (average 7.5 KiloBytes/sec)
getting file \out.20560.txt of size 1024 as out.20560.txt (7.5 KiloBytes/sec) (average 7.5 KiloBytes/sec)
Script finished successfully
```

### Dependencies (Installed on Kali by default)
```
#smbclient
sudo apt update
sudo apt install smbclient

#smbmap
sudo apt install python3-pip
sudo git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket
sudo pip3 install -r /opt/impacket/requirements.txt
sudo python3 ./setup.py install
```

### Command explanations

File counting
```
1............................................................................................2...........2-1.............2-2..........................
smbclient \\\\"$ip"\\"$share" -p $port -c 'lcd '$folderPath/$share';recurse;prompt;ls' -N | awk '{if ( NF == 8 && $(NF-6) != "D" ) { print }}' | wc -l
```
1. Connect to the SMB/Samba share and recursively list all the files on the share
2. This is a very hack-y way of counting the amount of unique files on a share. One pattern that files on a share have in common are
  2-1. A total of 8 columns AND
  2-2. The second column is not "D" (A directory)

### Notes
- Piping the output of the command to /dev/null might make the script run quicker (untested)
- I put a ~ next to the amount of files being downloaded because this script doesn't account for files that cannot be downloaded (i.e lack of permissions)

Pull requests are welcome :)
