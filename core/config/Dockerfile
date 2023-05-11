# syntax=docker/dockerfile-upstream:1.4.3

# config image
FROM base

ARG VERSION=local
LABEL version=$VERSION

RUN set -euxo pipefail \
  ; apk add --no-cache libressl

COPY --from=assets /work/static/ ./mailu/static/

COPY start.py /

COPY mailu/ ./mailu/

RUN echo $VERSION >/version

#EXPOSE 80/tcp
HEALTHCHECK CMD curl -skfLo /dev/null http://localhost/ping

ENV FLASK_APP=mailu
CMD /start.py
