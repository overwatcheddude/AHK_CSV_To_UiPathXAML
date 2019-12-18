#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetKeyDelay, -1 ; No delays when typing.

;This is a library I downloaded from github. it can be found here: https://github.com/hi5/CSV
#Include C:\Users\DPS-PC\Downloads\CSV_To_UiPathXML\csv.ahk

;Loads the CSV file. The 1st parameter is name of the CSV file. The 2nd is the identifer (ID). The third is the delimiter, which I set as comma.
CSV_Load("ListOfCountriesAndTheirCapitals.csv", "CSV", ",")

totalRows := CSV_TotalRows("CSV")
;MsgBox, "Total rows is %totalRows%"

;2nd parameter is Row. 3rd parameter is Column
;MyCell := CSV_ReadCell("CSV", 2, 1)
;MsgBox, "Cell contains: %MyCell%"

;Allows the user to enter counters.
InputBox, count , Please type the counter
InputBox, incrementalCounter , Please type the incrementalCounter

;Focus on notepad++.
WinActivate, ahk_exe notepad++.exe

Loop, 15
{
    ;Read the country and capital, row by row. "count" is row number. 1 and 2 are the first and second columns.
    Country := CSV_ReadCell("CSV", count, 1)
    Capital := CSV_ReadCell("CSV", count, 2)

    ;This doesn't work, even when escaping double quotes. No errors are displayed.
    ;FileAppend, <maes:AddToDictionary x:TypeArguments="x:String, x:String" Dictionary="[Dictionary]" DisplayName="Add to dictionary" sap:VirtualizedContainerService.HintSize="397.6,135.2" sap2010:WorkflowViewState.IdRef="AddToDictionary``2_%incrementalCounter%" Key="%Capital% is capital of" Value="%Country%" />, C:\Users\DPS-PC\Downloads\CSV_To_UiPathXML\Results.txt
    
    ;This is the XAML code. I need it to automate Uipath code writing.
    SendRaw, <maes:AddToDictionary x:TypeArguments="x:String, x:String" Dictionary="[Dictionary]" DisplayName="Add to dictionary" sap:VirtualizedContainerService.HintSize="397.6,135.2" sap2010:WorkflowViewState.IdRef="AddToDictionary``2_%incrementalCounter%" Key="%Capital% is capital of" Value="%Country%" />

    ;Move to a new line in notepad.
    Send, {ENTER}

    ;Move to the next row.
    count++

    ;Increase counter by one. Every ID reference must be unique.
    incrementalCounter++
}

;MsgBox, "Went through %count% out of %totalRows% rows!"

;Reloads the app after 15 rows are read. After every 15 rows, the app breaks, that's why this specific number has been set.
Reload

;Press F2 to quit the scrip if it messes up.
F2::
ExitApp