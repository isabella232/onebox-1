require "spec_helper"

describe Onebox::Engine::WayfairOnebox do
  let(:link) { "http://www.wayfair.com/Castleton-Home-Louis-Philippe-Queen-Sleigh-Bed-13900-THRE1210.html" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("wayfair"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.wayfair.com/Castleton-Home-Louis-Philippe-Queen-Sleigh-Bed-13900-THRE1210.html",
        title: "Allington Queen Sleigh Bed",
        image: "https://secure.img2.wfrcdn.com/lf/187/hash/30973/15879205/1/Allington-Queen-Sleigh-Bed-13900.jpg",
        description: "The Allington Bed sets your bedroom’s tone with timeless style. Carefully crafted to last, this piece features graceful curves and polished panels. A glossy cherry finish complements the elegant sleigh bed design. Our Allington bedroom collection features designs inspired by the classic Louis Philippe style. Characterized by detailed molding and ornate bracket feet, this refined look is renowned for its delicate balance between luxury and attainability. Features MDF construction Cherry finish Queen-sized Dimensions: 37\" H x 64\" W x 92\" L Exclusively ours Includes headborad, footboard and slats Does not include a mattress Should use a box spring and mattress with the bed",
        type: nil,
        price_cents: '27499',
        price: '$274.99'
      }
    )
  end
end
