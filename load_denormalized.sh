#!/bin/sh

file="$1"

unzip -p "$file" | sed 's/\\u0000//g' | PGPASSWORD=pass psql \
    -h localhost \
    -p 2585 \
    -U postgres \
    -d postgres \
    -c "COPY tweets_jsonb (data) FROM STDIN WITH (FORMAT csv, DELIMITER E'\x01', QUOTE E'\x02');"
