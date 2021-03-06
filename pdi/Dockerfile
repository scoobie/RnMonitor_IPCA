FROM openjdk:8
MAINTAINER Rolando Azevedo rolando.a@sapo.pt

# Set Environment Variables
ENV PDI_VERSION=7.1 PDI_BUILD=7.1.0.0-12 \
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/data-integration \
	KETTLE_HOME=/data-integration \
	POSTGRESQL_DRIVER_VERSION=42.1.1

# Download PDI
RUN wget --progress=dot:giga http://downloads.sourceforge.net/project/pentaho/Data%20Integration/${PDI_VERSION}/pdi-ce-${PDI_BUILD}.zip \
	&& unzip -q *.zip \
	&& rm -f *.zip \
	&& mkdir /jobs

# Aditional Drivers
WORKDIR $KETTLE_HOME

RUN  wget --progress=dot:giga https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_DRIVER_VERSION}.jre6.jar \
    && rm -f lib/postgre*.jar \
    && mv *.jar lib/. \
    && wget https://downloads.sourceforge.net/project/jtds/jtds/1.3.1/jtds-1.3.1-dist.zip \
	&& unzip jtds-1.3.1-dist.zip -d lib/ \
	&& rm jtds-1.3.1-dist.zip \
	&& wget https://github.com/FirebirdSQL/jaybird/releases/download/v3.0.4/Jaybird-3.0.4-JDK_1.8.zip \
	&& unzip Jaybird-3.0.4-JDK_1.8.zip -d lib \
	&& rm -rf lib/docs/ Jaybird-3.0.4-JDK_1.8.zip

# First time run
RUN kitchen.sh -file samples/transformations/files/test-job.kjb

COPY entrypoint.sh /
RUN ["chmod","+x","/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]