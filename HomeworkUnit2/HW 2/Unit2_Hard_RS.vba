Sub Stocks_tracker()

'to run this query on all worksheets

For Each ws In Worksheets
    
    'Define location to insert the summary table
    
    ws.Range("I1").Value = "Ticker"
    ws.Range("L1").Value = "Total Stock Volume"
    
    'Define initial variables
    
    Dim ticker_name As String
    Dim ticker_total As Double
     
    
    ticker_total = 0
    
    'Check if we are within the same ticker else move to the next..
    
    Dim total_stock_vol As Long
    total_stock_vol = 2
    
    ' Since the data listing is different on each worksheet define the end point for the loop i
    
    lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    'loop through all ticker types
    
    For i = 2 To lastrow
    
        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        
        ticker_name = ws.Cells(i, 1).Value
        ticker_total = ticker_total + ws.Cells(i, "G").Value
            
        'Print ticker
        ws.Range("I" & total_stock_vol).Value = ticker_name
        ws.Range("L" & total_stock_vol).Value = ticker_total
       total_stock_vol = total_stock_vol + 1
       
       'Reset the ticker
       
      ticker_total = 0
        
        Else
        ticker_total = ticker_total + ws.Cells(i, "G").Value
        
    End If
    Next i
     
    'column details for the percentage change variables
     
    ws.Range("K2:K" & lastrow).NumberFormat = "0.00%"
    
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"

'create variables for the percentage change

Dim open_value As Double
Dim close_value As Double
Dim yearly_change As Double
Dim percent_change As Double

' set a counter
Dim counter As Integer
counter = 2

open_value = ws.Range("C2").Value
    
    For i = 3 To lastrow
    
    If (ws.Cells(i, 1).Value <> ws.Cells(i + 1, 1).Value) Then
    
        close_value = ws.Cells(i, 6).Value
        yearly_change = close_value - open_value
        percent_change = (yearly_change / open_value)
            
        ws.Range("J" & counter).Value = yearly_change
        ws.Range("K" & counter).Value = percent_change
        
        If yearly_change >= 0 Then
            ws.Range("J" & counter).Interior.ColorIndex = 4
        Else
            ws.Range("J" & counter).Interior.ColorIndex = 3
        End If
        
        counter = counter + 1
        
        open_value = ws.Cells(i + 1, 3).Value
        
    End If
    Next i
    
    ''Determine the greatest increase and decrease
    
    
    Dim greatest_Inc As Double
    Dim greatest_dec As Double
    Dim max_vol As Long
        
    Dim Inc_Ticker As String
    Dim Dec_Ticker As String
    Dim total_ticker As String
    
    
    ws.Range("P1").Value = "Ticker"
    ws.Range("Q1").Value = "Value"
    ws.Range("O2").Value = "Greatest % Increase"
    ws.Range("O3").Value = "Greatest % Decrease"
    ws.Range("O4").Value = "Greatest Total Volume"
    
    
    greatest_Inc = ws.Range("K2").Value
    greatest_dec = greatest_dec
    max_vol = clng(ws.Range("L2").Value)
    
    
    For i = 3 To (counter - 1)
        If ws.Cells(i, 11).Value > greatest_Inc Then
            greatest_Inc = ws.Cells(i, 11).Value
            Inc_Ticker = ws.Cells(i, 9).Value
           
        ElseIf ws.Cells(i, 11).Value < greatest_dec Then
            greatest_dec = ws.Cells(i, 11).Value
            Dec_Ticker = ws.Cells(i, 9).Value
        End If
        
        If ws.Cells(i, 12).Value > max_vol Then
            max_vol = ws.Cells(i, 12).Value
            total_ticker = ws.Cells(i, 9).Value
            
        End If
    
    Next i
    
    ws.Range("P2").Value = Inc_Ticker
    ws.Range("Q2").Value = greatest_Inc
    
    ws.Range("P3").Value = Dec_Ticker
    ws.Range("Q3").Value = greatest_dec
    
    ws.Range("P4").Value = total_ticker
    ws.Range("Q4").Value = max_vol
    
    ws.Range("Q2:Q3").NumberFormat = "0.00%"
     
Next ws
End Sub


    


