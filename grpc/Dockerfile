FROM golang:alpine

ENV TZ "Asia/Shanghai"

# grpc log config
ENV GRPC_GO_LOG_VERBOSITY_LEVEL "99" 
ENV GRPC_GO_LOG_SEVERITY_LEVEL  "info"

ADD ./google /usr/include/google

RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk update \
    && apk add tzdata make git protoc \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && go env -w GOPROXY="https://goproxy.cn,direct" \
    && cd /srv && go mod init grpc.io/dev \
    && go install \
            google.golang.org/protobuf/cmd/protoc-gen-go \
            google.golang.org/grpc/cmd/protoc-gen-go-grpc \
            github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
            github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
    && rm -rf /srv/* \
    && rm -rf /go/pkg \
    && rm -rf /var/cache/apk/*

CMD ["sh"]