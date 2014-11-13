require "spec_helper"

describe Onebox::Engine::WorldMarketOnebox do
  let(:link) { "http://www.worldmarket.com/product/holiday+bird+coir+doormat.do?&from=fn" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("worldmarket"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.worldmarket.com/product/holiday+bird+coir+doormat.do?&from=fn",
        title: "Holiday Bird Coir Doormat",
        image: "http://ii.worldmarket.com/fbog/500/43435_XXX_v1.jpg?Holiday-Bird-Coir-Doormat",
        description: "Crafted of coconut husk fibers and printed with our exclusive holiday design, our Holiday Bird Coir Doormat adds a perfect seasonal welcome at a great price.",
        type: "product",
        price_cents: "999"
      }
    )
  end
end
