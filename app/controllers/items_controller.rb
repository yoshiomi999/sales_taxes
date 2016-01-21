class ItemsController < ApplicationController
  
  def home
    @items = Item.all  #get all records of itemes
  end
  
  
  def result
    #get the parameter from form. It's contains only ID number of selected item 
    item_ids = params[:item_ids]||[]

    # Valiables to show on view page 
    @orderd_items = Array.new #include item name & taxed price of all order itemes 
    @total_taxes = 0 #total tax of all orderd itmes
    @total_price = 0 #total price with tax of all orderd itmes
   
    #calculate all orderd items
    item_ids.each do |item_id|
        item_info = Item.find(item_id) #get paramter of an item

        name = item_info.name #get item name
        taxed_price, sum_taxes = calc_tax(item_info) #get taxed price & taxs throgh  "calc_tax" function
    
        @total_taxes += sum_taxes  #add the tax in to total tax variable
        @total_price += taxed_price  #add the taxed price in to total price variable
      
        taxed_item = {name:name, taxed_price:taxed_price} #hash of item name & taxed price
        @orderd_items.push(taxed_item) # push the hash in array object
    end
    
  end
  


  private
  
    # return taxed price & tax
    def calc_tax(item_info)
        
        # initial value setting
        original_price = item_info.price # original price of item
        basic_tax = 0 # Basic sales tax of item
        duty = 0 # Import duty of item
        
        # impose the basic tax 10%
        if item_info.basic_tax
            basic_tax = original_price*0.1 # only basci tax
        end
        
        # impose the import duty 5%
        if item_info.duty
            duty = original_price*0.05 # only duty
        end
        
        # calculate the price with taxes
        taxed_price = original_price + basic_tax + duty # original price + taxes 
        taxed_price = arrange_price(taxed_price); # arrange the second deciaml place
        
        # calculate the total taxes
        sum_taxes = taxed_price - original_price # Sum taxes is not basic_tax + duty, becasue the second deciaml place is modified
        sum_taxes = sum_taxes.round(2) # rounding up taxes valuse
        
        return [taxed_price, sum_taxes]
    end
  
  
    # modify the second deciaml place of price: example 10.01-10.04 become 10.05, but over 10.05 is same value
    def arrange_price(price)
      price = price.round(2) # rounding up

      # process to divide at decimal point
      str_price = price.to_s 
      str_price_arr = str_price.split(".")
      
      # ex 10.03 becomes "10" and "03"
      upper_decimal=str_price_arr.first # upper decimal part: ex "10"
      under_decimal=str_price_arr.last # under decimal part: ex "03"
      
      # 10 with round(2) return 10.0(not 10.00). only when the value "XX.01 - XX.99" do this process  
      if under_decimal.length == 2
        
        # splite the under decimal value ex ".03"
        first_decimal_place=under_decimal[0,1] # first: "0"
        second_decimal_place=under_decimal[-1,1] # second "3"
        
        # "01" - "04" become "05" 
        if second_decimal_place.to_i <= 4
            second_decimal_place="5"
            
            # rebuild the price. ex "10" + "." + "0" + "5"
            str_price = upper_decimal+"."+ first_decimal_place + second_decimal_place
            
            # format to bigDeciaml
            price=str_price.to_d 
        end
        
      end
      return price
    end
  
  
end
