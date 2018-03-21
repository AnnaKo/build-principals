echo "Enter the number of build here: "
echo $build
tar -xvf ${JENKINS_HOME}/artefacts/$build
str2=${build:0:-7}
num1=${#str2}
num2=6
num3=$(($num1-$num2))
num4=$((0-$num3))
str2=${str2:$num4}
java -jar hello-$str2.jar
