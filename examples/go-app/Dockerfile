# Build the manager binary
FROM registry.cn-hangzhou.aliyuncs.com/cloudnativeapps/builder:go1.15-alphine as builder

ARG GIT_USER="nothing"
ARG GIT_ACCESS_TOKEN="nothing"
ARG PRIVATE_GIT="nothing"

RUN go env -w GOPROXY=${GOPROXY} && \
  go env -w GOPRIVATE=${PRIVATE_GIT} && \
  go env -w GOINSECURE=${PRIVATE_GIT} && \
  go env -w GONOSUMDB=${PRIVATE_GIT}

# Create a netrc file using the credentials specified using --build-arg
RUN printf "machine ${PRIVATE_GIT}\n\
  login ${GIT_USER}\n\
  password ${GIT_ACCESS_TOKEN}\n"\
  >> /root/.netrc

# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
RUN go mod download

# Copy the go source
COPY main.go main.go

# COPY controllers/ controllers/

# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o manager main.go

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details

# FROM gcr.io/distroless/static:nonroot
FROM registry.cn-hangzhou.aliyuncs.com/cloudnativeapps/static:nonroot

WORKDIR /
COPY --from=builder /workspace/manager .
USER 65532:65532

ENTRYPOINT ["/manager"]
