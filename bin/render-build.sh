#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bin/rails assets:precompile
bin/rails assets:clean
bin/rails db:seed
bin/rails db:migrate