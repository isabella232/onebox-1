require "spec_helper"

describe Onebox::Engine::AllmodernOnebox do
  let(:link) { "http://www.allmodern.com/Woven-Cotton-Throw-Pillow-MCRR1135-MCRR1135.html" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("allmodern"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.allmodern.com/Woven-Cotton-Throw-Pillow-MCRR1135-MCRR1135.html",
        title: "Woven Cotton Throw Pillow",
        image: "https://secure.img2.wfrcdn.com/lf/158/hash/33808/15822361/1/Woven-Cotton-Throw-Pillow-MCRR1135.jpg",
        description: "Colorful and subtly eye-catching, this throw pillow features soft cotton construction. A basketweave pattern offers an artful variation in tone and texture, while a spectrum of hues suits every décor.",
        type: nil,
        price_cents: '2699',
        price: '$26.99'
      }
    )
  end
end
