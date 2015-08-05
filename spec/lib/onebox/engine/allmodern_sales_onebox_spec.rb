require "spec_helper"

describe Onebox::Engine::AllmodernSalesOnebox do
  let(:link) { "http://www.allmodern.com/deals-and-design-ideas/p/foobar-Woven-Cotton-Throw-Pillow~MCRR1135~E21733.html" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("allmodern_sales"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.allmodern.com/deals-and-design-ideas/p/foobar-Woven-Cotton-Throw-Pillow~MCRR1135~E21733.html",
        title: "Four Cup Flour Sifter",
        image: "https://secure.img1.wfrcdn.com/lf/158/hash/24557/16662674/1/Four%2BCup%2BFlour%2BSifter.jpg",
        description: "The finer your dry ingredients are, the better your baking will be. To ensure that only the finest elements go into your recipes, use this flour sifter with wooden crank handle and make the light, airy cakes of your dreams.",
        type: nil,
        price_cents: '1499',
        price: '$14.99'
      }
    )
  end
end
