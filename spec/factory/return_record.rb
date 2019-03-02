module Factory
  class ReturnRecord
    def self.create(attributes)
      title = attributes[:title] || Faker::Book.title,
      author = attributes[:author] || Faker::Book.author,
      n_pages = attributes[:n_pages] || rand(100..1000),
      ddc = attributes[:ddc] || "#{rand(9)}#{rand(9)}#{rand(9)}",
      read_status = attributes[:read_status] || [:read, :unread, :partially_read].sample
      Littlefoot::ReturnRecord.new(title, author, n_pages, ddc, read_status)
    end
  end
end
