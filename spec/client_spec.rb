RSpec.describe Egauge::Client do
  context "fetch" do
    let(:options) do
      {
        end_time: Time.at(1539709500),
        granularity: "hour",
        iterations: 3
      }
    end

    let(:http_client) { HTTPClient.new }
    let(:url) { 'http://foo.com' }
    let(:response_body) { File.read('spec/fixtures/response.csv') }

    subject { described_class.new(url) }

    before do
      allow(HTTPClient).to receive(:new).and_return(http_client)
    end

    context "building the parameters" do
      let(:response_body) { double(body: "") }

      it "builds the query params" do
        expect(http_client).to receive_message_chain(:get)
          .with("/cgi-bin/egauge-show?T=1539709200,1539705600,1539702000&c")
          .and_return(response_body)
        subject.fetch(options)
      end
    end

    context "parsing the results" do
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

      before do
        allow(http_client).to receive_message_chain(:get, :body)
          .and_return(response_body)
      end

      it "fetches and parses the response" do
        expect(subject.fetch(options)).to eq(parsed_response)
      end
    end
  end
end
