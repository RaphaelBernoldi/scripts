function printHelp(){
	echo "**************************Print help*****************************"
	echo "Os parametros disponíveis são: java | maven | mysql | jenkins | wildfly | docker | sublime-text"
	echo "Exemplo install-ambiente.sh <<command>> <<command>> <<command>>"
	echo "**************************Print help*****************************"
}

function installJava() {
	echo "Install Java..."

	cd /opt
	wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"
	mv jdk-8u121-linux-x64.tar.gz
	tar -zxvf jdk-8u121-linux-x64.tar.gz

	echo "Adicionar as variaveis 
		export JAVA_HOME=/opt/jdk1.8.0_121
		export PATH=$ PATH:$JAVA_HOME/bin

		Em /etc/profile (CentOS)"
}

function installMaven() {
	echo "Install Maven..."

	cd /opt
	wget http://mirrors.gigenet.com/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
	tar -zxvf apache-maven-3.5.0-bin.tar.gz 

	echo "Adicionar as variaveis 
		export MAVEN_HOME=/opt/apache-maven-3.5.0
		export PATH=$ PATH:$ MAVEN_HOME/bin

		Em /etc/profile (CentOS)"
}

function installMySql() {
	echo "Install MySql..."

	cd /opt
	wget  https://repo.mysql.com/mysql57-community-release-el7-11.noarch.rpm
    rpm -ivh mysql57-community-release-el7-11.noarch.rpm 
    yum install mysql-server

	service mysqld start
    mysqsladmin -uroot password 'root'
    service mysqld stop
    service mysqld start

	echo "MySql configurado com sucesso."

}

function installJenkins() {
	echo "Install Jenkins..."

	cd /opt
	wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
	rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
	yum install jenkins

}

function installWildfly() {
	echo "Install Wildfly..."
	
	cd /opt
	wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
	tar -zxvf wildfly-10.0.0.Final.tar.gz

	echo "Adicionar as variaveis 
		export WILDFLY_HOME=/opt/wildfly-10.0.0.Final
		export PATH=$ PATH:$WILDFLY_HOME/bin

		Em /etc/profile (CentOS)"
}

function installDocker(){
	echo "Install Docker..."
	#Remove possiveis versões antigas instaladas
	sudo apt-get remove docker docker-engine docker.io

	#Atualiza os pacotes do so
	sudo apt-get update

	#Add chave oficial do repositorio gpg do docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

	#add caminho de download no repositorio apt do ubuntu
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

	#Atualiza novamente as bibliotecas
	sudo apt-get update

	#Instalação do docker CE
	sudo apt-get install docker-ce

	#Imprime versao
	sudo docker version

	echo "Docker installed!"
}


function installSublime(){
	echo "Install Sublime..."

	cd ~/Downloads

	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

	sudo apt-add-repository "deb https://download.sublimetext.com/ apt/stable/"

	sudo apt update

	sudo apt-get install sublime-text
}

#Default
echo "Init..."

echo "Create /root/Downloads"
mkdir /root/Downloads
yum remove java*

for param in $*; do
	if [ $param == "help" ]; then
		printHelp
	fi

	if [ $param == "java" ]; then
		installJava
	fi
	
	if [ $param == "mysql" ]; then
		installMySql
	fi

	if [ $param == "jenkins" ]; then
		installJenkins
	fi

	if [ $param == "wildfly" ]; then
		installWildfly
	fi

	if [ $param == "docker"]; then
		installDocker
	fi

	if [ $param == "sublime-text"]; then
		installSublime
	fi
done

cd /opt
mv -f *.tar.gz ~/Downloads/ 

echo "End"
#Instalação do Java
#wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"

#export JAVA_HOME=/opt/jdk1.8.0_121
#export PATH=$PATH:$JAVA_HOME/bin

#Maven
#wget http://mirrors.gigenet.com/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz /opt
#export MAVEN_HOME=/opt/apache-maven-3.5.0
#export PATH=$PATH:$MAVEN_HOME/bin


