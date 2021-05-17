class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.belongs_to :department
      t.string :name
      t.string :courseCode

      t.timestamps
    end
  end
end
