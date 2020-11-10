FROM node:alpine As builder
ENV NODE_ENV production
RUN apk add --no-cache bash && \
  apk upgrade --no-cache --available
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json", "./"]
RUN npm rm -rf node_modules
RUN npm cache clean --force
RUN npm install -g vue-cli
RUN npm install --only=dev
RUN npm install --production
RUN npm update
COPY . .
RUN npm run build --prod

FROM nginx:1.19.3-alpine
COPY --from=builder /usr/src/app/public/ /usr/share/nginx/html
EXPOSE 80