require "spec_helper"

describe Onebox::Engine::WayfairOnebox do
  let(:link) { "http://www.wayfair.com/Arcadia-Garden-Products-Round-Wall-Planter-WP0-AGPR1028.html" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("wayfair"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.wayfair.com/Arcadia-Garden-Products-Round-Wall-Planter-WP0-AGPR1028.html",
        title: "Arcadia Garden Products Round Wall Planter",
        image: "http://img1.wfrcdn.com/lf/48/hash/21163/6979014/1/Arcadia-Garden-Products-Round-Wall-Planter.jpg",
        description: "Free Shipping when you buy Arcadia Garden Products Round Wall Planter at Wayfair - Great Deals on all Patio  and  Garden products with the best selection to choose from!",
        type: "wayfairus:product",
        price_cents: "1236"
      }
    )
  end
end
