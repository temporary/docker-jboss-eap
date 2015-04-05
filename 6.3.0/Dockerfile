# Steps taken to create this image
# docker build --rm -t jboss/jboss_eap:6.3.0  .
# docker run -p 9990:9990 -p 9999:9999 -p 8080:8080 -it jboss/jboss_eap:6.3.0
# 
# Get required ZIP file from: https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=32483&product=appplatform
#
#
FROM dockerfile/java:oracle-java7

RUN mkdir /opt/jboss \
    && groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -d /opt/jboss -s /sbin/nologin -c "JBoss user in Docker" jboss \
    && chown -R jboss:jboss /opt/jboss

WORKDIR /opt/jboss

ENV HOME /opt/jboss

USER jboss

ADD files/jboss-eap-6.3.0.zip /tmp/
RUN unzip /tmp/jboss-eap-6.3.0.zip -d /opt/jboss

# Add EAP_HOME environment variable, to easily upgrade the script for different EAP versions
ENV EAP_HOME /opt/jboss/jboss-eap-6.3

# Add default admin user
RUN ${EAP_HOME}/bin/add-user.sh admin admin123! --silent

# Configure Java Flight Recorder
RUN mkdir -p /tmp/jboss/jfr \
    && echo "JAVA_OPTS=\"\$JAVA_OPTS -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -XX:FlightRecorderOptions=defaultrecording=true,dumponexit=true,dumponexitpath=/tmp/jboss/jfr\"" >> ${EAP_HOME}/bin/standalone.conf

# Add volume if you want to externalize Java Flight recordings
VOLUME /tmp/jboss/jfr

#
# Explicitly set RMI hostname to 'localhost'. Otherwise, RMI picks up
# dynamic IP address assigned to this Docker container
#
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS \
 -Djava.rmi.server.hostname=localhost\"" >> ${EAP_HOME}/bin/standalone.conf

# Enable binding to all network interfaces and debugging inside the EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> ${EAP_HOME}/bin/standalone.conf

# Add volume if you want to externalize logs
VOLUME ${EAP_HOME}/standalone/logs

EXPOSE 9990 9999 8080 8787 7091

ENTRYPOINT ["/opt/jboss/jboss-eap-6.3/bin/standalone.sh"]
CMD []
