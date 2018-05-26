require 'minitest/autorun'
require_relative '../pet_shop'

class TestPetShop < Minitest::Test

  def setup

    @customers = [
      {
        name: "Craig",
        pets: [],
        cash: 1000
      },
      {
        name: "Zsolt",
        pets: [],
        cash: 50
      }
    ]

    @new_pet = {
            name: "Bors the Younger",
            pet_type: :cat,
            breed: "Cornish Rex",
            price: 100
          }

    @pet_shop = {
        pets: [
          {
            name: "Sir Percy",
            pet_type: :cat,
            breed: "British Shorthair",
            price: 500
          },
          {
            name: "King Bagdemagus",
            pet_type: :cat,
            breed: "British Shorthair",
            price: 500
          },
          {
            name: "Sir Lancelot",
            pet_type: :dog,
            breed: "Pomsky",
            price: 1000,
          },
          {
            name: "Arthur",
            pet_type: :dog,
            breed: "Husky",
            price: 900,
          },
          {
            name: "Tristan",
            pet_type: :dog,
            breed: "Basset Hound",
            price: 800,
          },
          {
            name: "Merlin",
            pet_type: :cat,
            breed: "Egyptian Mau",
            price: 1500,
          }
        ],
        admin: {
          total_cash: 1000,
          # My Notes: removed as sold_pets array superseeds
          #pets_sold: 0,
          sold_pets: []
        },
        name: "Camelot of Pets"
      }
  end

  def test_pet_shop_name
    name = pet_shop_name(@pet_shop)
    assert_equal("Camelot of Pets", name)
  end

  def test_total_cash
    sum = total_cash(@pet_shop)
    assert_equal(1000, sum)
  end

  def test_add_or_remove_cash__add
    add_or_remove_cash(@pet_shop,10)
    cash = total_cash(@pet_shop)
    assert_equal(1010, cash)
  end

  def test_add_or_remove_cash__remove
    add_or_remove_cash(@pet_shop,-10)
    cash = total_cash(@pet_shop)
    assert_equal(990, cash)
  end

  def test_pets_sold
    sold = pets_sold(@pet_shop)
    assert_equal(0, sold)
  end

  # My Note: not needed as sold_pets.length() would reflect the number of pets sold as long as array updated (which it should be)
  # def test_indexing_pets_sold
  #   indexing_pets_sold(@pet_shop,2)
  #   sold = pets_sold(@pet_shop)
  #   assert_equal(2, sold)
  # end

  def test_owner_pet_count
    count = owner_pet_count(@pet_shop)
    assert_equal(6, count)
  end

  def test_all_pets_by_breed__found
    pets = pets_by_breed(@pet_shop, "British Shorthair")
    assert_equal(2, pets.count)
  end

  def test_all_pets_by_breed__not_found
    pets = pets_by_breed(@pet_shop, "Dalmation")
    assert_equal(0, pets.count)
  end

  def test_find_pet_by_name__returns_pet
    pet = find_pet_by_name(@pet_shop, "Arthur")
    assert_equal("Arthur", pet[:name])
  end

  def test_find_pet_by_name__returns_nil
    pet = find_pet_by_name(@pet_shop, "Fred")
    assert_nil(pet)
  end

  def test_remove_pet_by_name
    remove_pet_by_name(@pet_shop, "Arthur")
    pet = find_pet_by_name(@pet_shop,"Arthur")
    assert_nil(pet)
  end

  def test_add_pet_to_stock
    add_pet_to_owner(@pet_shop, @new_pet)
    count = owner_pet_count(@pet_shop)
    assert_equal(7, count)
  end

  def test_customer_cash

    cash = customer_cash(@customers[0])
    assert_equal(1000, cash)
  end

  def test_remove_customer_cash
    customer = @customers[0]
    remove_customer_cash(customer, 100)
    assert_equal(900, customer[:cash])
  end

  def test_owner_pet_count
    count = owner_pet_count(@customers[0])
    assert_equal(0, count)
  end

  def test_add_pet_to_customer
    customer = @customers[0]
    add_pet_to_owner(customer, @new_pet)
    assert_equal(1, owner_pet_count(customer))
  end

  # # OPTIONAL

  def test_can_customer_afford_pet__insufficient_funds
    customer = @customers[1]
    can_buy_pet = can_customer_afford_pet?(customer, @new_pet)
    assert_equal(false, can_buy_pet)
  end

  def test_can_customer_afford_pet__sufficient_funds
    customer = @customers[0]
    can_buy_pet = can_customer_afford_pet?(customer, @new_pet)
    assert_equal(true, can_buy_pet)
  end

  # #These are 'integration' tests so we want multiple asserts.
  # #If one fails the entire test should fail

  # My Note: Problem with original test, not testing that the pet has been taken from the pet shop stock.
  #added assert_equal(5, owner_pet_count(@pet_shop))

  # My Note: Added array of sold pets so customers can return pets later but can be tested here as well.

  def test_sell_pet_to_customer__pet_found
    customer = @customers[0]
    pet = find_pet_by_name(@pet_shop,"Arthur")
    sell_pet_to_customer(@pet_shop, pet, customer)
    list_of_pets_sold = @pet_shop[:admin][:sold_pets]

    assert_equal(1, owner_pet_count(customer))
    assert_equal(100, customer_cash(customer))
    assert_equal(1900, total_cash(@pet_shop))
    assert_equal(5, owner_pet_count(@pet_shop))
    assert_equal(1, list_of_pets_sold.length())
  end

  def test_sell_pet_to_customer__pet_not_found
    customer = @customers[0]
    pet = find_pet_by_name(@pet_shop,"Dave")
    list_of_pets_sold = @pet_shop[:admin][:sold_pets]
    sell_pet_to_customer(@pet_shop, pet, customer)

    assert_equal(0, owner_pet_count(customer))
    assert_equal(1000, customer_cash(customer))
    assert_equal(1000, total_cash(@pet_shop))
    assert_equal(6, owner_pet_count(@pet_shop))
    assert_equal(0, list_of_pets_sold.length())
  end

  def test_sell_pet_to_customer__insufficient_funds
    customer = @customers[1]
    pet = find_pet_by_name(@pet_shop,"Arthur")
    list_of_pets_sold = @pet_shop[:admin][:sold_pets]
    sell_pet_to_customer(@pet_shop, pet, customer)

    assert_equal(0, owner_pet_count(customer))
    assert_equal(50, customer_cash(customer))
    assert_equal(1000, total_cash(@pet_shop))
    assert_equal(6, owner_pet_count(@pet_shop))
    assert_equal(0, list_of_pets_sold.length())
  end

  #Made up tests
  #What pets can the customer afford?
  def test_pets_customer_can_afford
    customer = @customers[0]
    affordable_pets = customers_affordable_pets(@pet_shop,customer)
    assert_equal(5,affordable_pets.length())
  end

  #Customer can't afford any pets
  def test_pets_customer_can_afford__is_none
    customer = @customers[1]
    affordable_pets = customers_affordable_pets(@pet_shop,customer)
    assert_equal(0,affordable_pets.length())
  end

  #Customer returns pet
  def test_customer_returning_pet
    customer = @customers[0]
    pet = find_pet_by_name(@pet_shop,"Arthur")
    sell_pet_to_customer(@pet_shop, pet, customer)
    customer_returning_pet(@pet_shop, pet, customer)
    list_of_pets_sold = @pet_shop[:admin][:sold_pets]

    assert_equal(0, owner_pet_count(customer))
    assert_equal(1000, customer_cash(customer))
    assert_equal(1000, total_cash(@pet_shop))
    assert_equal(6, owner_pet_count(@pet_shop))
    assert_equal(0, list_of_pets_sold.length())
  end

  #Customer tries to return pet that isn't bought from store
  def test_customer_returning_pet__not_bought
    customer = @customers[0]
    add_pet_to_owner(customer, @new_pet)
    customer_returning_pet(@pet_shop, @new_pet, customer)
    list_of_pets_sold = @pet_shop[:admin][:sold_pets]

    assert_equal(1, owner_pet_count(customer))
    assert_equal(1000, customer_cash(customer))
    assert_equal(1000, total_cash(@pet_shop))
    assert_equal(6, owner_pet_count(@pet_shop))
    assert_equal(0, list_of_pets_sold.length())
  end

end
