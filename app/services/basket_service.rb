class BasketService
  ITEMS = {
    1 => 20,
    2 => 33.90,
    3 => 9
  }

  NAME = {
    1 => "Scotland Flag",
    2 => "Children’s Car Seat",
    3 => "Magnetic Wrist Band"
  }

  VAT = {
    1 => 0,
    2 => 0.05,
    3 => 0.20
  }

  REFUND = 0.12

  DISCOUNT = 5

  attr_reader :basket, :totals

  def initialize(basket)
    @basket = basket
    @totals = {
      g_total: 0,
      s_total: 0,
      tax: 0,
      discounts: 0
    }
  end

  def calculate_basket
    dc = 0
    basket.each do |item|
      item = item.to_i
      dc += 1 if item == 1
      totals[:s_total] += ITEMS[item]
      totals[:g_total] += additional_rates(item, dc)
      totals[:tax] += tax_rates(item)
      if dc == 2
        dc = 0
        totals[:discounts] += 1
      end
    end
    totals[:g_total] = '%0.2f' % (vat_refund(totals[:g_total])).round(2)
    totals[:s_total] = '%0.2f' % totals[:s_total].round(2)
    totals[:tax] = '%0.2f' % totals[:tax]
    totals[:discounts] = totals[:discounts] * DISCOUNT
  end

  def grand_total
    totals[:g_total]
  end

  def sub_total
    totals[:s_total]
  end

  def tax
    totals[:tax]
  end

  def discounts
    totals[:discounts]
  end

  def tax_rates(item)
    (ITEMS[item] * VAT[item])
  end

  def item_name(item)
    NAME[item]
  end

  def item_price(item)
    ITEMS[item]
  end

  def additional_rates(item, dc)
    dc == 2 && item == 1 ? ITEMS[item] - DISCOUNT : ITEMS[item] + tax_rates(item)
  end

  def total_refund
    total = totals[:g_total].to_i
    total > 70 ? '%0.2f' % (total * REFUND).round(2) : 0.00
  end

  private

  def vat_refund(total)
    if total > 70
      total = total - (total * REFUND)
    end
    total
  end
end
