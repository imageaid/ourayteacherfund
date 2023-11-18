# frozen_string_literal: true

module Admin
  module UserSearchable
    extend ActiveSupport::Concern

    def search_scope(filters:, model_name: 'User', order: 'created_at DESC')
      klass = model_name.constantize
      klass.filter_by(filters).order(order)
    rescue StandardError
      model_name.constantize.none
    end
  end
end
