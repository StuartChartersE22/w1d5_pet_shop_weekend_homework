#1st test
def pet_shop_name(pet_shop_details)
  return pet_shop_details[:name]
end

# 2nd test
def total_cash(pet_shop_details)
  return pet_shop_details[:admin][:total_cash]
end

#3rd, 4th test
def add_or_remove_cash(pet_shop_details, amount_to_change_by)
  pet_shop_details[:admin][:total_cash] += amount_to_change_by
end

#5th test
def pets_sold(pet_shop_details)
  return pet_shop_details[:admin][:pets_sold]
end

#6th test
def increase_pets_sold(pet_shop_details,amount_to_change_by)
  pet_shop_details[:admin][:pets_sold] += amount_to_change_by
end

#7th test
def stock_count(pet_shop_details)
  return pet_shop_details[:pets].length()
end

#8th, 9th test
def pets_by_breed(pet_shop_details, breed_to_be_found)
  collection_of_pets = []
  for pet in pet_shop_details[:pets]
    if pet[:breed] == breed_to_be_found
      collection_of_pets.push(pet)
    end
  end
  return collection_of_pets
end

#10th, 11th test
def find_pet_by_name(pet_shop_details, name_to_be_found)
  for pet in pet_shop_details[:pets]
    if pet[:name] == name_to_be_found
      return pet
    end
  end
  return nil
end

#12th test
def remove_pet_by_name(pet_shop_details, name_to_remove)
  for pet in pet_shop_details[:pets]
    if pet[:name] == name_to_remove
      pet_shop_details[:pets].delete(pet)
    end
  end
end

#13th test
def add_pet_to_stock(pet_shop_details, pet_to_add)
  pet_shop_details[:pets].push(pet_to_add)
end

#14th test
def customer_cash(customer)
  return customer[:cash]
end

#15th test
def remove_customer_cash(customer, amount_to_change_by)
  customer[:cash] -= amount_to_change_by
end

#16th test
def customer_pet_count(customer)
  return customer[:pets].length()
end

#17th test
def add_pet_to_customer(customer, pet_to_add)
  customer[:pets].push(pet_to_add)
end

#OPTIONAL

#1st, 2nd test
def customer_can_afford_pet(customer, wanted_pet)
  customer_cash(customer) >= wanted_pet[:price]
end

#3rd test
def sell_pet_to_customer(pet_shop_details, wanted_pet, customer)
  return if wanted_pet == nil || !customer_can_afford_pet(customer, wanted_pet)
  add_pet_to_customer(customer, wanted_pet)
  remove_customer_cash(customer, wanted_pet[:price])
  add_or_remove_cash(pet_shop_details, wanted_pet[:price])
  increase_pets_sold(pet_shop_details,1)
end
