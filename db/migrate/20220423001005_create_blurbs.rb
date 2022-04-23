class CreateBlurbs < ActiveRecord::Migration[7.0]
  def change
    create_table :blurbs do |t|
      t.string :title
      t.text :text
      t.text :planet_replacements

      t.timestamps
    end
  end
end
