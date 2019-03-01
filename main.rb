READ_STATUS = {
  read: :read,
  unread: :unread,
  partially_read: :partially_read
}

DEWEY_DECIMAL_CATEGORIES = [
  "Computer Science, Information & General Works",
  "Philosophy & Psychology",
  "Religion",
  "Social Sciences",
  "Language",
  "Pure Science",
  "Applied Science",
  "Arts & Recreation",
  "Literature",
  "History & Geography"
]

class ReturnRecord < Struct.new(:title,
                                :author,
                                :n_pages,
                                :ddc,
                                :read_status)
  def matches_category?(category)
    category_index = DEWEY_DECIMAL_CATEGORIES.index(category)
    Integer(ddc[0]) == category_index
  end
end

class RecordReporter
  def initialize(records)
    @records = records
  end

  def total_pages_read
    pages_read_for_records(@records)
  end

  def total_pages_read_for_category(category)
    category_records = @records.select do |record|
      record.matches_category?(category)
    end
    pages_read_for_records(category_records)
  end

  private

  def pages_read_for_record(record)
    return 0 if record.read_status == :unread
    if record.read_status == :partially_read
      record.n_pages / 2
    else
      record.n_pages
    end
  end

  def pages_read_for_records(records)
    records
      .map { |record| pages_read_for_record(record) }
      .reduce(0, :+)
  end
end