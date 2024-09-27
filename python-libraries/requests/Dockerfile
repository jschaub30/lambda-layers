FROM amazonlinux:2023

ENV DEBIAN_FRONTEND=noninteractive

RUN yum install -y python3-pip zip

RUN mkdir python && \
    pip install requests -t ./python/ && \
    zip -r9 /requests-layer.zip python

CMD [ "bash" ]
