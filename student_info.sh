#!/bin/bash 

if [ $# -ne 2 ]; then 
    echo "Usage: $0 <student_name> <city>"
    exit 1
fi

STUDENT_NAME=$1
CITY=$2    

echo "Student Name: $STUDENT_NAME"
echo "City: $CITY"
