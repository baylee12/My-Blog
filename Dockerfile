FROM java:8
# 维护者信息
MAINTAINER baylee
# 这里的 /tmp 目录就会在运行时自动挂载为匿名卷，任何向 /tmp 中写入的信息都不会记录进容器存储层
VOLUME /tmp
# 复制上下文目录下的 target/my-blog-4.0.0-SNAPSHOT.jar 到容器里
COPY target/my-blog-4.0.0-SNAPSHOT.jar my-blog-4.0.0-SNAPSHOT.jar
# bash方式执行，使my-blog-4.0.0-SNAPSHOT.jar可访问
# RUN新建立一层，在其上执行这些命令，执行结束后， commit 这一层的修改，构成新的镜像。
RUN bash -c "touch /my-blog-4.0.0-SNAPSHOT.jar"
# 指定时区
# ENV TZ='Asia/Shanghai'
# 声明运行时容器提供服务端口，这只是一个声明，在运行时并不会因为这个声明应用就会开启这个端口的服务
EXPOSE 28084
# 指定容器启动程序及参数   <ENTRYPOINT> "<CMD>"
ENTRYPOINT ["java","-jar","-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=28084","my-blog-4.0.0-SNAPSHOT.jar"]