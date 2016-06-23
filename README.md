# Expense-report-merger

Takes two CSV files in the same directory in a Concur export format and merges the records from the cash and credit files into a single file. It then sorts the new file by the spender.

Makes use of the `'csv'` gem to parse the header and structure the input files. The headers are hard-coded strings. 
