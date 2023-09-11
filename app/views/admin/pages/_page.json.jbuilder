json.extract! page, :id, :title, :keywords, :body, :created_at, :updated_at
json.url page_url(page, format: :json)
json.body page.body.to_s
