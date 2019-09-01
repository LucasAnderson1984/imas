# frozen_string_literal: true

namespace :users do
  desc 'Creates a new user'
  task(:create, %i[name email password] => :environment) do |_task, args|
    ActiveRecord::Migration.check_pending!

    logger = ActiveSupport::Logger.new(STDOUT)
    logger.level = Figaro.env.LOG_LEVEL
    logger.info('Create user:')
    logger.info("\tName #{args.name}")
    logger.info("\tEmail #{args.email_address}")
    logger.info("\tSkip Confirmation? #{args.skip_confirmation}")

    user = User.find_by(email: args.email)

    user ||= User.new do |u|
      u.uuid = SecureRandom.uuid
      u.email = args.email
      u.name = args.name
      u.password = args.password
      u.password_confirmation = args.password
    end

    user.save!

    logger.info("\tUser created: #{user.name} (#{user.uuid})")
  end
end
