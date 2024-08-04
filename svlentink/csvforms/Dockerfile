from python:alpine
RUN apk add --no-cache dos2unix git
COPY requirements.txt /
RUN pip3 install -r /requirements.txt
WORKDIR /app
COPY server.py /app/
ENTRYPOINT ["python3","/app/server.py"]

