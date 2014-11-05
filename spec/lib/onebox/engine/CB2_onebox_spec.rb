require "spec_helper"

describe Onebox::Engine::CB2Onebox do
  let(:link) { "http://www.cb2.com/alias-adjustable-bistro-table/s278387" }
  let(:json) { described_class.new(link).data }

  before do
    fake(link, response("cb2"))
  end

  it "should return a list of product attributes" do
    expect(json).to eq(
      {
        link: "http://www.cb2.com/alias-adjustable-bistro-table/s278387",
        title: "alias adjustable bistro table",
        image: "http://2i.c-b.co/is/image/CB2/AliasAdjustBistroTblF14",
        description: "highs and lows.  Mixed material design serves up (and down) an industrial revolution for small spaces.  Smooth round of solid sustainable acacia wood lifts and lowers from coffee table to kitchen bistro with a simple turn of the key on cast iron base.  Finished matte black with a hand-applied lacquer, welded center spindle supports the ups and downs of impromptu entertaining.",
        type: nil,
        price_cents: "39900"
      }
    )
  end
end
