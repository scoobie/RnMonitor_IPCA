FROM ojbc/mondrian-rest:no-auth

MAINTAINER Rolando Azevedo "rolando.a@sapo.pt"

RUN cd /tmp && \
    curl -O https://repo1.maven.org/maven2/org/postgresql/postgresql/9.3-1104-jdbc4/postgresql-9.3-1104-jdbc4.jar && \
    mv postgresql-9.3-1104-jdbc4.jar /usr/local/tomcat/shared/

COPY files/application.properties /usr/local/tomcat/shared/config/
COPY files/*.json /usr/local/tomcat/shared/
COPY files/*.xml /usr/local/tomcat/shared/

RUN mkdir -p /usr/local/tomcat/webapps/demo
COPY files/index.html /usr/local/tomcat/webapps/demo/

CMD ["catalina.sh","run"]
