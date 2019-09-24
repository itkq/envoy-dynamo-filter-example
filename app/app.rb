require 'aws-sdk-dynamodb'
require 'faraday'
require 'sinatra'
require "sinatra/json"

helpers do
  def conn
    @conn ||= Faraday.new(
      url: ENV.fetch('BACKEND_URL', 'http://backend'),
      headers: { 'Host' => ENV['BACKEND_HOST'] },
    )
  end

  def dynamodb
    @dynamodb ||= Aws::DynamoDB::Client.new(
      log_level: :debug,
      region: ENV.fetch('AWS_REGION', 'ap-northeast-1'),
      endpoint: ENV.fetch('DYNAMODB_ENDPOINT', 'https://dynamodb.ap-northeast-1.amazonaws.com/'),
    )
  end

  def table_name
    ENV.fetch('DYNAMODB_TABLE_NAME')
  end
end

set :bind, '0.0.0.0'

get '/' do
  'OK'
end

get '/backend' do
  resp = conn.get('/')
  resp.body
end

get '/dynamo' do
  resp = dynamodb.describe_table(table_name: table_name)
  resp.inspect
end
