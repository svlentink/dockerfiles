FROM wernight/codiad
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /code/workspace/hugo/public; \
  mkdir -p /etc/s6/hugo; \
  > /etc/s6/hugo/finish; \
  chmod +x /etc/s6/hugo/finish; \
  apt install -y hugo git
COPY hugo.sh /etc/s6/hugo/run

VOLUME /code/workspace/hugo
