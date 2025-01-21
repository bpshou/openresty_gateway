# README #
openresty网关


## 服务启动
> docker运行

### docker compose
服务启动

1. docker-compose校验
```
docker compose up -d --force-recreate --build
```

### docker run
服务启动

1. 构建openresty镜像
```
docker build -t openresty-gateway .
```

2. 启动openresty服务
```
docker run -d \
    -p 8686:80 \
    --name openresty-gateway \
    --add-host www.example.com:127.0.0.1 \
    openresty-gateway
```
