require "spec_helper"

describe Onebox::Engine::CrateAndBarrelOnebox do
  let(:link) { "http://www.crateandbarrel.com/maisie-9-melamine-plate/s455137" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("crate_and_barrel"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.crateandbarrel.com/maisie-9-melamine-plate/s455137",
        title: "Maisie 9\" Melamine Plate",
        image: "http://i.c-b.co/is/image/Crate/MaisieMelaminePlate9InF15",
        description: "A vibrant modern botanical with a playful attitude and upbeat palette decorates this durable melamine plate in a versatile size for entertaining and layering with our Lunea dinnerware.  Coordinating napkins sold separately. 100% melamineBPA-freeTop-rack dishwasher-safeNot microwave-safeMade in China.",
        type: nil,
        price_cents: '495',
        price: '$4.95'
      }
    )
  end
end
