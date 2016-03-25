FROM ubuntu:14.04
MAINTAINER Roman Naumenko <roman@naumenko.ca>

RUN apt-get update 
RUN apt-get install -y wget htop node curl nginx 

EXPOSE 80

# Append "daemon off;" to nginx config 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

CMD service nginx start
