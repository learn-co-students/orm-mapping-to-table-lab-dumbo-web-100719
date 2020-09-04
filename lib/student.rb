class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name,grade,id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    # create table using HEREDOC statement for multiple lines
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INT
      );
    SQL
    # execute statment with .execute from sqlite-ruby gem
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql_drop = <<-SQL
      DROP TABLE IF EXISTS students
    SQL
    DB[:conn].execute(sql_drop)
  end

  def save
    sql_save = <<-SQL
      INSERT INTO students(name,grade) 
      VALUES(?,?)
    SQL
    DB[:conn].execute(sql_save,self.name,self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(hash)
    create_student = Student.new(hash[:name],hash[:grade])
    create_student.save
    create_student
  end
end


# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]  