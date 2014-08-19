require "spec_helper"

describe Onebox::Engine::TargetOnebox do
  let(:link) { "http://www.target.com/p/mirrored-side-table/-/A-11247062" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("target"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.target.com/p/mirrored-side-table/-/A-11247062",
        title: "Mirrored Side Table",
        image: "http://Img2.targetimg2.com/wcsstore/TargetSAS//img/p/11/24/11247062_100x100.jpg",
        description: "This eye&#45;catching side table is sure to be a conversation piece when placed in your living room or bedroom&#46; The mirrored finish on a steel frame make this small contemporary accent piece truly stand out&#46;",
        type: "product",
        price_cents: "9999"
      }
    )
  end
end
