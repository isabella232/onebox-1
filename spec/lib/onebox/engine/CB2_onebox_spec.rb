require "spec_helper"

describe Onebox::Engine::CB2Onebox do
  let(:link) { "http://www.cb2.com/all-dining/dining/platform-dinnerware/f8412" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("cb2"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.cb2.com/all-dining/dining/platform-dinnerware/f8412",
        title: "platform dinnerware",
        image: "http://2i.c-b.co/is/image/CB2/PlatformRepImageS13",
        description: "flare and square.  Slick white handmade porcelain flares with mitered edges.  Inner rim on plates rises subtly to frame creative presentations.  Big bowl serves up soup to salad. Handmade porcelain dipped in white glazeDishwasher-, microwave- and oven-safeMade in China.",
        type: nil,
        price_cents: 12345
      }
    )
  end
end
