# ---------- 1단계 : 빌드 ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY server ./server
COPY webapp ./webapp
COPY *.html ./webapp/src/main/webapp/
WORKDIR /app/webapp
RUN mvn -B clean package -DskipTests

# ---------- 2단계 : 실행 ----------
FROM tomcat:9.0-jre17-temurin
LABEL maintainer="itssp0405@gmail.com"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/webapp/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
