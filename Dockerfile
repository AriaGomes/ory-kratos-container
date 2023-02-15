FROM alpine

# Because this image supports SQLite, we create /home/ory and /home/ory/sqlite which is owned by the ory user
# and declare /home/ory/sqlite a volume.
#
# To get SQLite and Docker Volumes working with this image, mount the volume where SQLite should be written to at:
#
#   /home/ory/sqlite/some-file.

RUN addgroup -S ory; \
    adduser -S ory -G ory -D -u 10000 -h /home/ory -s /bin/nologin; \
    chown -R ory:ory /home/ory
RUN apk --update upgrade && apk --no-cache --update-cache --upgrade --latest add ca-certificates

WORKDIR /home/ory

COPY kratos /usr/bin/kratos
COPY ./ /home/ory

# By creating the sqlite folder as the ory user, the mounted volume will be owned by ory:ory, which
# is required for read/write of SQLite.
RUN mkdir -p /var/lib/sqlite
RUN chown ory:ory /var/lib/sqlite

# Declare the standard ports used by Kratos (4433 for public service endpoint, 4434 for admin service endpoint)
EXPOSE 4433 4434

RUN chmod +x /home/ory/launch.sh
CMD /home/ory/launch.sh
