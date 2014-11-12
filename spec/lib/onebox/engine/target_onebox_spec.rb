require "spec_helper"

describe Onebox::Engine::TargetOnebox do
  let(:link) { "http://www.target.com/p/natural-dining-collection/-/A-16368287" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("target"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.target.com/p/natural-dining-collection/-/A-16368287",
        title: "Natural Dining Collection",
        image: "http://Img3.targetimg3.com/wcsstore/TargetSAS//img/p/16/36/16368287_201409082103_100x100.jpg",
        description: "Natural Dining Collection",
        type: "product",
        price_cents: nil
      }
    )
  end
end
