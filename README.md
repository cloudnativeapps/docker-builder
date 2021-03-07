# docker-builder

After many hours of struggling with getting my application which imported some private repos within the building of my docker image, I thought that this information could be useful to the community. The problem I experienced, and likely why you are reading this, is that in order to fetch go dependencies from a private repository you need to setup git credentials within the docker image build.

Here is how I did

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
export PRIVATE_GIT=git.example.com
# Base image
export BASE_IMG=golang:1.15-alpine

docker build \
  --build-arg BASE_IMG=${BASE_IMG} \
  --build-arg PRIVATE_GIT=${PRIVATE_GIT} \
  --build-arg GIT_ACCESS_TOKEN=${GIT_ACCESS_TOKEN} \
  --build-arg GIT_USER=${GIT_USER} \
  -t ${HUB}cloudnativeapps/builder:go1.15-alpine .
```