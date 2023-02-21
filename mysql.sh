source common.sh

mysql_root_password=$1
if [ -z "${mysql_root_password}" ]; then
  echo -e "\e[31mMissing MySQL Root Password argument\e[0m"
  exit 1
fi
print_head "disabling mysql 8 version"
dnf module disable mysql -y  &>>${log_file}
status_check $?

print_head "copy mysql repo"
cp ${code_dir}/configs/mysql.repo /etc/yum.repos.d/mysql.repo  &>>${log_file}
status_check $?

print_head "Installing MYSQL Server"
yum install mysql-community-server -y  &>>${log_file}
status_check $?

print_head "enable mysql service"
systemctl enable mysqld  &>>${log_file}
status_check $?

print_head "start mySQL Service"
systemctl start mysqld   &>>${log_file}
status_check $?

print_head "set password"
mysql_secure_installation --set-root-pass ${mysql_root_password}  &>>${log_file}
status_check $?