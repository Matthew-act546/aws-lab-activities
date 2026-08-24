#!/bin/bash

# AWS re/Start - Task 2 & Task 3
# Create Users and Groups

set -e

PASSWORD='P@ssword1234!'

echo "========================================"
echo " AWS re/Start - Users and Groups"
echo "========================================"
echo

# --------------------------------------------------
# Task 2: Create Users
# --------------------------------------------------

USERS=(
    arosalez
    eowusu
    jdoe
    ljuan
    mmajor
    mjackson
    nwolf
    psantos
    smartinez
    ssarkar
)

echo "[1/4] Creating users..."

for user in "${USERS[@]}"; do
    if id "$user" &>/dev/null; then
        echo "  [EXISTS] $user"
    else
        sudo useradd "$user"
        echo "  [CREATED] $user"
    fi
done

echo

# --------------------------------------------------
# Set starting password
# --------------------------------------------------

echo "[2/4] Setting user passwords..."

for user in "${USERS[@]}"; do
    echo "$user:$PASSWORD" | sudo chpasswd
    echo "  [PASSWORD SET] $user"
done

echo

# --------------------------------------------------
# Task 3: Create Groups
# --------------------------------------------------

LAB_GROUPS=(
    Sales
    HR
    Finance
    Personnel
    Shipping
    Managers
    CEO
)

echo "[3/4] Creating gfor group in Sales HR Finance Personnel Shipping Managers CEO; do sudo groupdel "$group" 2>/dev/null || true; doneroups..."

for group in "${LAB_GROUPS[@]}"; do
    if getent group "$group" &>/dev/null; then
        echo "  [EXISTS] $group"
    else
        sudo groupadd "$group"
        echo "  [CREATED] $group"
    fi
done

echo

# --------------------------------------------------
# Task 3: Assign users to groups
# --------------------------------------------------

echo "[4/4] Assigning users to groups..."

# Sales
sudo usermod -a -G Sales arosalez
sudo usermod -a -G Sales nwolf

# HR
sudo usermod -a -G HR ljuan
sudo usermod -a -G HR smartinez

# Finance
sudo usermod -a -G Finance mmajor
sudo usermod -a -G Finance ssarkar

# Shipping
sudo usermod -a -G Shipping eowusu
sudo usermod -a -G Shipping jdoe
sudo usermod -a -G Shipping psantos

# Managers
sudo usermod -a -G Managers arosalez
sudo usermod -a -G Managers ljuan
sudo usermod -a -G Managers mmajor

# CEO
sudo usermod -a -G CEO mjackson

# AWS re/Start explicitly asks ec2-user
# to be added to all groups.
for group in "${LAB_GROUPS[@]}"; do
    sudo usermod -a -G "$group" ec2-user
done

echo
echo "========================================"
echo " Users and groups created successfully"
echo "========================================"
echo

echo "Users:"
for user in "${USERS[@]}"; do
    id "$user" | sed 's/^/  /'
done

echo
echo "Group memberships:"
echo

for group in "${LAB_GROUPS[@]}"; do
    getent group "$group"
done

echo
echo "Done."
