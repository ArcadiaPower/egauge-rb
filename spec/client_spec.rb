RSpec.describe Egauge::Client do
  let(:http_client) { HTTPClient.new }
  let(:url) { 'http://foo.com' }
  let(:params) { { :C => nil, :T => Time.current.beginning_of_day.to_i } }
  let(:response_body) { File.read('spec/fixtures/response.xml')  }
  let(:expected_query) { "/cgi-bin/egauge-show?C&T=#{Time.current.beginning_of_day.to_i}" }

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

   context "csv request" do
     let(:response_body) { File.read('spec/fixtures/response.csv') }
     let(:parsed_response) do
       [
         {
           "Date & Time" => "1539709200",
           "Usage [kWh]" => "0.000000000",
           "Generation [kWh]" => "150006.751666667",
           "Solar [kWh]" => "150006.751666667",
           "Solar+ [kWh]" => "150085.831640556"
         }
       ]
     end

     it "parses the response" do
       expect(subject.csv_query(params)).to eq(parsed_response)
     end
   end
end
