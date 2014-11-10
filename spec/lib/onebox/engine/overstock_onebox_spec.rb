require "spec_helper"

describe Onebox::Engine::OverstockOnebox do
  let(:link) { "http://www.overstock.com/Home-Garden/Baxton-Studio-Keswick-Beige-Linen-Modern-Tufted-Ottoman/7818917/product.html?refccid=O7JN2EIF7HGKJO2ALGZ4FCB7M4&searchidx=6" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("overstock"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.overstock.com/Home-Garden/Baxton-Studio-Keswick-Beige-Linen-Modern-Tufted-Ottoman/7818917/product.html?refccid=O7JN2EIF7HGKJO2ALGZ4FCB7M4&searchidx=6",
        title: "LP Gas Outdoor Firebowl with Tile | Overstock.com Shopping - The Best Deals on Fireplaces & Chimineas",
        image: "http://ak1.ostkcdn.com/images/products/7011497/7011497/LP-Gas-Outdoor-Firebowl-with-Tile-T14518574.jpg",
        description: "Shop for LP Gas Outdoor Firebowl with Tile. Get 5% in rewards with Club O and free delivery at Overstock - Your Online Garden & Patio Outlet Store!",
        type: "product",
        price_cents: "22131"
      }
    )
  end
end
