require "spec_helper"

describe Onebox::Engine::WayfairOnebox do
  let(:link) { "http://www.wayfair.com/daily-sales/p/foobar-Allison-Comforter-Set~MIZ1040~E20681.html" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("wayfair"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.wayfair.com/daily-sales/p/foobar-Allison-Comforter-Set~MIZ1040~E20681.html",
        title: "Mi-Zone Allison Comforter Set",
        image: "http://img1.wfrcdn.com/lf/50/hash/13559/9432842/1/Allison%2BComforter%2BSet.jpg",
        description: "The dazzling Mi-Zone Allison Comforter Set can help brighten up your room in an instant. This multi-colored set has a vivid floral pattern, with huge flow...",
        type: nil,
        price_cents: nil
      }
    )
  end
end
