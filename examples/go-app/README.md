# go-app

This is an example code

```bash

export HUB=registry.cn-hangzhou.aliyuncs.com/
export GIT_ACCESS_TOKEN=your-token
export GIT_USER=your-username
export PRIVATE_GIT=github.com

docker build --build-arg PRIVATE_GIT=${PRIVATE_GIT} \
  --build-arg GIT_ACCESS_TOKEN=${GIT_ACCESS_TOKEN} \
  --build-arg GIT_USER=${GIT_USER}  \
  -t ${HUB}cloudnativeapps/go-app .

```