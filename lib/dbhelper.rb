require 'sqlite3'

class Dbhelper
  #extend SQLite3::Database

	def initialize(*args)
		@db = SQLite3::Database.new "fluid.db"
    @db.results_as_hash = true
    init
    add_test_data
	end

	def init
    sql = IO.read("fluid-1.0.sql")
    print "Running SQL initializer ... "
    @db.execute_batch(sql)
    print "complete.\n"
	end

  def deinit
    File.delete("fluid.db")
  end

  def add_test_data
    sql = IO.read("fluid-test.sql")
    print "Adding test data ... "
    @db.execute_batch(sql)
    print "complete.\n"
  end

  # Surely there must be a better way of doing this?
  # Like, extending the class?
  def last_insert_row_id
    return @db.last_insert_row_id
  end

  def execute(*args)
    return @db.execute(*args)
  end

end