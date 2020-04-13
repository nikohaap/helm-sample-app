FROM golang:1.14 AS build-env
ARG SOURCE_FILE=sample

ENV GO11MODULE=on
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o bin/sample src/${SOURCE_FILE}/trivial-web-server.go

FROM scratch
COPY --from=build-env /app/bin/sample /app/sample

EXPOSE 8080
CMD ["/app/sample"]
