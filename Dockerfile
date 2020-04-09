FROM golang:1.7.1 AS build-env
ARG source_file=sample
COPY src /go/src
RUN CGO_ENABLED=0 GOOS=linux go build -o bin/sample src/${source_file}/trivial-web-server.go

FROM scratch
COPY --from=build-env /go/bin/sample /app/sample

EXPOSE 8080
CMD ["/app/sample"]
