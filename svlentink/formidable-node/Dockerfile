FROM node:slim
RUN npm i @ninja-labs/verify-pdf pdfreader node-forge formidable
WORKDIR /app
ENTRYPOINT ["node", "/app/index.js"]
