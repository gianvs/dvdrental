FROM postgres
ENV POSTGRES_PASSWORD post123
COPY data/dvdrental.tar /docker-entrypoint-initdb.d
ADD data/init.sh /docker-entrypoint-initdb.d
