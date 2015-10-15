require 'csv'

def account_500?(row)
	return true if row["Journal Account Code"] == "500"
end

def dummy_header?(row)
	return true if row["Journal Amount"] == "Journal Amount"
end

# Record will need to hold the input data, as well as have class variables to
# track some things.
class Record
  @@names = {}
  
  def self.names
	@@names
  end
  
  attr_reader :last_name, :inv_dist
  
  attr_accessor :dist
  
  def initialize(row)
    
    @report_name = row["Report Name"]
	@submit_date = row["Report Submit Date"]
	@description = "#{row["Report Entry Expense Type Name"]} #{row["Report Entry Description"]}"
	@account_code = row["Journal Account Code"]
	@journal_amount = row["Journal Amount"]
	@job_cost = row["Job Cost"]
	@last_name = row["Employee Last Name"]
    if @@names.include?(@last_name)
      @@names[@last_name] += 1
    else
      @@names[@last_name] = 1
    end
    @inv_dist = @@names[@last_name]
    # Will need to calculate due date from submit date and format it
	
  end
  
  def output
    [@last_name, @report_name, @submit_date, "", @description, @account_code, @journal_amount, @job_cost, "200", @dist, @inv_dist]
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
store = []
CSV.foreach(amex_file, headers: true) do |row|
	unless dummy_header?(row)
		if account_500?(row)
			row["Job Cost"] = store[0]["Job Cost"]
			row["Employee Last Name"] = store[0]["Employee Last Name"]
			row["Report Name"] = store[0]["Report Name"]
			row["Report Submit Date"] = store[0]["Report Submit Date"]
			row["Report Entry Expense Type Name"] = store[0]["Report Entry Expense Type Name"]
			row["Report Entry Description"] = store[0]["Report Entry Description"]			
		end
		arr << Record.new(row)
		store[0] = row
	end
end
CSV.foreach(usd_file, headers: true) do |row|
	unless dummy_header?(row) || account_500?(row)
		arr << Record.new(row)
	end
end



arr.each{|record| record.dist = Record.names[record.last_name]}

arr.sort_by!{|record| [record.last_name, record.inv_dist]}

final_headers = ["Employee Last Name", "Report Name", "Report Submit Date", "Due Date", "Description", "Journal Account Code", "Journal Amount", "Job Cost", "AP", "# Dist", "Inv Dis"]

CSV.open("test.csv", "wb") do |out|
	out << final_headers
	arr.each{|record| out << record.output}
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

