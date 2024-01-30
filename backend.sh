#!/bin/sh
source common.sh

echo -e "\e[31m setup \e[0m"
dnf module disable nodejs -y &>$my_log
dnf module enable nodejs:18 -y &>>$my_log
statuscheck

echo -e "\e[32m install nodejs and mysql \e[0m"
dnf install nodejs -y &>>$my_log
dnf install mysql -y &>>$my_log


echo -e "\e[33m install backend software \e[0m"

useradd expense
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$my_log
cd /app 
unzip /tmp/backend.zip &>>$my_log
cd /app 
npm install &>>$my_log

echo -e "\e[32m copy service \e[0m"

cp /root/expense-latest/backend.service /etc/systemd/system/backend.service &>>$my_log


echo -e "\e[32m start service \e[0m"

systemctl daemon-reload &>>$my_log
systemctl enable backend &>>$my_log
systemctl start backend &>>$my_log


#mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql
