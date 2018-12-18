#! /bin/sh

source env/bin/activate
redis-server &
redis-server contrib/sentinel.conf --sentinel
python app_context_rqworker.py scheduled_jobs super high medium low email maintenance &
python run.py
