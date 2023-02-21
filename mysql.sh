source common.sh
mysql_root_password=$1
if [ -z "{mysql_root_password}"]; then
echo -e "\e[31m"Missing MySQL root password argument \e[0m"
exit1
fi
print_head "disabling mysql 8 version"
dnf module disable mysql -y 
status_check $?

print_head "Installing MYSQL Server"
yum install mysql-community-server -y
status_check $?

print_head "enable mysql service"
systemctl enable mysqld
status_check $?

print_head "start mySQL Service"
systemctl start mysqld  
status_check $?

print_head "set password "
mysql_secure_installation --set-root-pass ${mysql_root_password}
status_check $?