#!/bin/sh

RAILS_ENV=development rake db:drop
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=production rake db:drop

exit 0
