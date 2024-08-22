#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
   rm tmp/pids/server.pid
fi

bundle exec rails s -p $PORT -b 0.0.0.0