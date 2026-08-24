#!/bin/bash

# AWS re/Start - Working With Files
# CompanyA structure, backup, logging, and moving backup

set -e

BASE="/home/ec2-user"
COMPANY="$BASE/CompanyA"
BACKUP="$BASE/backup.CompanyA.tar.gz"

echo "========================================"
echo " AWS re/Start - Working With Files"
echo "========================================"
echo

# --------------------------------------------------
# Task 1: Create CompanyA directory structure
# --------------------------------------------------

echo "[1/5] Creating CompanyA directory structure..."

mkdir -p \
    "$COMPANY/Employees" \
    "$COMPANY/Finance" \
    "$COMPANY/HR" \
    "$COMPANY/IA" \
    "$COMPANY/Management" \
    "$COMPANY/SharedFolders"

# --------------------------------------------------
# Create required files
# --------------------------------------------------

touch \
    "$COMPANY/Employees/Schedules.csv" \
    "$COMPANY/Finance/Salary.csv" \
    "$COMPANY/HR/Assessments.csv" \
    "$COMPANY/HR/Managers.csv" \
    "$COMPANY/Management/Promotions.csv" \
    "$COMPANY/Management/Sections.csv"

echo "  CompanyA structure created."
echo

# --------------------------------------------------
# Task 2: Create backup
# --------------------------------------------------

echo "[2/5] Creating backup..."

cd "$BASE"

# Remove an old generated backup from the IA folder
# so repeated executions don't accidentally include it.
rm -f "$COMPANY/IA/backup.CompanyA.tar.gz"

# Remove old backup in /home/ec2-user
rm -f "$BACKUP"

tar -cvpzf "$BACKUP" CompanyA

echo
echo "  Backup created:"
echo "  $BACKUP"
echo

# --------------------------------------------------
# Task 3: Log the backup
# --------------------------------------------------

echo "[3/5] Creating backup log..."

LOG="$COMPANY/SharedFolders/backups.csv"

touch "$LOG"

echo "$(date '+%d %b %Y, %H:%M'), backup.CompanyA.tar.gz" | tee "$LOG"

echo
echo "  Backup log:"
cat "$LOG"
echo

# --------------------------------------------------
# Task 4: Move backup to IA
# --------------------------------------------------

echo "[4/5] Moving backup to IA..."

mv "$BACKUP" "$COMPANY/IA/"

echo "  Backup moved to:"
echo "  $COMPANY/IA/backup.CompanyA.tar.gz"
echo

# --------------------------------------------------
# Task 5: Verify final structure
# --------------------------------------------------

echo "[5/5] Final verification..."
echo

echo "CompanyA structure:"
ls -R "$COMPANY"

echo
echo "========================================"
echo " Backup workflow completed successfully"
echo "========================================"
