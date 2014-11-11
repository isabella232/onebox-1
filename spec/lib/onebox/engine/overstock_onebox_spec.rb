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
        title: "Baxton Studio Keswick Beige Linen Modern Tufted Ottoman",
        image: "http://ak1.ostkcdn.com/images/products/7818917/7818917/Baxton-Studio-Keswick-Beige-Linen-Modern-Tufted-Ottoman-T15209808.jpg",
        description: "The Keswick Beige Linen Modern Tufted Ottoman from Baxton Studio features a button-tufted linen upholstery. This ottoman is constructed with a eucalyptus wood frame and polyurethane foam cushioning. Relax after a hard day at work by resting your sore feet on this comforting ottoman. The turned wood legs give this piece of furniture a classic sense of style, while the black finish easily blends in with the rest of the room. Non-marking pads keep the feet from damaging your floors. Set includes: One (1) ottoman Materials: Linen/wood/foam Finish: Black Upholstery materials: Linen Upholstery colors: Beige, grey Upholstery fill: Polyurethane foam padding Linen with button tufting Eucalyptus wood frame Black turned wood legs with non-marking feet Dimensions: 15.5 inches high x 35 inches wide x 35 inches long Assembly required.",
        type: "product",
        price_cents: "18421"
      }
    )
  end
end
