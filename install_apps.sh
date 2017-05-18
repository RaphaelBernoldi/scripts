

#Configuração do hosts local

#EleevaIT
#172.16.1.96 		jenkins
#172.16.1.121		portal-application-01
#172.16.1.123 		portal-collector-01
#172.16.1.124		portal-database-01
#172.16.1.125		portal-homolog-01




#update user set authentication_string=PASSWORD('root') where user='root';
#FLUSH PRIVILEGES;
#create database portal_db charset utf8
#create database liferay_db charset utf8
#vim /etc/my.cnf
#skip_grant_tables

function printHelp(){
	echo "**************************Print help*****************************"
	echo "Os comandos disponíveis são: java maven mysql jenkins wildfly"
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


