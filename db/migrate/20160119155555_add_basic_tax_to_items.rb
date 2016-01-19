class AddBasicTaxToItems < ActiveRecord::Migration
  def change
    add_column :items, :basic_tax, :boolean, :default => false
    add_column :items, :duty, :boolean, :default => false
  end
end
