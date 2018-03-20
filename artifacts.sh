cd home-task/
mkdir -p target
./gradlew func -PbuildNumber=$BUILD_NUMBER
cd build/libs/
#java -jar ht-$BUILD_NUMBER.jar > output.log
cd - 
tar -cvzf target/ht-$BUILD_NUMBER.tar.gz -C build/libs/ ht-$BUILD_NUMBER.jar
cd ..
cd simple-sample/
mkdir -p target
./gradlew func -PbuildNumber=$BUILD_NUMBER
cd build/libs/
#java -jar ss-$BUILD_NUMBER.jar > output.log
cd -
tar -cvzf target/ss-$BUILD_NUMBER.tar.gz -C build/libs/ ss-$BUILD_NUMBER.jar

cd /
cp /var/lib/jenkins/workspace/ahoc-automated-task/home-task/target/*tar.gz /opt/jenkins/artifacts
cp /var/lib/jenkins/workspace/ahoc-automated-task/simple-sample/target/*tar.gz /opt/jenkins/artifacts
