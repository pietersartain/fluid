require '../lib/exercises'
require '../lib/dbhelper'

@db = Dbhelper.new

describe Exercises, "#add" do
  exercises = Exercises.new(@db)
  it "returns 1 first exercise" do
    id = exercises.add("Exercise1","Unit1")
    id should eq(1)
  end
  it "returns 2 second exercise" do
    id = exercises.add("Exercise2","Unit2")
    id should eq(2)
  end
end