#!/bin/bash

#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)

LOG="/tmp/$0-$TIMESTAMP.log"

echo " script started executing at $TIMESTAMP" &>> $LOG

# Checking root user or not

ID=$(id -u)

if [ $ID -ne 0 ]
then
    echo -e "$R ERROR: Please run with root user $N"
    exit 1
else
    echo -e "$G you are root user $N"
fi

#echo " All arguments passed: $@"

# VALIDATE

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e " $2 .... $R Failed $N"
    else
        echo -e " $2 .... $G Success $N"
    fi
}

cp mongo.repo /etc/yum.repos.d/mongo.repo  &>> $LOG

VALIDATE $? "Copied MongoDB Repo"

dnf install mongodb-org -y &>> $LOG

VALIDATE $? "Installing MongoDB"

systemctl enable mongod &>> $LOG

VALIDATE $? "Enable MongoDB"

systemctl start mongod  &>> $LOG

VALIDATE $? "Start MongoDB"







