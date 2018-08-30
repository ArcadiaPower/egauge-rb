RSpec.describe Egauge::Client do
  let(:http_client) { HTTPClient.new }
  let(:url) { 'http://foo.com' }
  let(:params) { { :C => nil, :T => DateTime.now.beginning_of_day.to_i } }
  let(:response_body) { File.read('spec/fixtures/response.xml')  }
  let(:expected_query) { "/cgi-bin/egauge-show?C&T=#{DateTime.now.beginning_of_day.to_i}" }

  before do
    allow(HTTPClient).to receive(:new).and_return(http_client)
    allow(http_client).to receive_message_chain(:get, :body).and_return(response_body)
  end

  subject { described_class.new(url) }

  it "should make get request with query" do
    expect(http_client).to receive(:get).with(expected_query)
    subject.query(params)
  end

  it "should create a new response object" do
    expect(Egauge::Response).to receive(:new)
    subject.query(params)
  end

  it "should return a response object" do
    expect(subject.query(params)).to be_a(Egauge::Response)
  end
end
