RSpec.describe Egauge::PowerHelpers do
  let(:response_body) { File.read('spec/fixtures/response.xml')  }
  let(:response) { Egauge::Response.new(response_body) }
  let(:url) { "http://foo.com" }

  subject { Egauge::Client.new(url) }

  before { allow(subject).to receive(:query).and_return(response) }

  describe '#monthly_kwh' do
    let(:expected_query) {
      {
        :C => nil,
        :T => "#{Time.now.to_i},1533096000,1530417600,1527825600,1525147200,1522555200,1519880400"
      }
    }
    it "should return a full day calculation of kwhs" do
      expect(subject).to receive(:query).with(expected_query)
      subject.monthly_kwh(6)
    end
  end
end
