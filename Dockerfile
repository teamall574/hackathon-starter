FROM node:19.5.0-alpine

WORKDIR /starter
ENV NODE_ENV development

COPY package.json /starter/package.json

RUN npm install -g npm
RUN npm i -f pm2
RUN npm install --production

COPY .env.example /starter/.env.example
COPY . /starter

CMD ["pm2-runtime","app.js"]

EXPOSE 8080
