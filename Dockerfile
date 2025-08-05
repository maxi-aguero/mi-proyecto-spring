# Fase 1: Compilación de la aplicación
# Usamos una imagen que ya tiene Maven y Java
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Fase 2: Creación de la imagen final (más ligera)
# Usamos una imagen de Java más simple para el runtime
FROM eclipse-temurin:17-jre-focal
WORKDIR /app
# Copiamos el archivo JAR compilado desde la fase 1
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
