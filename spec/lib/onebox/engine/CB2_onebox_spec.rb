require "spec_helper"

describe Onebox::Engine::CB2Onebox do
  let(:link) { "http://www.cb2.com/fleck-king-duvet-cover/s471508" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("cb2"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.cb2.com/fleck-king-duvet-cover/s471508",
        title: "fleck king duvet cover",
        image: "http://2i.c-b.co/is/image/CB2/FleckBeddingBWWhtShtF15",
        description: "soft spots.  Abstract screenprinted black dots scatter spontaneously on white to playful effect.  Duvet cover has nonslip corner ties and hidden button closure; reverses to solid white.  Dreamy with matching shams. 100% cottonRotary screenprintedNonslip corner ties and hidden button closureMachine wash cold.",
        image: "http://2i.c-b.co/is/image/CB2/FleckBeddingBWWhtShtF15",
        type: nil,
        price_cents: "9995",
        price: "$99.95"
      }
    )
  end
end
