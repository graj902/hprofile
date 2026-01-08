# Stage 1: Build the application
FROM eclipse-temurin:11-jdk AS build
RUN apt-get update && apt-get install -y maven
WORKDIR /vprofile-project
COPY . .
RUN mvn install -DskipTests

# Stage 2: Run the application in Tomcat
FROM tomcat:9-jre11
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]