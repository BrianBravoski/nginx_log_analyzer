#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <nginx log file>"
    exit 1
fi

Log_File=$1

if [ ! -f $Log_File ]; then
    echo "Error: $Log_File not found."
    exit 1
fi
echo -----------------------------------------
echo "Top 5 IP addresses in the log file: $Log_File"
awk '{print $1}' $Log_File | sort | uniq -c | head -n 5 | sort -nr | awk '{print $2,  " - "$1 " requests"}'
echo ----------------------------------------
echo ----------------------------------------
echo "Top 5 URLs in the log file: $Log_File"
awk '{print $7}' $Log_File | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2,  " - "$1 " requests"}'
echo ----------------------------------------

echo ----------------------------------------
echo "Top 5 User Agents in the log file: $Log_File"
awk -F\" '{print $6}' $Log_File | sort | uniq -c | sort -nr | head -n 5
echo ----------------------------------------

echo ----------------------------------------
echo "Top 5 Response Codes in the log file: $Log_File"
awk '{print $9}' $Log_File | sort | uniq -c | sort -nr | head -n 5 | awk '{print $2,  " - "$1 " requests"}'