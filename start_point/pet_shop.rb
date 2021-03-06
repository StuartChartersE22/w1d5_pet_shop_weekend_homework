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
  return pet_shop_details[:admin][:sold_pets].length()
end

#6th test
# My Note: not needed as sold_pets.length() would reflect the number of pets sold as long as array updated (which it should be)
# def indexing_pets_sold(pet_shop_details,amount_to_change_by)
#   pet_shop_details[:admin][:pets_sold] += amount_to_change_by
# end

#7th, 16th refactored to be passed by:

def owner_pet_count(owner)
  return owner[:pets].length()
end


#8th, 9th test
def pets_by_breed(owner, breed_to_be_found)
  collection_of_pets = []
  for pet in owner[:pets]
    if pet[:breed] == breed_to_be_found
      collection_of_pets.push(pet)
    end
  end
  return collection_of_pets
end

#10th, 11th test
def find_pet_by_name(owner, name_to_be_found)
  for pet in owner[:pets]
    if pet[:name] == name_to_be_found
      return pet
    end
  end
  return nil
end

#12th test
def remove_pet_by_name(owner, name_to_remove)
  for pet in owner[:pets]
    if pet[:name] == name_to_remove
      owner[:pets].delete(pet)
    end
  end
end

#Refactoring to 13th and 17th so test passed by:
def add_pet_to_owner(owner, pet_to_add)
  owner[:pets].push(pet_to_add)
end

#14th test
def customer_cash(customer)
  return customer[:cash]
end

#15th test
def remove_customer_cash(customer, amount_to_change_by)
  customer[:cash] -= amount_to_change_by
end


#OPTIONAL

#1st, 2nd test
def can_customer_afford_pet?(customer, wanted_pet)
  customer[:cash] >= wanted_pet[:price]
end

#3rd, 4th, 5th test

def sell_pet_to_customer(pet_shop_details, wanted_pet, customer)
  return if wanted_pet == nil || !can_customer_afford_pet?(customer, wanted_pet)
  add_pet_to_owner(customer, wanted_pet)
  remove_customer_cash(customer, wanted_pet[:price])
  add_or_remove_cash(pet_shop_details, wanted_pet[:price])
  remove_pet_by_name(pet_shop_details, wanted_pet[:name])
  pet_shop_details[:admin][:sold_pets].push(wanted_pet)
end

#Made up tests
#What pets can the customer afford?
def customers_affordable_pets(pet_shop_details,customer)
  affordable_pets = []
  for pet in pet_shop_details[:pets]
    if can_customer_afford_pet?(customer,pet)
      affordable_pets.push(pet)
    end
  end
  return affordable_pets
end

#customer returning pet
def was_pet_bought?(pet_shop_details, pet_to_check)
  for pet in pet_shop_details[:admin][:sold_pets]
    if pet[:name] == pet_to_check[:name] && pet[:breed] == pet_to_check[:breed]
      return true
    end
  end
  return false
end

def customer_returning_pet(pet_shop_details, pet_to_return, customer)
  return if !was_pet_bought?(pet_shop_details, pet_to_return)
  remove_pet_by_name(customer,pet_to_return[:name])
  remove_customer_cash(customer, -pet_to_return[:price])
  add_or_remove_cash(pet_shop_details, -pet_to_return[:price])
  add_pet_to_owner(pet_shop_details, pet_to_return)
  pet_shop_details[:admin][:sold_pets].delete(pet_to_return)
end
