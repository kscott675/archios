# frozen_string_literal: true

json.extract! status, :id, :text, :created_at, :updated_at
json.url status_url(status, format: :json)
