FROM golang:1.15 as build

WORKDIR /go/src/app
COPY src/ .

ENV CGO_ENABLED 0
ENV GOOS linux
ENV GOARCH amd64

RUN go build -ldflags '-w -extldflags "-static"' -o main main.go

FROM scratch
COPY --from=build /go/src/app/main /main
CMD ["/main"]