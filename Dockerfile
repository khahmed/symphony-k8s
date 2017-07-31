# Build: docker build -t spectrum-symphony:7.2 .
FROM centos:7.2.1511
MAINTAINER Joe Smith <jsmith@example.com>

ENV CLUSTERADMIN egoadmin
ENV CLUSTERNAME symphony
ENV BASEPORT 17869
ENV DISABLESSL Y
ENV SIMPLIFIEDWEM N
ENV LANG en_CA.UTF-8
ENV SYM_INSTALL_PKG symeval-7.2.0.0_x86_64.bin 

RUN useradd egoadmin
RUN yum install -y gettext net-tools gawk which sudo tar wget

RUN cd /;wget --quiet --no-proxy http://9.21.58.23:9191/${SYM_INSTALL_PKG};chmod 755 /${SYM_INSTALL_PKG};/${SYM_INSTALL_PKG} --quiet; rm -f /${SYM_INSTALL_PKG}

COPY bootstrap.sh /bootstrap.sh
COPY profile.ego /profile.ego
RUN chmod 755 /bootstrap.sh

CMD /bootstrap.sh


