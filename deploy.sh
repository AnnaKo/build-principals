echo "build step"
tar -xvf ${JENKINS_HOME}/artifacts/$BUILD
string2=${BUILD:0:-7}
number1=${#string2}
number2=6
number3=$(($number1-$number2))
number4=$((0-$number3))
string2=${string2:$number4}
java -jar home-task.jar
