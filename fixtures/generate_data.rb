require 'json'
require 'faker'
require_relative '../lib/littlefoot'

N = 10

records = (1..N).map do
  Littlefoot::ReturnRecord.new(
    # title
    Faker::Book.title,
    # author
    Faker::Book.author,
    # n_pages
    rand(100..1000),
    # ddc
    "#{rand(9)}#{rand(9)}#{rand(9)}",
    # read_status
    [:read, :unread, :partially_read].sample
  ).to_h
end

puts records.to_json
