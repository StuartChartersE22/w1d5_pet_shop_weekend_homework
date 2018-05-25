def pet_shop_name(pet_shop_details)
  return pet_shop_details[:name]
end

def total_cash(pet_shop_details)
  return pet_shop_details[:admin][:total_cash]
end

def add_or_remove_cash(pet_shop_details, amount_to_change_by)
  pet_shop_details[:admin][:total_cash] += amount_to_change_by
end
