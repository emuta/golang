FROM golang:alpine

ENV TZ "Asia/Shanghai"

RUN go env -w GOPROXY="https://goproxy.cn,direct"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add tzdata curl git iproute2 bash upx \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

CMD ["sh"]