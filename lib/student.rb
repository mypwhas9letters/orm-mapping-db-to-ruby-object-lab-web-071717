require 'pry'

class Student
  attr_accessor :id, :name, :grade
@@all =[]
  def self.new_from_db(row)
    # create a new Student object given a row from the database
    newsong = self.new
    newsong.id = row[0]
    newsong.name = row[1]
    newsong.grade = row[2]
    newsong
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class

  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = <<-SQL
      SELECT * FROM students
      WHERE name = (?)
    SQL

    stufromdb = DB[:conn].execute(sql, name)[0]
    self.new_from_db(stufromdb)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.count_all_students_in_grade_9
    #returns an array of all students in grades 9 (FAILED - 1)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = (9)
    SQL
      DB[:conn].execute(sql)
  end

  def self.students_below_12th_grade
    #returns an array of all students in grades 11 or below (FAILED - 2)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade < 12
    SQL
      DB[:conn].execute(sql)
end

  def self.all
    #returns all student instances from the db (FAILED - 3)
    sql = <<-SQL
      SELECT * FROM students
    SQL
      DB[:conn].execute(sql).each do |x|
        @@all << self.new_from_db(x)
      end
      @@all
  end

  def self.first_x_students_in_grade_10(x)
  #  returns an array of the first X students in grade 10 (FAILED - 4)
  sql = <<-SQL
    SELECT * FROM students
    WHERE grade = 10
    limit ?
  SQL
    DB[:conn].execute(sql, x)
end

  def self.first_student_in_grade_10
  #  returns the first student in grade 10 (FAILED - 5)
  sql = <<-SQL
    SELECT * FROM students
    WHERE grade = 10
    limit 1
  SQL
    x = DB[:conn].execute(sql)[0]
    self.new_from_db(x)

end

  def self.all_students_in_grade_x(x)
  #  returns an array of all students in a given grade X (FAILED - 6)
  sql = <<-SQL
    SELECT * FROM students
    WHERE grade = ?
  SQL
    DB[:conn].execute(sql, x)
end















  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
