FROM golang:alpine

WORKDIR /opt

ENV TZ "Asia/Shanghai"

ENV GRPC_GO_LOG_VERBOSITY_LEVEL "99" 
ENV GRPC_GO_LOG_SEVERITY_LEVEL  "info"

RUN go env -w GOPROXY="https://goproxy.cn,direct"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add protobuf tzdata curl git wget iproute2 bash upx \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && go get google.golang.org/grpc \
    && go get github.com/golang/protobuf/protoc-gen-go \
    && go install github.com/golang/protobuf/protoc-gen-go

RUN curl -o protoc.zip -LJ https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip \
    && unzip protoc.zip \
    && mv include/ /usr/ \
    && rm -rf /opt/*

CMD ["sh"]