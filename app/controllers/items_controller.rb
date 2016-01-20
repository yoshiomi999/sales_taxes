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
        
        sum_taxes = basic_tax+duty # sum basic tax & duty
        taxed_price = original_price + sum_taxes # sum taxes + original price
        
        return [taxed_price.round(2), sum_taxes.round(2)] # rounding up each valuse
    end
  
  
end
