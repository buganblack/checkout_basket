class BasketService
  ITEMS = {
    1 => 20,
    2 => 33.90,
    3 => 9
  }

  VAT = {
    1 => 0,
    2 => 0.05,
    3 => 0.20
  }

  def calculate_basket(items)
    total = 0
    items.each do |item|
      total += additional_rates(item)
    end
    total
  end

  private

  def additional_rates(item)
    ITEMS[item] + (ITEMS[item] * VAT[item])
  end
end
