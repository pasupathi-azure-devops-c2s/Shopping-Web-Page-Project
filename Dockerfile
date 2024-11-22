# Step 1: Build Stage - Use Maven to compile the WAR file
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml .
COPY src ./src

# Run Maven to build the WAR file
RUN mvn clean install -DskipTests

# Step 2: Deployment Stage - Use Tomcat to deploy the WAR file
FROM tomcat:10.0-jdk11-openjdk-slim

# Set the working directory inside the container for Tomcat
WORKDIR /usr/local/tomcat/webapps

# Copy the WAR file from the build stage to the Tomcat webapps directory
COPY --from=build /app/target/Shopping-Web-Page-Project-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port Tomcat runs on (default is 8080)
EXPOSE 8080

# Command to run Tomcat
CMD ["catalina.sh", "run"]
