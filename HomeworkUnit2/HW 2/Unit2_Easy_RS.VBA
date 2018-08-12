Sub Stocks_tracker()

'to run this query on all worksheets

For Each ws In Worksheets
    
    'Define location to insert the summary table
    
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Total Stock Volume"
    
    'Define initial variables
    
    Dim ticker_name As String
    Dim ticker_total As Double
     
    
    ticker_total = 0
    
    'Check if we are within the same ticker else move to the next..
    
    Dim total_stock_vol As Integer
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
        ws.Range("J" & total_stock_vol).Value = ticker_total
       total_stock_vol = total_stock_vol + 1
       
       'Reset the ticker
       
      ticker_total = 0
        
        Else
        ticker_total = ticker_total + ws.Cells(i, "G").Value
        
    End If
    Next i
    Next ws
    End Sub
    
