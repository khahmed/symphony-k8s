# Build: docker build -t spectrum-symphony:7.2 .
FROM centos:7.2.1511
MAINTAINER Joe Smith <jsmith@example.com>

ENV CLUSTERADMIN egoadmin
ENV CLUSTERNAME symphony
ENV BASEPORT 17869
ENV DISABLESSL Y
ENV SIMPLIFIEDWEM N
ENV LANG en_CA.UTF-8
ENV SYM_INSTALL_PKG sym-7.2.0.0_x86_64.bin 
ENV REPO_URL=http://158.85.106.44/export/symphony/7.2.0.0/

RUN useradd egoadmin
RUN yum install -y gettext net-tools gawk which sudo tar wget

RUN cd /;wget --quiet --no-proxy ${REPO_URL}/${SYM_INSTALL_PKG};chmod 755 /${SYM_INSTALL_PKG};/${SYM_INSTALL_PKG} --quiet; rm -f /${SYM_INSTALL_PKG}

COPY bootstrap.sh /bootstrap.sh
RUN chmod 755 /bootstrap.sh

CMD /bootstrap.sh


