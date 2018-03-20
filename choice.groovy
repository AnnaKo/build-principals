ls="ls -t1 /opt/jenkins/artifacts".execute().text.split()
ls.each{
println it
}
