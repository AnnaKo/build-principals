FILENAME="${HT%%.*}"
tar -xvzf /opt/jenkins/artifacts/$HT
java -jar $FILENAME.jar
