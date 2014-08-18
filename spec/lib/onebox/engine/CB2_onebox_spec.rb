require "spec_helper"

describe Onebox::Engine::CB2Onebox do
  let(:link) { "http://www.cb2.com/facetta-natural-chair/f9877" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("cb2"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.cb2.com/facetta-natural-chair/f9877",
        title: "facetta natural chair",
        image: "http://2i.c-b.co/is/image/CB2/FacettaChairNaturalF14",
        description: "give it a whirl.  Multifaceted swivel by Manuel Saez puts a new 360 spin on the midcentury aesthetic.  Geometric planes angle a sheltering profile in natural linen-y poly-weave, finished with a fashion-forward hidden zipper in the back.  Poised to turn with the conversation on iron tube pedestal base that takes a smart stance in lacquered matte grey.  Learn more about the designer, Manuel Saez, on our blog.",
        type: nil,
        price_cents: "39900"
      }
    )
  end
end
