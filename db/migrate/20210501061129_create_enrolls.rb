class CreateEnrolls < ActiveRecord::Migration[6.1]
  def change
    create_table :enrolls do |t|
      t.belongs_to :student
      t.belongs_to :course
      
      t.timestamps
    end
    add_index :enrolls, [:student_id, :course_id]
  end
end
