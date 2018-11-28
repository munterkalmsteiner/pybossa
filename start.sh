#! /bin/sh

source env/bin/activate
redis-server &
redis-server contrib/sentinel.conf --sentinel
python run.py
