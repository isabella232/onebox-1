require "spec_helper"

describe Onebox::Engine::AllmodernOnebox do
  let(:link) { "http://www.allmodern.com/Rizzy-Home-Reversible-Pillow-T0-RZY2682.html" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("allmodern"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.allmodern.com/Rizzy-Home-Reversible-Pillow-T0-RZY2682.html",
        title: "Rizzy Home Reversible Pillow",
        image: "http://img2.wfrcdn.com/lf/48/hash/11575/6725741/1/Rizzy-Home-Reversible-Pillow.jpg",
        description: "        Features:                  Printing details with reversible pattern                                  ",
        type: "wayfairus:product",
        price_cents: "2902"
      }
    )
  end
end
