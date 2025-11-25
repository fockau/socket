#!/bin/sh
set -e

# 默认端口 & 远端地址（可被环境变量覆盖）
LISTEN_PORT="${LISTEN_PORT:-8088}"
REMOTE_ADDR="${REMOTE_ADDR:-cloudnproxy.baidu.com}"

echo "======================="
echo " Starting baidu proxy"
echo " Listen Port : ${LISTEN_PORT}"
echo " Remote Addr : ${REMOTE_ADDR}"
echo " Extra Args  : $*"
echo "======================="

# 运行代理程序
# 说明：
# - 默认加上 -p 和 -r，以及 -l 打开日志
# - 你可以通过 docker-compose 的 command 或 docker run 的参数追加其它 flags（例如 -d）
exec ./thread_socket \
  -p "${LISTEN_PORT}" \
  -r "${REMOTE_ADDR}" \
  -l "$@"
