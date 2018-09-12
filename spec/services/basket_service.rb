require "spec_helper"
require "rails_helper"

describe BasketService do
  describe '#calculate_basket' do
    shared_examples 'basket_items' do
      let(:basket) { BasketService.new(items) }

      it 'checks all returned functions' do
        basket.calculate_basket
        expect(basket.grand_total).to eq(g_total)
        expect(basket.sub_total).to eq(s_total)
        expect(basket.tax).to eq(tax)
        expect(basket.discounts).to eq(discounts)
        expect(basket.tax_rates(2)).to eq(refund1)
        expect(basket.tax_rates(3)).to eq(refund2)
        expect(basket.total_refund).to eq(t_refund)
        expect(basket.item_name(1)).to eq(name1)
        expect(basket.item_name(2)).to eq(name2)
        expect(basket.item_name(3)).to eq(name3)
        expect(basket.item_price(1)).to eq(price1)
        expect(basket.item_price(2)).to eq(price2)
        expect(basket.item_price(3)).to eq(price3)
      end
    end

    it_behaves_like 'basket_items' do
      let(:g_total)   { "66.40" }
      let(:s_total)   { "62.90" }
      let(:tax)       { "3.50" }
      let(:refund1)   { 1.695 }
      let(:refund2)   { 1.80 }
      let(:t_refund)  { 0 }
      let(:discounts) { 0 }
      let(:name1)     { "Scotland Flag" }
      let(:name2)     { "Children’s Car Seat" }
      let(:name3)     { "Magnetic Wrist Band" }
      let(:price1)    { 20 }
      let(:price2)    { 33.90 }
      let(:price3)    { 9 }
      let(:items)     { ["1", "2", "3"] }
    end

    it_behaves_like 'basket_items' do
      let(:g_total)   { "80.25" }
      let(:s_total)   { "87.80" }
      let(:tax)       { "3.39" }
      let(:refund1)   { 1.695 }
      let(:refund2)   { 1.80 }
      let(:t_refund)  { "9.60" }
      let(:discounts) { 0 }
      let(:name1)     { "Scotland Flag" }
      let(:name2)     { "Children’s Car Seat" }
      let(:name3)     { "Magnetic Wrist Band" }
      let(:price1)    { 20 }
      let(:price2)    { 33.90 }
      let(:price3)    { 9 }
      let(:items)     { ["2", "1", "2"] }
    end

    it_behaves_like 'basket_items' do
      let(:g_total)   { "71.63" }
      let(:s_total)   { "82.90" }
      let(:tax)       { "3.50" }
      let(:refund1)   { 1.695 }
      let(:refund2)   { 1.80 }
      let(:t_refund)  { "8.52" }
      let(:discounts) { 5 }
      let(:name1)     { "Scotland Flag" }
      let(:name2)     { "Children’s Car Seat" }
      let(:name3)     { "Magnetic Wrist Band" }
      let(:price1)    { 20 }
      let(:price2)    { 33.90 }
      let(:price3)    { 9 }
      let(:items)     { ["3", "1", "2", "1"] }
    end
  end
end
