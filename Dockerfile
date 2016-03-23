FROM python:2.7.10                 
MAINTAINER adam <adam2007@163.com> 

# install python
RUN apt-get update && \
        apt-get install -y python python-dev python-distribute python-pip && \ 
        apt-get install -y libcurl4-openssl-dev libxml2-dev libxslt1-dev python-lxml python-mysqldb libpq-dev && \
        apt-get install -y libjpeg-dev zlib1g-dev libpng12-dev
RUN pip install -U pip

# install requirements
RUN pip install http://cdn.mysql.com/Downloads/Connector-Python/mysql-connector-python-2.0.4.zip
ADD requirements.txt /opt/pyspider/requirements.txt
RUN pip install -r /opt/pyspider/requirements.txt
RUN pip install newspaper
RUN pip install urllib3
RUN pip install python-dateutil
RUN pip install articleDateExtractor
RUN pip install tldextract
RUN pip install elasticsearch_dsl
RUN pip install dateparser

# add all repo
ADD ./ /opt/pyspider

# run test
WORKDIR /opt/pyspider
RUN pip install -e .[all]

VOLUME ["/opt/pyspider"]
ENTRYPOINT ["pyspider"]

EXPOSE 5000 23333 24444 25555

