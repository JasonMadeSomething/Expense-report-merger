require 'csv'

def account_500?(row)
	return true if row["Journal Account Code"] == 500
end

def dummy_header?(row)
	return true if row["Journal Amount"] == "Journal Amount"
end

# Record will need to hold the input data, as well as have class variables to
# track some things.
class Record
  @@names = {}
    
  def initialize(row)
    
    @report_name = row["Report Name"]
	@submit_date = row["Report Submit Date"]
	@description = "#{row["Report Entry Expense Type Name"]} #{row["Report Entry Description"]}"
	@account_code = row["Journal Account Code"]
	@journal_amount = row["Journal Amount"]
	@job_cost = row["Job Cost"]
	
    if @@names.include?(row["Employee Last Name"])
      @@names[row["Employee Last Name"]] += 1
    else
      @@names[row["Employee Last Name"]] = 1
    end
    @inv_dist = @@names[row["Employee Last Name"]]
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
input_files.sort!
amex_file = input_files[0]
usd_file = input_files[1]

# use CSV.foreach on the amex file and use the header

CSV.foreach(amex_file, headers: true) do |row|
	unless dummy_header?(row)
		if account_500?(row)
			row["Job Cost"] = prev_row["Job Cost"]
			row["Employee Last Name"] = prev_row["Employee Last Name"]
			row["Report Name"] = prev_row["Report Name"]
			row["Report Submit Date"] = prev_row["Report Submit Date"]
			row["Report Entry Expense Type Name"] = prev_row["Report Entry Expense Type Name"]
			row["Report Entry Description"] = prev_row["Report Entry Description"]
		end	
		arr << Record.new(row)
		prev_row = row
	end
end

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

