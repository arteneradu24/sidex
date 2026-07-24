#!/bin/bash
set -e

# Remove stale pid file
rm -f tmp/pids/server.pid

# Wait for PostgreSQL
if [ -n "$DATABASE_URL" ]; then
  echo "Waiting for database..."
  until pg_isready -d "$DATABASE_URL" > /dev/null 2>&1; do
    sleep 1
  done
  echo "Database is ready."
fi

# Install gems if Gemfile changed (development volume mount)
bundle check || bundle install

# Prepare database
bundle exec rails db:prepare

# Seed if no admin user exists
bundle exec rails runner "exit(User.exists? ? 0 : 1)" || bundle exec rails db:seed

# Build Tailwind CSS
bundle exec rails tailwindcss:build

exec "$@"
