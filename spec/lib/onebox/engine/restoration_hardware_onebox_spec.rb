require "spec_helper"

describe Onebox::Engine::RestorationHardwareOnebox do
  let(:link) { URI.encode("https://www.restorationhardware.com/catalog/product/product.jsp?productId=prod2710818&categoryId=cat1580086") }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("restoration_hardware"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: 'https://www.restorationhardware.com/catalog/product/product.jsp?productId=prod2710818&amp;categoryId=cat1580086',
        title: '1840s Belgium Working Tower Clock',
        image: 'http://media.restorationhardware.com/is/image/rhis/E34292839_TQ?$l-pd1$&illum=0',
        description: "Restoration Hardware's 1840s Belgium Working Tower Clock:Grand in every sense of the word, this collosal 5-foot timepiece accurately replicates a 19th century clock that once tolled the hours from a church tower high above a Belgian town. With elegant Roman numerals and elongated 28&#34; hands, our reproduction is a fully functioning work of art.",
        type: 'product',
        price_cents: '149500',
        price: '$1495'
      }
    )
  end
end
