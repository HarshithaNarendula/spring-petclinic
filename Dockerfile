FROM maven:3.8.7-eclipse-temurin-17 as builder
WORKDIR /app
COPY . .
RUN ./mvnw package -DskipTests

# Stage 2: Run the jar using JDK 17
FROM eclipse-temurin:17
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
