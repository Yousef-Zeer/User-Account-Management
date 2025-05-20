#!/bin/bash

# ================================================
# 👤 GUI User Account Manager (Bash + Zenity)
# Creates Linux users with random passwords
# Saves user info to a CSV file
# ================================================



# to ensure that can always find and run system admin commands
export PATH=$PATH:/usr/sbin:/sbin

# Check if who runs the script ( only root user have the access )
if [[ "$UID" -ne 0 ]]; then
    zenity --error --text="❌ must run by root user"
    exit 1 
fi

CSV_FILE="users.csv"
TEMP_FILE="tmp.csv"
USER_COUNT=0


#Initialize required files
echo "Name,Username" > "$TEMP_FILE"
echo "Name,Username,Password" > "$CSV_FILE"

while true ; do
    user_data=$(zenity --forms --title="Add New User" \
    --text="Enter user details:" \
    --add-entry="Full Name" \
    --add-entry="Username")

   #cancel or close the form
   [[ $? -ne 0 ]] && break

   # extract the full name and username
   name=$(echo "$user_data" | cut -d'|' -f1)
   username=$(echo "$user_data" | cut -d'|' -f2)

   # Validate inputs
    if [[ -z "$name" || -z "$username" ]]; then
        zenity --warning --text="⚠️  Name and Username cannot be empty!"
        continue
    fi

   # Check for existing user
    if id "$username" &>/dev/null; then
        zenity --error --text="❌ Username '$username' already exists!"
        continue
    fi

   #  Generate random password
    password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)


   # Create user
    if ! /usr/sbin/useradd -m -c "$name" "$username" 2>/tmp/useradd_error.log; then
        zenity --error --text="❌ Failed to create user '$username'"
        continue
    fi


   # Set password
    echo "$username:$password" | /usr/sbin/chpasswd


   # Force password change at next login
    chage -d 0 "$username"

   # Log user info
    echo "$name,$username" >> "$TEMP_FILE"
    echo "$name,$username,$password" >> "$CSV_FILE"
    ((USER_COUNT++))


   # Ask to add another
    zenity --question --text="✅ User '$username'successfully created.\n Add another?"
    [[ $? -ne 0 ]] && break


done

# Final result ( check if there users created or not and then act )
if [[ "$USER_COUNT" -gt 0 ]]; then
    zenity --info --title="✅ Done" --text="Created $USER_COUNT user(s).\n Saved in: $CSV_FILE"

    if zenity --question  --text="Do you want to view the generated CSV file?"; then
        zenity --text-info --title="User Passwords" --filename="$CSV_FILE" --width=500 --height=300
    fi
else
    zenity --info --text="No users were added."
fi


# Clean UP
rm -f "$TEMP_FILE"
