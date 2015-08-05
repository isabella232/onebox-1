require "spec_helper"

describe Onebox::Engine::WestElmOnebox do
  let(:link) { URI.encode("http://www.westelm.com/products/mid-century-bracket-geo-shower-curtain-moonstone-b1729/?pkey=cshower-curtains%7C%7C&cm_src=shower-curtains||NoFacet-_-NoFacet-_--_-") }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("west_elm"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.westelm.com/products/mid-century-bracket-geo-shower-curtain-moonstone-b1729/?pkey=cshower-curtains%257C%257C&amp;cm_src=shower-curtains%7C%7CNoFacet-_-NoFacet-_--_-",
        title: "Mid-Century Bracket Geo Shower Curtain - Moonstone",
        image: "http://ab.weimgs.com/weimgs/ab/images/wcm/products/201524/0028/img19m.jpg",
        description: "Our Mid-Century Bracket Geo Shower Curtain adds the perfect amount of pattern to a bathroom with its modern, small-scale print.",
        type: 'product',
        price_cents: '4900',
        price: '$49'
      }
    )
  end
end
