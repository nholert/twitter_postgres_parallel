#!/bin/sh

file="$1"

python3 load_tweets.py \
    --db postgresql://postgres:pass@localhost:2586/postgres \
    --inputs "$file"
