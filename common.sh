script_location=$(pwd)
LOG=/tmp/roboshop.log

status_check () {
  if [ $? -eq 0 ]
  then
    echo -e "\e[35m Success \e[0m"
  else
    echo -e "\e[34m Fail \e[0m"
    echo -e "\e[33m Refer log file $LOG \e[0m"
  exit
  fi
}

print_head () {
  echo " "

}