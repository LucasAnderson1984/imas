# frozen_string_literal: true

require_relative 'config/application'
require 'rubocop/rake_task'
require 'scss_lint/rake_task'

Rails.application.load_tasks
RuboCop::RakeTask.new
SCSSLint::RakeTask.new

task default: %i[rubocop test scss_lint]
