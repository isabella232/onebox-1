require "spec_helper"

describe Onebox::Engine::PotteryBarnOnebox do
  let(:link) { URI.encode("http://www.potterybarn.com/products/pb-resort-spa-robe/?pkey=crobes&") }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("pottery_barn"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: 'http://www.potterybarn.com/products/pb-resort-spa-robe/?pkey=crobes&amp;',
        title: 'Waffle Weave Resort Robe',
        image: 'http://rk.pbimgs.com/pbimgs/rk/images/dp/wcm/201520/0003/img46c.jpg',
        description: "This luscious wrap incorporates the best features of robes from the world’s most luxurious spas.",
        type: 'product',
        price_cents: '11900',
        price: '$119'
      }
    )
  end
end
