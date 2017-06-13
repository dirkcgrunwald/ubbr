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

RUN  cd /opt && \
     mkdir ubbr && \
     mv engine ubbr && \
     touch ubbr/__init__.py && \
     mv ubbr ubbr_webapp && \
     ls -lR

ENV SAGE_LOCAL=/usr/lib/sagemath/local
ENV SINGULAR_EXECUTABLE=/usr/lib/sagemath/local/bin/Singular

RUN mkdir -p /opt && \
    cd /opt/  && \
    $SAGE_LOCAL/bin/pip install django
#    $SAGE_LOCAL/bin/pip install setuptools && \
#    $SAGE_LOCAL/bin/pip install -v --log /tmp/pip.log --upgrade -r requirements.txt

VOLUME /opt
WORKDIR /opt

EXPOSE 8000

CMD [ "/usr/lib/sagemath/local/bin/python2.7", "ubbr_webapp/manage.py", "runserver", "0.0.0.0:8000"]
