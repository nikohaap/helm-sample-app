FROM golang:1.14 AS build-env
ARG SOURCE_FILE=sample
COPY src /go/src
RUN CGO_ENABLED=0 GOOS=linux go build -o bin/sample src/${SOURCE_FILE}/trivial-web-server.go

FROM scratch
COPY --from=build-env /go/bin/sample /app/sample

EXPOSE 8080
CMD ["/app/sample"]
