#!/bin/bash
psql -U postgres -c "CREATE DATABASE dvdrental;"
pg_restore -U postgres -d dvdrental /docker-entrypoint-initdb.d/dvdrental.tar
