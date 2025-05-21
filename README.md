# User Account Management Script

Introduction
-----------
 User Account Management Script is a Bash-based automation script designed to streamline the creation of Linux user accounts through a user-friendly GUI powered by Zenity. It enables system administrators to efficiently add users, generate secure passwords, and export account credentials to a CSV file . 

 <p align="center">
  <img src="https://github.com/user-attachments/assets/f47f5e3a-7ac8-4bc1-bffd-17d02ea82b67" alt="Project Screenshot" width="600"/>
</p>

Installation
--------

🛠️ Requirements:

  - Ubuntu/Debian/or any Linux distro .
  - Zenity (tool that allows you to create (GUI) dialog boxes from shell scripts) recommend to read [Documentation](https://docs.oracle.com/cd/E88353_01/html/E37839/zenity-1.html?utm_source=chatgpt.com)


Installing in (Ubuntu/Debian) :

```
$ sudo apt update
$ sudo apt install zenity

```

##  How to Run

```
$ chmod +x user-manager.sh
$ sudo ./user_manager.sh

```

## Output
  - users.csv: Stores name, username, and generated random password.
  - Temporary CSV used during runtime is deleted after execution .



![Image](https://github.com/user-attachments/assets/93b2bfa3-5dbf-42fc-8a06-251b4d341ac6)











