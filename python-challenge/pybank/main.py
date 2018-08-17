# Assignment Unit 3 PYbank 
  
# import the os module
import os

# Module for reading CSV files
import csv

csvpath = os.path.join('/Users/drrahulbhola/desktop/budget_data.csv')

# Lists to store data
date = []
revenue = []
Monthly_change =[]


with open(csvpath, newline='') as csvfile:

    # CSV reader specifies delimiter and variable that holds contents
    csvreader = csv.reader(csvfile, delimiter=',')

    # Read the header row first 
    csv_header = next(csvreader)
    # total Dates
   

     # create lists for date and revenue to run functions on         
    for row in csvreader:  
        
        date.append(row[0])
        revenue.append(int(row[1]))
     
    #Total dates = get the count of total dates in the column of dates using len function

    total_dates = len(date)
    print("Total Number of dates in dataset = " + str(total_dates))
        
    #total profit/loss = sum all the rows in the column for revenue 
        
    profit_loss = sum(row for row in revenue)
    print("Total net amount of proft/loss = " + str(profit_loss))

    #Average change = calculate monthly change by subtracting preceeding row from row in revenue 
    # extracting the monthly change into a list =monthly_change and averaging the list

   
    for i in range(len(revenue)-1):
        change_value = int(revenue[i+1]) - int(revenue[i])
        Monthly_change.append(change_value)

    avg_chg = sum(Monthly_change) / len(Monthly_change)
    print(" Average change = " + str(avg_chg))

    # getting the max and min change
  
    max_value = max(Monthly_change)
    print("Greatest increase in profits " + str(date)+ str(max_value))

    
    min_value = min(Monthly_change)
    print("Greatest increase in profits " + str(date) + str(min_value))

data_csv = (total_dates, profit_loss, avg_chg, max_value, min_value)

# Set variable for output file
output_file = os.path.join('/Users/drrahulbhola/desktop/pybank_final.csv')

#  Open the output file
with open(output_file, "w", newline="") as csvfile:
    # Initialize csv.writer
    csvwriter = csv.writer(csvfile, delimiter=',')
# Write the first row (column headers)
    csvwriter.writerow(['Total Dates', 'Profit/Loss', 'Average Change', "Maximun Increase", "Maximum Decrease"])

    # Write the second row
    csvwriter.writerow([total_dates,profit_loss,avg_chg, max_value, min_value])