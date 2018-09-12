require "spec_helper"
require "rails_helper"

describe BasketService do
  describe '#calculate_basket' do
    shared_examples 'basket_items' do
      let(:basket) { BasketService.new(items) }

      it 'checks all returned functions' do
        basket.calculate_basket
        expect(basket.v_refund).to eq(v_refund)
        expect(basket.grand_total).to eq(g_total)
        expect(basket.e_price).to eq(e_price)
        expect(basket.sub_total).to eq(s_total)
        expect(basket.tax).to eq(tax)
      end
    end

    it_behaves_like 'basket_items' do
      let(:g_total)   { 66.395 }
      let(:e_price)   { 66.395 }
      let(:s_total)   { "62.90" }
      let(:tax)       { 3.495 }
      let(:v_refund)  { "0.00" }
      let(:items)     { ["1", "2", "3"] }
    end

    it_behaves_like 'basket_items' do
      let(:g_total)   { 91.19 }
      let(:e_price)   { 80.24719999999999 }
      let(:s_total)   { "87.80" }
      let(:tax)       { 3.39 }
      let(:v_refund)  { "10.94" }
      let(:items)     { ["2", "1", "2"] }
    end

    it_behaves_like 'basket_items' do
      let(:g_total)   { 86.395 }
      let(:e_price)   { 71.6276 }
      let(:s_total)   { "82.90" }
      let(:tax)       { 3.495 }
      let(:v_refund)  { "9.77" }
      let(:items)     { ["3", "1", "2", "1"] }
    end
  end

  describe '#item_name' do
    let(:basket) { BasketService.new(["1", "1"]) }
    it 'it will check the correct name of item' do
      expect(basket.item_name(1)).to eq("Scotland Flag")
      expect(basket.item_name(2)).to eq("Children’s Car Seat")
      expect(basket.item_name(3)).to eq("Magnetic Wrist Band")
    end
  end

  describe '#item_price' do
    let(:basket) { BasketService.new(["1", "1"]) }
    it 'it will check the correct name of item' do
      expect(basket.item_price(1)).to eq(20)
      expect(basket.item_price(2)).to eq(33.90)
      expect(basket.item_price(3)).to eq(9)
    end
  end
end
