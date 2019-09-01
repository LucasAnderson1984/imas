# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2] # :nodoc:
  def change
    create_table(:users) do |t|
      user_setup t

      t.timestamps null: false

      user_indexes t
      invitable_indexes t
    end
  end

  def confirmable_columns(table)
    table.string :confirmation_token
    table.datetime :confirmed_at
    table.datetime :confirmation_sent_at
    table.string :unconfirmed_email
    table.integer :failed_attempts, default: 0, null: false
    table.string :unlock_token
    table.datetime :locked_at
  end

  def invitable_columns(table)
    table.string :invitation_token
    table.datetime :invitation_created_at
    table.datetime :invitation_sent_at
    table.datetime :invitation_accepted_at
    table.integer :invitation_limit
    table.references :invited_by, polymorphic: true
    table.integer :invitations_count, default: 0
  end

  def invitable_indexes(table)
    table.index :invitations_count
    table.index :invitation_token, unique: true
    table.index :invited_by_id
  end

  def lockable_columns(table)
    table.integer :failed_attempts, default: 0, null: false
    table.string :unlock_token
    table.datetime :locked_at
  end

  def recoverable_colums(table)
    table.string :reset_password_token
    table.datetime :reset_password_sent_at
  end

  def sign_in_columns(table)
    table.integer :sign_in_count, default: 0, null: false
    table.datetime :current_sign_in_at
    table.datetime :last_sign_in_at
    table.string :current_sign_in_ip
    table.string :last_sign_in_ip
  end

  def user_columns(table)
    table.string :uuid, null: false
    table.string :name, null: false
    table.integer :is_active, default: 1, null: false
    table.string :email, null: false
    table.string :encrypted_password
    table.datetime :remember_created_at
  end

  def user_indexes(table)
    table.index :email, unique: true
    table.index :reset_password_token, unique: true
    table.index :uuid, unique: true
  end

  def user_setup(table)
    user_columns table
    confirmable_columns table
    recoverable_colums table
    sign_in_columns table
    lockable_columns table
    invitable_columns table
  end
end
