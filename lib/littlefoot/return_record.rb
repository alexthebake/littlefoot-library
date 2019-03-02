module Littlefoot
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

  class ReturnRecord < Struct.new(
    :title,
    :author,
    :n_pages,
    :ddc,
    :read_status
  )
    def category?(category)
      category_index = DEWEY_DECIMAL_CATEGORIES.index(category)
      Integer(ddc[0]) == category_index
    end
  end
end