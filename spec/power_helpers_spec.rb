RSpec.describe Egauge::PowerHelpers do
  let(:response_body) { File.read('spec/fixtures/response.xml')  }
  let(:response) { Egauge::Response.new(response_body) }
  let(:url) { "http://foo.com" }

  subject { Egauge::Client.new(url) }

  before { allow(subject).to receive(:query).and_return(response) }

  describe '#monthly_kwh' do

    let(:query_time) do
      Time.at(1533873600)
    end

    let(:expected_query) {
      {
        :C => nil,
        :T => "1533873600,1533096000,1530417600,1527825600,1525147200,1522555200,1519880400"
      }
    }
    it "should return monthly calculation of kwhs" do
      Timecop.freeze(query_time) do
        expect(subject).to receive(:query).with(expected_query)
        subject.monthly_kwh(6)
      end
    end
  end
end
