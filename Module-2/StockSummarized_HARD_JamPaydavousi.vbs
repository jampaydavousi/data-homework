Sub StockSummary()

'Create a variable o be used to apply the script to all sheets
Dim ws As Worksheet

'Define what to do with all sheets
For Each ws In Worksheets
Dim WorksheetName As String
LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
WorksheetName = ws.Name

'Set an itial counter for the loop
Dim index As Double
'Set an itial counter for the loop
Dim maxindex As Double
' Set an initial variable for holding the total trading volume per each stock ticker symbol
Dim Volume_Total As Double
  Volume_Total = 0
' Keep track of the location for each stock ticker symbol in the summary cell
Dim Summary_Cell_Row As Integer
  Summary_Cell_Row = 2
' Set an initial variable for holding the Stock Ticker Symbol
Dim Ticker_Symbol As String
' Define a variable to store the opening price at the beginning of the year
Dim Begin_Year_Open As Double
' Define a variable to store the close price at the end of the year
Dim End_Year_Close As Double
' Define a variable to hold the difference between the year end closing price and begining price a tthe start of the year
Dim Change_In_Price As Double
'Define a variable to hold the percentage cahnge in the stock price
Dim Percentage_Change As Double

' Define a secondary counter to count how many rows 'index' is stepping through for each ticker
Dim Counter As Long

'Define a thrid counter to count the number of rows with '0" value in the opening price
Dim ZeroCounter As Long

'Define the variables for marking the stocks with the highest and lowest percentage change in price plus the stock with the highest traded volume stock
Dim MaxIncrease_Ticker As String
Dim MaxDecrease_Ticker As String
Dim MaxVolume_Ticker As String
Dim MaxIncrease As Double
Dim MaxDecrease As Double
Dim MaxVolume As Double

'Add 6 new column titles and 3 new row titles
ws.Range("i1").Value = "'Ticker"
ws.Range("j1").Value = "'Yearly Change"
ws.Range("k1").Value = "'Percentage Change"
ws.Range("l1").Value = "'Total Stock Volume"
ws.Range("p1").Value = "'Ticker"
ws.Range("q1").Value = "'Value"

ws.Range("o2").Value = "'Greatest % Increase"
ws.Range("o3").Value = "'Greatest % Decrease"
ws.Range("o4").Value = "'Greatest Total Volume"


'Change the format of the column k to display in %
ws.Range("k1").NumberFormat = "0.00%"

'Set the column width of the newlya dded columns to 20
ws.Range("i1").ColumnWidth = 20
ws.Range("j1").ColumnWidth = 20
ws.Range("k1").ColumnWidth = 20
ws.Range("l1").ColumnWidth = 20
ws.Range("o1").ColumnWidth = 20
ws.Range("q1").ColumnWidth = 20

'Reseting the conditional counters
Counter = 0
ZeroCounter = 0


' Loop through all rows of stock trades
For index = 2 To 800000

' Check for number of rows with '0' in the opneing price range
If ws.Cells(index, 3).Value = 0 Then ZeroCounter = ZeroCounter + 1

  ' Check if we are still within the same stock ticker symbol, if it is not...
    If ws.Cells(index + 1, 1).Value <> ws.Cells(index, 1).Value Then

    ' Set the Stock Ticker Symbol
      Ticker_Symbol = ws.Cells(index, 1).Value

' Add to the Volume Total
      Volume_Total = Volume_Total + ws.Cells(index, 7).Value

' Place the Stock Ticker Symbol in the summary cell
      ws.Range("i" & Summary_Cell_Row).Value = Ticker_Symbol
' Place the Volume Total for each ticker symbol to the summary cell
      ws.Range("l" & Summary_Cell_Row).Value = Volume_Total

'Capture the Year end closing price of the stock
End_Year_Close = ws.Cells(index, 6).Value

'Go back and fetch the opening price of the stock at the beginning of the year
Begin_Year_Open = ws.Cells((index - Counter + ZeroCounter), 3).Value

'Calculate the change in price of stock
 Change_In_Price = End_Year_Close - Begin_Year_Open
 
 'Calculate the percentage change in stock over the year
 Percentage_Change = Change_In_Price / Begin_Year_Open
 
' Place the Change in Price for each ticker symbol next to the right of the new ticker symbol column
ws.Range("j" & Summary_Cell_Row).Value = Change_In_Price

'Color the background of the Change_In_Price....
    If Change_In_Price < 0 Then
        'Red if the change in price is negative
        ws.Range("j" & Summary_Cell_Row).Interior.ColorIndex = 3
        Else
        'Green if the change in price is positive or unchanged
        ws.Range("j" & Summary_Cell_Row).Interior.ColorIndex = 4
        End If

'Place the Percentage change in stock next to the right of the actual change price
ws.Range("k" & Summary_Cell_Row).Value = Percentage_Change

' Increment the summary cell row
      Summary_Cell_Row = Summary_Cell_Row + 1

' Reset the Volume total so it can be used for the next stock ticker symbol
      Volume_Total = 0

'Reset the Counter
    Counter = 0

'If the cell immediately following a row is the same stock ticker symbol...
    Else
'... add to the Volume Total
Volume_Total = Volume_Total + ws.Cells(index, 7).Value
 ' Increment the Counter
 Counter = Counter + 1

    End If

Next index

For maxindex = 2 to 4000

' Mark the stock ticker with the maximum percentage INCREASE
If MaxIncrease < ws.Cells(maxindex, 11).Value Then
    MaxIncrease = ws.Cells(maxindex, 11).Value
    MaxIncrease_Ticker = ws.Cells(maxindex, 9).Value
End If

' Mark the stock ticker with the maximum percentage DECREASE
If MaxDecrease > ws.Cells(maxindex, 11).Value Then
    MaxDecrease = ws.Cells(maxindex, 11).Value
    MaxDecrease_Ticker = ws.Cells(maxindex, 9).Value
End If

' Mark the stock ticker with highest trading volume
If MaxVolume < ws.Cells(maxindex, 12).Value Then   
    MaxVolume = ws.Cells(maxindex, 12).Value
    MaxVolume_Ticker = ws.Cells(maxindex, 9).Value
End If

' Display the highest percentage change, lowest percentage change, and highest traded volume
ws.Range("p2").Value = MaxIncrease_Ticker
ws.Range("p3").Value = MaxDecrease_Ticker
ws.Range("p4").Value = MaxVolume_Ticker
ws.Range("q2").Value = MaxIncrease
ws.Range("q3").Value = MaxDecrease
ws.Range("q4").Value = MaxVolume    

Next maxindex

'Reset all markers
MaxIncrease = 0
MaxDecrease = 0
MaxVolume = 0

Next

End Sub

