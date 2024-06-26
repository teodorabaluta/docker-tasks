#!/bin/bash

# Check if the file name is "passwd"
if [ "$(basename $1)" != "passwd" ]; then
    echo "Error: The file is not 'passwd'."
    exit 1
fi

# 1. Print the home directory
echo "Home directory:"
echo $HOME
echo

# 2. List all usernames from the passwd file
echo "List of usernames from passwd file:"
cut -d: -f1 $1
echo

# 3. Count the number of users
echo "Number of users:"
cat $1 | wc -l
echo

# 4. Find the home directory of a specific user (prompt to enter the username value)
read -p "Enter username to find home directory: " username
home_directory=$(grep "^$username:" $1 | cut -d: -f6)
echo "Home directory of $username: $home_directory"
echo

# 5. List users with specific UID range (e.g. 1000-1010)
echo "List of users with UID range 1000-1010:"
awk -F: '$3 >= 1000 && $3 <= 1010 { print $1 }' $1
echo

# 6. Find users with standard shells like /bin/bash or /bin/sh
echo "Users with standard shells (/bin/bash or /bin/sh):"
grep -E "/bin/(bash|sh)" $1 | cut -d: -f1
echo

# 7. Replace the "/" character with "\" character in the entire /etc/passwd file and redirect the content to a new file
echo "Replacing '/' with '\' in $1 file..."
sed 's/\//\\/g' $1 > /tmp/passwd_modified
echo "Modified passwd file saved to /tmp/passwd_modified"
echo

# 8. Print the private IP
echo "Private IP address:"
hostname -I | awk '{print $1}'
echo

# 9. Print the public IP
echo "Public IP address:"
curl ifconfig.me
echo

# 10. Switch to john user
echo "Switching to john user..."
su - john -c 'echo "Now I am $(whoami)"'
echo

# 11. Print the home directory
echo "Home directory of john user:"
echo $(grep "^john:" $1 | cut -d: -f6)
