#!/bin/sh
source common.sh

echo -e "\e[31m install software \e[0m"
dnf install nginx -y &>$my_log
statuscheck

echo -e "\e[32m start nginx \e[0m"
systemctl enable nginx;systemctl start nginx &>>$my_log
statuscheck

echo -e "\e[33m remove existing files \e[0m"
rm -rf /usr/share/nginx/html/* &>>$my_log
statuscheck

echo -e "\e[34m get the froentend software \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$my_log
statuscheck

echo -e "\e[35m unzip and setup files \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$my_log
cp expense.conf /etc/nginx/default.d/expense.conf
statuscheck

echo -e "\e[36m restart nginx \e[0m"
systemctl restart nginx
statuscheck


