
# d2i
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER William Benton <willb@redhat.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 1.0

ENV MINIO_ACCESS_KEY username
ENV MINIO_SECRET_KEY password

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="ephemeral minio object store" \
    io.k8s.display-name="ephemeral minio" \
    io.openshift.expose-services="9000" \
    io.openshift.tags="builder,data,minio" \
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

ADD ./minio.tar.gz /

RUN mkdir -p /opt/minio/data/example 

RUN echo "the quick brown fox jumps over the lazy dog" > /opt/minio/data/example/sentence.txt

COPY ./.s2i/bin/ /usr/libexec/s2i

RUN chown -R 1001:1001 /opt/

# This default user is created in the openshift/base-centos7 image
USER 1001

EXPOSE 9000

# TODO: Set the default CMD for the image
CMD ["usage"]
