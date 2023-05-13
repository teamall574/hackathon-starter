FROM node:19.5.0-alpine

WORKDIR /starter
ENV NODE_ENV development

COPY package.json /starter/package.json

RUN yarn global add pm2
RUN npm install pm2 -g
RUN apt update && apt install sudo curl && curl -sL https://raw.githubusercontent.com/Unitech/pm2/master/packager/setup.deb.sh | sudo -E bash -
RUN npm install pm2 -g && pm2 update
RUN pm2 completion install

RUN npm install --production

COPY .env.example /starter/.env.example
COPY . /starter

CMD ["pm2-runtime","app.js"]

EXPOSE 8080
