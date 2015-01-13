FROM debian:wheezy
MAINTAINER Tom Ruttle <tom@tomruttle.com>

ENV DEBIAN_FRONTEND noninteractive

# Install base packages
RUN apt-get update && \
    apt-get -yq install curl apache2 apache2-mpm-prefork

# Configure Apache
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

# Send Apache2's error logs to STDERR for Docker to pick up
RUN ln -sf /dev/stderr /var/log/apache2/error.log

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND", "-k", "start"]
