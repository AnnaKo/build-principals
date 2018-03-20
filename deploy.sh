FILENAME="${BUILD_FILE%%.*}"
tar -xzf $JENKINS_HOME/artifacts/$BUILD_FILE | java -jar $FILENAME.jar
