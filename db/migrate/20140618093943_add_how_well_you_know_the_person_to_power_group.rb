class AddHowWellYouKnowThePersonToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :how_well_you_know_the_person, :string
  end
end
