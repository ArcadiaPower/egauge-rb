RSpec.describe Egauge::PowerHelpers do
  let(:response_body) { File.read('spec/fixtures/response.xml')  }
  let(:response) { Egauge::Response.new(response_body) }
  let(:url) { "http://foo.com" }
  let(:expected_kwh) { { "solar" => 229, "solar_" => 230} }
  subject { Egauge::Client.new(url) }

  before { allow(subject).to receive(:query).and_return(response)}

  it "should return a full day calculation of kwhs" do
    expect(subject.full_day_kwh).to eq(expected_kwh)
  end
end
