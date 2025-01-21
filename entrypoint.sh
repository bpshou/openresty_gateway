#!/bin/bash
set -e

# 捕获 SIGTERM 信号并执行清理操作
cleanup() {
    echo "Received signal, cleaning up..."
    # 假设主进程是 Nginx
    nginx -s stop  # 停止 Nginx 服务
    echo "Cleanup completed. Exiting."
    exit 0
}

# 绑定信号处理函数
trap cleanup SIGTERM SIGINT


if [ -z "$ENV_NAME" ]; then
    ENV_NAME="dev"
fi

echo "Gateway Env ======> [$ENV_NAME]"

if [ ! -d "/etc/nginx/conf.d/custom" ]; then
    rm -rf /etc/nginx/conf.d/*

    cp -rf /root/$ENV_NAME/nginx/ /etc/
    cp -r /root/custom/ /etc/nginx/conf.d/
    cp -r /root/example.ssl/ /etc/nginx/conf.d/

    rm -rf /root/*
fi

exec "$@"
