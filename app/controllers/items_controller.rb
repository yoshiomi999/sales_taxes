class ItemsController < ApplicationController
  
  def home
    @items=Item.all
   
  end
  
  def result
    @test= params['Book']
  
  end
  
  def new
  
  end
end
