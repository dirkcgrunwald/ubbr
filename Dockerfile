FROM ubuntu
MAINTAINER grunwald@cs.colorado.edu

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl git \
    python-pip software-properties-common python-software-properties


RUN apt-add-repository -y ppa:aims/sagemath && \
    apt-get update && \
    apt-get install -y sagemath-upstream-binary

ADD . /opt

RUN mkdir -p /opt && \
    cd /opt/  && \
    pip install --upgrade pip && \
    pip install setuptools && \
    pip install -v --log /tmp/pip.log --upgrade -r requirements.txt


VOLUME /opt
WORKDIR /opt/ubber_webapp

EXPOSE 8000

#ADD  imagefiles-build/entrypoint.sh /run
#ADD  runestone-build /run

CMD [ "/usr/bin/python", "manage.py", "runserver"]
