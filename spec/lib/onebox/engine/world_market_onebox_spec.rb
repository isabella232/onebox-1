require "spec_helper"

describe Onebox::Engine::WorldMarketOnebox do
  let(:link) { "http://www.worldmarket.com/product/bronze+perforated+hanging+pendant+lamp.do?&from=fn" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("worldmarket"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.worldmarket.com/product/bronze+perforated+hanging+pendant+lamp.do?&from=fn",
        title: "Bronze Perforated Hanging Pendant Lamp",
        image: "http://ii.worldmarket.com/fbog/500/40961_XXX_v1.jpg?Bronze-Perforated-Hanging-Pendant-Lamp",
        description: "Pierced with precision pinholes in varying sizes, our exclusive Bronze Perforated Hanging Pendant Lamp fills your space with irregular rays of light. Crafted in India of iron with rounded contours finished in bronze, this unique pendant adds romantic ambience anywhere it hangs.",
        type: "product",
        price_cents: "7999"
      }
    )
  end
end