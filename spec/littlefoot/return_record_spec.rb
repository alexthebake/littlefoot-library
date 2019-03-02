require_relative '../../lib/littlefoot'
require_relative '../factory'

describe Littlefoot::ReturnRecord do
  describe "creating a record" do
    let(:title) { "American Psycho" }
    let(:author) { "Bret Easton Ellis" }
    let(:n_pages) { 400 }
    let(:ddc) { "812" }
    let(:read_status) { :read }
    let(:record) {
      Littlefoot::ReturnRecord.new(title, author, n_pages, ddc, read_status)
    }

    it 'properly sets and provides access to attributes' do
      expect(record.title).to eql(title)
      expect(record.author).to eq(author)
      expect(record.n_pages).to eq(n_pages)
      expect(record.ddc).to eq(ddc)
      expect(record.read_status).to eq(read_status)
    end
  end

  describe "#category?" do
    let!(:category_index) { rand(0..Littlefoot::DEWEY_DECIMAL_CATEGORIES.length - 1) }
    let!(:category) { Littlefoot::DEWEY_DECIMAL_CATEGORIES[category_index] }
    let(:record) { Factory::ReturnRecord.create(ddc: "#{category_index}00") }

    it 'returns true if category matches' do
      expect(record.category?(category)).to be true
    end

    it 'returns false if category does not match' do
      expect(record.category?("Hipster Fairy Tales")).to be false
    end
  end
end
