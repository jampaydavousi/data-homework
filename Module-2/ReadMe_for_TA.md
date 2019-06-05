Please note:

1.  All three .vbs files include the 'challenge' part of the assignment, using a For Each look to runs the scripts on all worksheets.

2.  There is an error in my calculation script on the 'Moderate' assignment that impacts the outcome on the 'Hard' assignment.  
It is hard to discover the error in the output results of the 'Moderate'.  But the error is in the 'Moderate' script.  I believe it 
has to do with the logic of skipping the rows with values of '0'.  I did not notice it until I saw the results for the 'Hard' assignment.  
Instead of displying ARR as the stock with 490% as the stock wih the maximum percentage change, I am displaying VLY-A with 16000%. 
I see this value in the output of the MODERATE under 2015.  One would have to scroll down to VLY-A to see the outrageous percentage
change of 16000%.  I can not determine if or where the error is in calculating the Percentage Change for VLY-A which should be under 10%.

3.  I used Google to Cells().Value="00.0%" using Cells().NumberFormat = "00.0%" However, it is not working and showing the results as decimal.
