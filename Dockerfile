ARG BASE_IMG=golang:1.15-alpine
# Build the manager binary
FROM ${BASE_IMG}

# It is important that these ARG's are defined after the FROM statement
ARG GIT_USER="nothing"
ARG GIT_ACCESS_TOKEN="nothing"
ARG PRIVATE_GIT="nothing"
ENV GOPROXY=https://goproxy.cn

RUN go env -w GOPROXY=${GOPROXY} && \
  go env -w GOPRIVATE=${PRIVATE_GIT} && \
  go env -w GOINSECURE=${PRIVATE_GIT} && \
  go env -w GONOSUMDB=${PRIVATE_GIT}

# git is required to fetch go dependencies
RUN apk add --no-cache ca-certificates git
# Create the user and group files that will be used in the running 
# container to run the process as an unprivileged user.
RUN mkdir /user && \
  echo 'nobody:x:65534:65534:nobody:/:' > /user/passwd && \
  echo 'nobody:x:65534:' > /user/group
# Create a netrc file using the credentials specified using --build-arg
RUN printf "machine ${PRIVATE_GIT}\n\
  login ${GIT_USER}\n\
  password ${GIT_ACCESS_TOKEN}\n"\
  >> /root/.netrc
RUN chmod 600 /root/.netrc

WORKDIR /workspace
