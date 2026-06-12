# Stage 1: сборка native executable
FROM ghcr.io/graalvm/native-image-community:17 AS builder
WORKDIR /app
COPY . .
RUN chmod +x gradlew && ./gradlew nativeCompile --no-daemon

# Stage 2: минимальный образ только с бинарником
FROM ubuntu:22.04
WORKDIR /app
COPY --from=builder /app/build/native/nativeCompile/quote-service .
EXPOSE 9101
ENTRYPOINT ["./quote-service"]