# littlefoot-library
## Instructions
### Installation
To run tests and generate some data, you'll need to install a few gems. Using
bundler, you can simply run:
```
bundle
```

### Usage
This program accepts a JSON file with return record data following [this schema][1].
Check out the [sample data][2] for an example.
```
$ ruby main.rb <input_json_filepath>
```

### Tests
```
bundle exec rspec
```

## System Definition
### Return Record
For each book that is returned, the system needs to record the following information:
- Title
- Author
- Number of pages
- Dewey Decimal Number
- If the book was read, partially read, or unread

### Reporting Capabilities
With the information entered into the system, it should be able to:
- Compile the total number of pages read.
- Report the total number of pages read in each Dewey Decimal System category.
  - When a book is “partially read” we will only put half of the pages (total pages
/ 2) toward the total count.

### Dewey Decimal Classification
For your convenience, here are the Dewey Decimal System’s categories:
- 000 – Computer Science, Information & General Works
- 100 – Philosophy & Psychology
- 200 – Religion
- 300 – Social Sciences
- 400 – Language
- 500 – Pure Science
- 600 – Applied Science
- 700 – Arts & Recreation
- 800 – Literature
- 900 – History & Geography

[1]: input_schema.json
[2]: fixtures/sample_data.json