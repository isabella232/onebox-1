require "spec_helper"

describe Onebox::Engine::CrateAndBarrelOnebox do
  let(:link) { "http://www.crateandbarrel.com/rugs/all-rugs/mischa-9x12-rug/s639320" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("crate"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.crateandbarrel.com/rugs/all-rugs/mischa-9x12-rug/s639320",
        title: "Mischa 9'x12' Rug",
        image: "http://i.c-b.co/is/image/Crate/Mischa9x12RugS14",
        description: "Paired triangles scatter dusky grey on charcoal in Josi Severson's chic, minimalist composition.  Cut pile sets the background for a thicker yarn that is looped to create the pattern, handcrafted by skilled artisans. Note: Some sizes of this rug are not available forday-of-purchase pickup at our Stores. A store associate can arrange a convenient pickup or delivery date.",
        type: nil,
        price_cents: "119900"
      }
    )
  end
end
