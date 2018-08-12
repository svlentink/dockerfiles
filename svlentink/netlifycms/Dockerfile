FROM node:alpine
RUN apk add --no-cache git; \
  cd /; \
  git clone https://github.com/netlify-templates/one-click-hugo-cms; \
  cd /one-click-hugo-cms; \
  npm install
WORKDIR /one-click-hugo-cms
#RUN npm install -g gulp-svgstore
#RUN npm install -g gulp
#RUN npm install gulp-util --save-dev
CMD npm start

