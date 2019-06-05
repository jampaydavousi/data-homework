Sub StockSummaryEasy()

'Create a variable o be used to apply the script to all sheets
Dim ws As Worksheet

'Define what to do with all sheets
For Each ws In Worksheets
Dim WorksheetName As String
LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
WorksheetName = ws.Name

' Set an initial variable for holding the total trading volume per each stock ticker symbol
Dim Volume_Total As Double
  Volume_Total = 0
' Keep track of the location for each stock ticker symbol in the summary cell
Dim Summary_Cell_Row As Integer
  Summary_Cell_Row = 2
' Set an initial variable for holding the Stock Ticker Symbol
Dim Ticker_Symbol As String

'Add 2 new column headings
ws.Range("i1").Value = "'Ticker"
ws.Range("j1").Value = "'Total Stock Volume"

'Set the column width of the newlya dded columns to 20
ws.Range("i1").ColumnWidth = 20
ws.Range("j1").ColumnWidth = 20
ws.Range("k1").ColumnWidth = 20
ws.Range("l1").ColumnWidth = 20


' Loop through all rows of stock trades
For i = 2 To 800000

  ' Check if we are still within the same stock ticker symbol, if it is not...
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

    ' Set the Stock Ticker Symbol
      Ticker_Symbol = ws.Cells(i, 1).Value

' Add to the Volume Total
      Volume_Total = Volume_Total + ws.Cells(i, 7).Value

' Place the Stock Ticker Symbol in the summary cell
      ws.Range("I" & Summary_Cell_Row).Value = Ticker_Symbol
' Place the Volume Total for each ticker symbol to the summary cell
      ws.Range("J" & Summary_Cell_Row).Value = Volume_Total
' Increment the summary cell row
      Summary_Cell_Row = Summary_Cell_Row + 1
' Reset the Volume total so it can be used for the next stock ticker symbol
      Volume_Total = 0

'If the cell immediately following a row is the same stock ticker symbol...
    Else
'... add to the Volume Total
Volume_Total = Volume_Total + ws.Cells(i, 7).Value

    End If

Next i

Next ws

End Sub