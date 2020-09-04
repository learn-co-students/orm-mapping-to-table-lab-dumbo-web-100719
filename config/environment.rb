require 'bundler'
Bundler.require

require_relative '../lib/student'

# create a constant for connection to DB
DB = {:conn => SQLite3::Database.new('db/students.db')}

# referral to database(DB)
# DB[:conn]
