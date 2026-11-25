#!/bin/bash

files=$(find data/*)

echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    echo
    unzip -p "$file" | sed 's/\\u0000//g' | PGPASSWORD=pass psql \
    -h localhost \
    -p 2585 \
    -U postgres \
    -d postgres \
    -c "COPY tweets_jsonb (data) FROM STDIN WITH (FORMAT csv, DELIMITER E'\x01', QUOTE E'\x02');"
    # copy your solution to the twitter_postgres assignment here
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
    echo
    python3 load_tweets.py \
        --db postgresql://postgres:pass@localhost:2586/postgres \
        --inputs "$file"
    # copy your solution to the twitter_postgres assignment here
done

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:2587/ --inputs $file
done
