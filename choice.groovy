ls="ls -t1 /opt/jenkins/master/artifacts/".execute().text.split()
ls.each{
println it
}
