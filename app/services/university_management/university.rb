require 'byebug'

module UniversityManagement
  class Base
    attr_accessor :name

    def initialize(name)
      @name =  name
    end
  end

  class University < Base
    attr_accessor :courses

    def initialize(name)
      super
      @courses = []
    end
  end

  class Course < Base
    attr_accessor :students

    def initialize(name)
      super
      @students = []
    end

    def add_student(student)
      @students << student
    end

    def remove_student(student)
      students.reject! { |obj| obj.id == student.id }
    end

    def sort_students
      students.sort_by{ |student| -student.gpa }
    end

    def student_count
      students.size
    end

    def to_s
      puts "Course Name is #{name}"
      puts "Consider the students in the courses" if student_count > 1

      students.each do |student|
        puts "Student Id: #{student.id} Name: #{student.name} Gpa: #{student.gpa}"
      end
    end
  end

  class Student < Base
    attr_accessor :id, :gpa

    def initialize(name, id, gpa)
      super(name)
      @id = id
      @gpa = gpa
    end
  end
end

def main
  student_one = UniversityManagement::Student.new("Nitanshu", 1, 3.8)
  student_two = UniversityManagement::Student.new("Prem", 2, 5.8)
  student_three = UniversityManagement::Student.new("Avyan", 3, 6.8)

  course_one = UniversityManagement::Course.new("maths")
  course_one.add_student(student_one)
  course_one.add_student(student_two)
  course_one.add_student(student_three)
  course_one.to_s

  puts "course_one.sort_students #{course_one.sort_students.map(&:gpa)}"

  course_one.remove_student(student_two)

  puts "After removal of student_two, student_count is #{course_one.student_count}"
  course_one.to_s

end

main