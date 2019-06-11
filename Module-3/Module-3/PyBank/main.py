# import modules
import os, csv

# create and set file path to the csv file where the data resides
csv_path = os.path.join('..', 'PyBank', 'Resources', 'budget_data.csv')
#print(csv_path)

# point to, open, 
with open(csv_path, newline="", encoding="UTF8") as csv_file:
# and read the data    
    csv_reader = csv.reader(csv_file, delimiter=",")
    #print(csv_reader)
    
    csv_header = next(csv_reader)
    #print(csv_header)

    #initializing values before the for loop begins
    row_count = 0
    net = 0
    delta = 0
    difference = []
    max_change = 0
    min_change = 0

 # reading and counting up the months at each row
    for row in csv_reader:
        # printing the elements of each each row.  Each row is a list
        #print(row)
        # printing the elements of each row without the single quotes
        #print(f"{row[0]} {row[1]}")
        row_count = row_count+1
        net = net + int(row[1])
        
        #calculate the change in Profit/Loss between current and previous rows
        change = int(row[1]) - delta
        delta = int(row[1])
        #put each calculated result into a new list
        difference.append(change)

        # Record the highest and lowest changes
        if max_change < change:
            max_change = change
            max_month = str(row[0])    

        if min_change > change:
            min_change = change
            min_month = str(row[0])    
    
    # eliminate the first record in the new list as it is the start of the period
    difference.pop(0)   
    # calcualte the total and quantity in order to calculate the average  
    sum_difference = sum(difference)
    len_difference = len(difference)
    # calculate the average
    avg_difference = sum(difference)/len(difference)
    
    # print the results to the terminal
    print("Financial Analysis")
    print("-" * 25)
    print(f"Total Months: {row_count}")    
    print(f"Total: ${net}") 
    # only show 2 decimal points when printing the average change
    print(f"Average Change: ${avg_difference:.2f}")
    print(f"Greatest Increase in Profits: {max_month}  (${max_change})")  
    print(f"Greatest Decrease in Profits: {min_month} (${min_change})")

    # define lists for gathering summarized information to be exported to a new csv file
    parameters = ["Total Months", "Total", "Greatest Increase in Profits", "Greatest Decrease in Profits"]
    months = [" ", " ", max_month, min_month]
    values = [row_count, net, max_change, min_change]
    
    #zip the lists into one new list called 'results'
    results = zip(parameters, months, values)
    
    # output path and new csv file name called 'summary' no need to spesify path as the destiantion is PyBank folder
    output_file = os.path.join("summary.csv")
    
# open and write
with open(output_file, "w", newline="", encoding="utf8") as data_file:
    csv_writer = csv.writer(data_file)

 # write in the new header
    csv_writer.writerow(["Summary", "Month", "Values"])

    # write data
    csv_writer.writerows(results)