require "spec_helper"

describe Onebox::Engine::OneKingsLaneOnebox do
  let(:link) { URI.encode("https://www.onekingslane.com/product/56060/4118435?cat=93") }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("one_kings_lane"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: 'https://www.onekingslane.com/product/56060/4118435?cat=93',
        title: 'Flower Market Paper Towel Holder',
        image: 'https://okl-scene7.insnw.net/is/image/OKL/Product_MFE10104_Image_1?wid=732&hei=499',
        description: "Featuring a stainless steel center post, glass finial, and an enamel base with hand-woven bamboo, this elegant paper towel holder has a hand-applied fanciful botanical motif that recalls a lush...",
        type: 'product',
        price_cents: '7000',
        price: '$70.00'
      }
    )
  end
end
