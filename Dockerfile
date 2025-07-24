FROM ubuntu:20.04 AS git-clone
RUN apt-get update && apt-get install -y git
WORKDIR /app
RUN git clone https://github.com/netdoctor0405/hello-world.git .

FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY --from=git-clone /app .
WORKDIR /app/webapp
RUN mvn clean package

FROM tomcat:9.0.65-jdk17-corretto
COPY --from=build /app/webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh", "run"]
