FROM svlentink/bower
RUN mkdir -p /data
WORKDIR /data
RUN bower install --allow-root crypto-js 
CMD cp -r /data/bower* /generated
