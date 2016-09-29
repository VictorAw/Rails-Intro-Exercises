class Course < ActiveRecord::Base
  has_many :enrollments,
    class_name: :Enrollment,
    primary_key: :id,
    foreign_key: :course_id

  has_many :enrolled_student,
    through: :enrollments,
    source: :user

end
