FROM node:slim
WORKDIR /app
COPY package.json .
RUN npm install -g
ENTRYPOINT ["npm","start"]
COPY index.js .

