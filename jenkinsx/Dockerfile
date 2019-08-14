# custom image: https://github.com/jenkins-x/jenkins-x-image/releases
# installing plugins in jenkins 2.176.2
ARG JENKINSX_TAG=0.0.70
FROM jenkinsxio/jenkinsx:${ENKINSX_TAG}

COPY plugins.txt /usr/share/jenkins/ref/custom-plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/custom-plugins.txt