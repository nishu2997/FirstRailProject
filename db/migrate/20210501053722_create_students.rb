class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.belongs_to :department, null: false
      t.string :name
      t.integer :rollNumber

      t.timestamps
    end
  end
end
