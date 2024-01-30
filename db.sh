#!/bin/bash

echo -e "\e[31m install software \e[0m"

cp /root/expense-latest/mysql.repo /etc/yum.repos.d/mysql.repo &>$my_log
status_check


dnf module disable mysql -y &>>$my_log
status_check

echo -e "\e[33m install sql \e[0m"
dnf install mysql-community-server -y &>>$my_log
status_check

echo -e "\e[31m start mysql \e[0m"
systemctl enable mysqld &>>$my_log
systemctl start mysqld &>>$my_log
status_check


echo -e "\e[35m secure install \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1
status_check


#mysql -uroot -pExpenseApp@1
#status_check