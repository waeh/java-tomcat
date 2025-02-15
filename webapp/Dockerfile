# Stage 1: Build the Java application using Maven
FROM maven:3.8.8-eclipse-temurin-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml file to the working directory
COPY webapp/pom.xml .

# Download the dependencies required for the project (this step is cached)
RUN mvn dependency:go-offline -B

# Copy the entire project source to the working directory
COPY webapp/src ./src

# Build the project and package it as a WAR file
RUN mvn clean package -DskipTests

# Stage 2: Package the application with Tomcat
FROM tomcat:9.0

# Set the working directory inside the container
WORKDIR /usr/local/tomcat

# Copy the WAR file from the builder stage to the Tomcat webapps directory
COPY --from=builder /app/target/*.war ./webapps/ROOT.war

# Copy the server.xml to the Tomcat conf directory
COPY webapp/server.xml ./conf/

# Expose the port Tomcat is running on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]