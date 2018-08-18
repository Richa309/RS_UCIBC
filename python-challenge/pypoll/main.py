# Assignment Unit 3 PYpoll 
  
# import the os module
import os

# Module for reading CSV files
import csv

csvpath = os.path.join('/Users/drrahulbhola/desktop/election_data.csv')  

# Lists to store data
Voterid = []
country = []
Candidate =[]


with open(csvpath, newline='') as csvfile:

    # CSV reader specifies delimiter and variable that holds contents
    csvreader = csv.reader(csvfile, delimiter=',')

    # Read the header row first 
    csv_header = next(csvreader)
     
   

     # create lists      
    for row in csvreader:  
        
        Voterid.append(row[0])
        country.append(row[1])
        Candidate.append(row[2])

  # Total number of votes caste 
    print("Election Results")  
    print("---------------------------------------------")
    total_votes = len(Voterid)
    print("Total Votes : " + str(total_votes))
    print("---------------------------------------------")    

   # candidate list 
    cand_list = set(Candidate) 
    print(cand_list)

    # total votes count by each candidate

c = {}
for i in set(Candidate):
    c[i] = Candidate.count(i)
    c = {i: Candidate.count(i) for i in set(Candidate)}
print(c)
print("---------------------------------------------")   

# percent dist


list_by_votes = []
list_by_votes.append(c)

# winner
winner = max(list_by_votes)
print("Winner : " + str(winner) )
   


poll_csv = ()
 # Set variable for output file
output_file = os.path.join('/Users/drrahulbhola/desktop/pypoll_final.csv')
 #  Open the output file
with open(output_file, "w", newline="") as csvfile:
    # Initialize csv.writer
    csvwriter = csv.writer(csvfile, delimiter=',')
# Write the first row (column headers)
    csvwriter.writerow(['Total votes', 'List of candidates', 'Votes and percent', "Winner"])
     # Write the second row
    csvwriter.writerow([total_votes,cand_list, c, winner]) 
 