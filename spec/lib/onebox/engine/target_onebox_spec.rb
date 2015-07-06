require "spec_helper"

describe Onebox::Engine::TargetOnebox do
  let(:link) { "http://www.target.com/p/threshold-fretwork-rug/-/A-14795740#prodSlot=_1_1" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("target"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.target.com/p/threshold-fretwork-rug/-/A-14795740#prodSlot=_1_1",
        title: "Caribbean Patio Hammock Chair",
        image: "http://Img1.targetimg1.com/wcsstore/TargetSAS//img/p/14/51/14516270_130402183000_100x100.jpg",
        description: "Enjoy the perfect place to read, relax, nap or catch some rays with the Caribbean patio hammock chair. Made from soft, tightly-woven polyester rope, it allows you to stretch out, curl up and everything in between. This burgundy hammock chair's 44-inch spreader bar holds it open for easy entrance and exit. Chair stands and hanging hardware are sold separately.",
        type: "product",
        price_cents: "6099"
      }
    )
  end
end
