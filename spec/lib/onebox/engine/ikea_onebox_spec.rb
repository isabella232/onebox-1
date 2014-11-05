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
        title: "AKURUM",
        image: "http://www.ikea.com/us/en/images/products/akurum-base-cab-for-domsjo--bowl-sink__28343_PE114994_S4.JPG",
        description: "IKEA - AKURUM, Base cab for DOMSJÖ 2 bowl sink, white, Ädel medium brown, 36",
        type: "product",
        price_cents: "19500"
      }
    )
  end
end
