# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id
  attributes :first_name
  attributes :last_name
  attributes :user_name
  attributes :email
  attributes :is_admin
  attributes :role
end
