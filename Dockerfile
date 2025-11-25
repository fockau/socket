FROM alpine:latest

# 安装编译环境
RUN apk add --no-cache build-base clang

# 工作目录
WORKDIR /app

# 拷贝源码到容器
COPY . /app

# 编译：优先用 Makefile，不行就直接 clang
RUN if [ -f Makefile ]; then \
      make || clang -m64 -O3 -Wall -lpthread -o thread_socket thread_socket.c driver.c ; \
    else \
      clang -m64 -O3 -Wall -lpthread -o thread_socket thread_socket.c driver.c ; \
    fi && \
    strip thread_socket

# 复制 entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 容器内部监听端口
EXPOSE 8088

# 使用 entrypoint 脚本
ENTRYPOINT ["/entrypoint.sh"]

# 默认不传额外参数，由 entrypoint 使用默认端口/IP
CMD []
