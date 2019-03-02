require 'json'
require_relative 'lib/littlefoot'

TITLE_WIDTH = 64
LIST_PADDING = 4

def print_list(title, items)
  max_width = items.map { |item| item[:label].length }.max

  puts title
  puts "=" * TITLE_WIDTH
  items.each do |item|
    label_width = item[:label].length
    padding_width = max_width - label_width + LIST_PADDING
    extra_padding = "." * padding_width
    puts item[:label] + extra_padding + item[:value].to_s
  end
  puts "\n"
end

def main
  input_filepath = ARGV[0]
  if input_filepath.nil?
    puts "Usage: ruby main.rb <input_json_filepath>"
    return
  end

  input_data = JSON.parse(File.read(input_filepath))
  records = input_data.map do |record|
    Littlefoot::ReturnRecord.new(
      record["title"],
      record["author"],
      record["n_pages"],
      record["ddc"],
      record["read_status"]
    )
  end

  reporter = Littlefoot::RecordReporter.new(records)

  print_list(
    "ALL RETURN RECORDS",
    [
      {
        label: "Total",
        value: reporter.total_pages_read
      }
    ]
  )

  print_list(
    "CATEGORY RETURN RECORDS",
    Littlefoot::DEWEY_DECIMAL_CATEGORIES.map do |category|
      {
        label: category,
        value: reporter.total_pages_read_for_category(category)
      }
    end
  )
end

main
