require "spec_helper"

describe Onebox::Engine::IkeaOnebox do
  let(:link) { "http://www.ikea.com/us/en/catalog/products/S89826677/" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("ikea"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.ikea.com/us/en/catalog/products/S89826677/",
        title: "BERNHARD, Bar stool with backrest",
        image: "http://www.ikea.com/us/en/images/products/bernhard-bar-stool-with-backrest-yellow__0243102_PE382439_S4.JPG",
        description: "You sit comfortably thanks to the restful flexibility of the seat.You sit comfortably thanks to the padded seat.Soft, hardwearing and easy care leather, which ages gracefully.",
        type: "product",
        price_cents: "16900"
      }
    )
  end
end
