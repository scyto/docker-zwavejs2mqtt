# Use alpine base image
FROM node:15.9.0-alpine
# ARG YARN_NETWORK_TIMEOUT=300000

# build zwavejs
RUN apk update \
  && apk add --no-cache git python3  linux-headers yarn coreutils jq alpine-sdk \
  && git clone https://github.com/zwave-js/node-zwave-js.git \
  && git clone https://github.com/zwave-js/zwavejs2mqtt.git


RUN  npm install --g lerna \
  && yarn \
  && yarn run build \
  && lerna exec -- yarn link \ 
 # && cd ..

# build zwavejs2mqtt

RUN cd zwavejs2mqtt \
  && npm install \
  && npm run build \
  && yarn link zwave-js @zwave-js/core @zwave-js/config @zwave-js/serial @zwave-js/shared

# FROM node:15.9.0-alpine

RUN apk add --no-cache \	
    libstdc++  \
    openssl \
    libgcc \	
    libusb \	
    tzdata \	
    eudev	

# Copy files from previous build stage	
# COPY --from=builder /zwavejs2mqtt /usr/src/app/zwavejs2mqtt
# COPY --from=builder /node-zwave-js /usr/src/app/node-zwave-js		

WORKDIR /zwavejs2mqtt

# Define environment variable
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG C.UTF-8
ENV TZ America/Los_Angeles
# WORKDIR /usr/src/app/zwavejs2mqtt

# Run  when the container launches
CMD ["npm", "start"]