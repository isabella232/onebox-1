require "spec_helper"

describe Onebox::Engine::AllmodernOnebox do
  let(:link) { "http://www.allmodern.com/Herman-Miller-%C2%AE-Eames-DSW-Molded-Plastic-Side-Chair-with-Dowel-Leg-Base-DSW-HML1456.html" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("allmodern"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.allmodern.com/Herman-Miller-%C2%AE-Eames-DSW-Molded-Plastic-Side-Chair-with-Dowel-Leg-Base-DSW-HML1456.html",
        title: "Herman Miller ® Eames DSW - Molded Plastic Side Chair with Dowel-Leg Base",
        image: "http://img2.wfrcdn.com/lf/48/hash/716/12620793/1/Herman-Miller-%25C2%25AE-Eames-DSW---Molded-Plastic-Side-Chair-with-Dowel-Leg-Base.jpg",
        description: "[Free Shipping] when you buy Herman Miller ® Eames DSW - Molded Plastic Side Chair with Dowel-Leg Base at AllModern - Great Deals on all Dining products with the best selection to choose from!",
        type: "wayfairus:product",
        price_cents: "39900"
      }
    )
  end
end
