# docker-builder

## Build Docker Image

### 1. Build without args



```bash
export HUB=registry.cn-hangzhou.aliyuncs.com/

docker build \
  -t ${HUB}cloudnativeapps/builder:go1.15-alpine .
```

### 2. Build with args

```bash
export HUB=registry.cn-hangzhou.aliyuncs.com/
export GIT_ACCESS_TOKEN=your-token
export GIT_USER=your-username
export GPRIVATE_GIT=git.example.com
# Base image
export BASE_IMG=golang:1.15-alpine

docker build \
  --build-arg BASE_IMG=${BASE_IMG} \
  --build-arg GPRIVATE_GIT=${GPRIVATE_GIT} \
  --build-arg GIT_ACCESS_TOKEN=${GIT_ACCESS_TOKEN} \
  --build-arg GIT_USER=${GIT_USER} \
  -t ${HUB}cloudnativeapps/builder:go1.15-alpine .
```