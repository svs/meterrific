ENV['DATABASE_URL'] = "sqlite::memory:"
require 'awesome_print'
require 'bundler/setup'
require 'debugger'
require_relative '../lib/cabmeter.rb'
DataMapper.auto_migrate!
