require "spec_helper"

describe Onebox::Engine::OneKingsLaneOnebox do
  let(:link) { "https://www.onekingslane.com/product/41490/692699?cat=36" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("okl"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "https://www.onekingslane.com/product/41490/692699?cat=36",
        title: "Silva Table Lamp, White Shade",
        image: "https://okl-scene7.insnw.net/is/image/OKL/Product_PJP10008_Image_1?wid=1200&hei=627",
        description: "The design of this clean and modern lamp is inspired by the structural connection between metal and wood. This is clearly exhibited in the dynamic tri-leg base made of walnut and aluminum. Energy...",
        type: "website",
        price_cents: "35500"
      }
    )
  end
end
