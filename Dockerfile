FROM brereton/centos7-jdk7

MAINTAINER "JoAnn Brereton <joann.brereton@gmail.com>

ENV TOMCAT_VERSION 8.0.23

# set up user
RUN groupadd tomcat
RUN useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat

# Get and Unpack Tomcat
RUN cd /tmp && wget http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz && tar xzf /tmp/catalina.tar.gz -C /opt && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && rm -f /tmp/catalina.tar.gz

RUN chown -R tomcat:tomcat /opt/tomcat/

RUN rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs 

VOLUME ["/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root" ]

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080
EXPOSE 8009

USER tomcat
CMD ["/opt/tomcat/bin/startup.sh"]

