FROM tomcat:latest
COPY target/gamutgurus.war /usr/local/tomcat/
CMD ["catalina.sh", "run"]
