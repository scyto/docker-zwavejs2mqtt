docker buildx build  --platform linux/amd64,linux/arm64,linux/arm/v7 --build-arg SRC=git-clone-src --build-arg Z2M_BRANCH=master --build-arg ZWJ_BRANCH=master  --push  -f ./docker/Dockerfile.contrib -t scyto/zwavejs2mqtt:master https://github.com/zwave-js/zwavejs2mqtt.git
