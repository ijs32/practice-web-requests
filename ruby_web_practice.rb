require "http"

response = HTTP.get("https://github.com")

pp response.parse(:json)
