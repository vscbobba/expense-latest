my_log="/tmp/error.log"


statuscheck( ){

if [ $? -eq 0 ]; then
 echo "successful"
else
 echo "check log"
 exit
fi

}
