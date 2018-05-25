def pet_shop_name(pet_shop_details)
  return pet_shop_details[:name]
end

def total_cash(pet_shop_details)
  return pet_shop_details[:admin][:total_cash]
end

def add_or_remove_cash(pet_shop_details, amount_to_change_by)
  pet_shop_details[:admin][:total_cash] += amount_to_change_by
end

def pets_sold(pet_shop_details)
  return pet_shop_details[:admin][:pets_sold]
end

def increase_pets_sold(pet_shop_details,amount_to_change_by)
  pet_shop_details[:admin][:pets_sold] += amount_to_change_by
end

def stock_count(pet_shop_details)
  return pet_shop_details[:pets].length()
end

def pets_by_breed(pet_shop_details, breed_to_be_found)
  collection_of_pets = []
  for pet in pet_shop_details[:pets]
    if pet[:breed] == breed_to_be_found
      collection_of_pets.push(pet)
    end
  end
  return collection_of_pets
end

def find_pet_by_name(pet_shop_details, name_to_be_found)
  for pet in pet_shop_details[:pets]
    if pet[:name] == name_to_be_found
      return pet
    end
  end
end
