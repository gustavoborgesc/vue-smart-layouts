FROM node:alpine
ENV NODE_ENV development
RUN apk add --no-cache bash && \
  apk upgrade --no-cache --available
WORKDIR /usr/src/app
COPY ["package.json", "./"]
RUN npm rm -rf node_modules
RUN npm cache clean --force
RUN npm install -g vue-cli
RUN npm install --only=dev
RUN npm install
RUN npm cache clean --force
RUN npm update
COPY . .