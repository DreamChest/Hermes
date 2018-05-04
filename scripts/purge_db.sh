#!/bin/sh

echo "This script will drop dev, prod and test databases in 5 seconds..."
sleep 5

RAILS_ENV=development rake db:drop
RAILS_ENV=test rake db:drop
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=production rake db:drop

exit 0
