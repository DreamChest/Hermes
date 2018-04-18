#!/bin/sh

export RAILS_ENV=production

if ! [ -e .secret_key_base ]
then
  rake secret > .secret_key_base
fi

SECRET_KEY_BASE=$(cat .secret_key_base)
export SECRET_KEY_BASE

rake db:migrate

exit 0
