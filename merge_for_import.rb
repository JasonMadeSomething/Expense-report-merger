

def account_500?(row)

end

def dummy_header?(row)

end

# Record will need to hold the input data, as well as have class variables to
# track some things.
class Record
  @@names = {}
    
  def initialize()
    
    
    # if @@names.include?(lastname)
    #   @@names[lastname] += 1
    # else
    #   @@names[lastname] = 1
    # end
    # @inv_dist = @@names[lastname]
    # Will need to calculate due date from submit date and format it 
  end
  
  def output
    # This should return the proper data type to write the record to a csv
  end
  

end

arr = []

input_files = Dir.glob("*.csv")

# Check that input files has only 2 files in it.

# select and open the amex file 
# use CSV.foreach on the amex file and use the header
# create a new record using each row. 
# Use a condition to erase the dummy header line
# if the Journal Account Code is 500, Get the last row pushed to arr
# and use the attributes to fill in the missing spots
# Then iterate over the cash file. Get rid of dummy header and all 500 Account rows
# at this point arr should be a 1d array of records
# sort arr on the employee last name (any other sort things to sort by?...https://www.ruby-forum.com/topic/162413)
# use the Record.names hash to assign  # Dist to each record
# Iterate over arr and write each record to a csv file
# CSV.open("file for import.csv" "wb") {|out| arr.each{|record| out << record.output}}

