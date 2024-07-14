from python:alpine
RUN apk add --no-cache dos2unix
COPY requirements.txt /
RUN pip3 install -r /requirements.txt
WORKDIR /app
COPY waitress.py /app/
CMD ["/app/waitress.py"]

