tar -cvzf hello-$BUILD_NUMBER.tar.gz -C home-task/build/libs hello-$BUILD_NUMBER.jar
mkdir -p $JENKINS_HOME/artifacts/
cp $1 $JENKINS_HOME/artifacts/
