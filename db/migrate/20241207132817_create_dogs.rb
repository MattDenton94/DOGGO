class CreateDogs < ActiveRecord::Migration[7.2]
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.string :gender
      t.string :size
      t.string :temperament
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
