require_relative '../../lib/littlefoot'
require_relative '../factory'

describe Littlefoot::RecordReporter do
  describe '#total_pages_read' do
    let(:records) {
      [
        Factory::ReturnRecord.create(n_pages: 100, read_status: :read),
        Factory::ReturnRecord.create(n_pages: 100, read_status: :unread),
        Factory::ReturnRecord.create(n_pages: 100, read_status: :partially_read)
      ]
    }
    let(:reporter) { Littlefoot::RecordReporter.new(records) }

    it 'correctly sums `read` and `partially_read` records' do
      # Each of our books have 100 pages.
      # One of them is read (+100), one is unread (+0), and the last one is
      # partially read (+50), so we should get 150 total pages read
      expect(reporter.total_pages_read).to eql(150)
    end
  end

  describe "#total_pages_read_for_category" do
    let(:category) { Littlefoot::DEWEY_DECIMAL_CATEGORIES[0] }
    let(:records) {
      [
        Factory::ReturnRecord.create(n_pages: 100, ddc: "012", read_status: :read),
        Factory::ReturnRecord.create(n_pages: 100, ddc: "034", read_status: :unread),
        Factory::ReturnRecord.create(n_pages: 100, ddc: "567", read_status: :partially_read)
      ]
    }
    let(:reporter) { Littlefoot::RecordReporter.new(records) }

    context "valid category" do
      it 'correctly sums only records from the given category' do
        # Each of our books have 100 pages.
        # Two of them start with "0", which is our dewey decimal category.
        # One of those is read (+100), but the other is unread (+0), so we
        # should get 100 total pages read
        expect(reporter.total_pages_read_for_category(category)).to eql(100)
      end
    end

    context "invalid category" do
      it 'returns 0' do
        # No reason to count pages read for invalid categories
        expect(reporter.total_pages_read_for_category("E-Sports & Board Games")).to eql(0)
      end
    end
  end
end