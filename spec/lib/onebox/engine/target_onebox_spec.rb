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
        title: "Threshold™ Fretwork Rug",
        image: "http://Img3.targetimg3.com/wcsstore/TargetSAS//img/p/14/31/14318370_201405081539_100x100.jpg",
        description: "Take your space from tired to tasteful with the Threshold Fretwork Area Rug. This simple rug in soft, neutral hues is ideal for an old space or worn out flooring that just needs a throw rug to freshen it up. The simple fretwork styling on this indoor rug adds a nice pattern to your room, but wont interrupt or distract from your current décor. The nylon rug resists stains and can be spot cleaned for stains and should be vacuumed regularly to maintain its luster. The latex back gives you added traction to prevent slips and trips. Pick the room rug size that is best suited for your space and love the results.",
        type: "product",
        price_cents: nil
      }
    )
  end
end
