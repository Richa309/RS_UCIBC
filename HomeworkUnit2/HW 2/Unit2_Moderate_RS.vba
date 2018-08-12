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
    
    Dim total_stock_vol As Integer
    total_stock_vol = 2
    
    ' Since the data listing is different on each worksheet define the end point for the loop i
    
    lastrow = ws.Cells(Rows.count, 1).End(xlUp).Row
    
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
Dim yeraly_change As Double
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
    Next ws
    End Sub
    

