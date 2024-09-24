FROM alpine:latest

RUN apk update && apk add bash && apk add curl

COPY "loadgen/http-requests.sh" /usr/local/bin/

CMD ["/bin/bash","http-requests.sh"]