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
      v_refund: 0,
      e_price: 0
    }
  end

  def calculate_basket
    dc = 0
    basket.each do |item|
      item = item.to_i
      dc += 1 if item == 1
      totals[:g_total] += additional_rates(item, 0)
      totals[:s_total] += ITEMS[item]
      totals[:e_price] += additional_rates(item, dc)
      totals[:tax] += tax_rates(item)
      dc = 0 if dc == 2
    end
    totals[:v_refund] = totals[:e_price] > 70 ? '%0.2f' % vat_refund(totals[:e_price]).round(2) : "0.00"
    totals[:e_price] = totals[:e_price] - vat_refund(totals[:e_price]) if totals[:e_price] > 70
    totals[:s_total] = '%0.2f' % totals[:s_total].round(2)
    totals[:tax] = totals[:tax]
  end

  def e_price
    totals[:e_price]
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

  def v_refund
    totals[:v_refund]
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

  private

  def vat_refund(total)
      total * REFUND
  end
end
