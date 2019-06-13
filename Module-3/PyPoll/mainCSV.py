# import modules
import os, csv

# create and set file path to the csv file where the data resides
csv_path = os.path.join('..', 'PyPoll', 'Resources', 'election_data.csv')
#print(csv_path)

# point to and open
with open(csv_path, newline="", encoding="UTF8") as csv_file:
# and read the data    
    csv_reader = csv.reader(csv_file, delimiter=",")
    #print(csv_reader)
    
    csv_header = next(csv_reader)
    #print(csv_header)

    #initializing values before the for loop begins
    row_count = 0
    khan_count = 0
    correy_count = 0
    li_count = 0
    otooley_count = 0
    winner = 0

 # reading and counting up the voters at each row
    for row in csv_reader:
        # printing the elements of each each row.  Each row is a list
        #print(row)
        # printing the elements of each row without the single quotes
        #print(f"{row[0]} {row[1]}")
        row_count = row_count+1
        
        if row[2] == "Khan":
            khan_count = khan_count+1
            
        if  row[2] == "Correy":
            correy_count = correy_count+1

        if  row[2] == "Li":
            li_count = li_count+1    

        if  row[2] == "O'Tooley":
            otooley_count = otooley_count+1        
               
    khan_pct = khan_count/row_count
    correy_pct = correy_count/row_count
    li_pct = li_count/row_count
    otooley_pct = otooley_count/row_count
  
    print("Election Results")
    print("-" * 60)
    print(f"Total Votes: {row_count}")    
    print("-" * 60)
    print(f"Khan: {khan_pct:0.3%} ({khan_count})")
    print(f"Correy: {correy_pct:0.3%} ({correy_count})")
    print(f"Li: {li_pct:0.3%} ({li_count})")
    print(f"O'Tooley: {otooley_pct:0.3%} ({otooley_count})")
    print("-" * 60)
# define lists for gathering summarized information to be exported to a new csv file
    candidates = ["Khan", "Correy", "Li", "O'Tooley", "Winner Name"]
    percentages = [khan_pct, correy_pct, li_pct, otooley_pct, winner]
    votes = [khan_count, correy_count, li_count, otooley_count, " "]
    
    winner =max(percentages)
    if winner == khan_pct:  
        print(f"Winner: {candidates[0]}")
        winner_name = "Khan"
    if winner == correy_pct:  
        print(f"Winner: {candidates[1]}")
        winner_name = "Correy"
    if winner == li_pct:  
        print(f"Winner: {candidates[2]}")  
        winner_name = "Li"
    if winner == otooley_pct:  
        print(f"Winner: {candidates[3]}") 
        winner_name = "O'Tooley"

 #zip the lists into one new list called 'results'
    results = zip(candidates, percentages, votes)

    # output path and new csv file name called 'summary' no need to spesify path as the destiantion is PyBank folder
    output_file = os.path.join("summary.csv")
    
# open and write
with open(output_file, "w", newline="", encoding="utf8") as data_file:
    csv_writer = csv.writer(data_file)

 # write in the new header
    csv_writer.writerow(["Candidate", "Percentage of Votes", "Number of Votes"])

    # write details
    csv_writer.writerows(results)

    # write winner
    csv_writer.writerow(str(winner_name))


