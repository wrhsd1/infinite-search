# 使用官方的Java运行时作为基础镜像
FROM openjdk:21-jdk-slim AS build

# 设置工作目录
WORKDIR /workspace/app

# 复制构建脚本到容器中
COPY gradlew .
COPY gradle gradle

# 复制源代码文件到 WORKDIR
COPY src src
COPY build.gradle .

# 使用 Gradlew 构建 JAR
RUN chmod +x ./gradlew
RUN ./gradlew build -x test

FROM openjdk:21-jdk-slim AS final

COPY --from=build /workspace/app/build/libs/*.jar app.jar

# 声明启动容器时的端口号
EXPOSE 8605

# 配置项目启动命令
ENTRYPOINT ["java","-jar","app.jar"]
