FROM ubuntu
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk maven wget && \
    wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.56/bin/apache-tomcat-9.0.56.tar.gz && \
    tar -xzvf apache-tomcat-9.0.56.tar.gz && \
    rm apache-tomcat-9.0.56.tar.gz
ENV CATALINA_HOME /apache-tomcat-9.0.56
WORKDIR /app
RUN mvn archetype:generate \
    -DgroupId=com.mycompany.app \
    -DartifactId=my-app \
    -DarchetypeArtifactId=maven-archetype-webapp \
    -DinteractiveMode=false
WORKDIR /app/my-app
RUN mvn package && \
    cp target/my-app.war $CATALINA_HOME/webapps/
CMD ["/apache-tomcat-9.0.56/bin/catalina.sh", "run"]
EXPOSE 80
