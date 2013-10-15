' This script decodes the last update date for the latest XDB file in a given directory.

On Error Resume Next
Dim fso, folder, files, fNewest, sFolder
  Set fso = CreateObject("Scripting.FileSystemObject")
  sFolder = Wscript.Arguments.Item(0)

  sFolder=Replace(sFolder,"UPSPCTIME", " ")
  
  If sFolder = "" Then
      Wscript.Echo "No Folder parameter was passed"
      Wscript.Quit 2
  End If
  Set folder = fso.GetFolder(sFolder)
  Set files = folder.Files
  
	For each folderIdx In files
		If UCase(fso.GetExtensionName(folderIdx.Name)) = "VDB" Then
			If fNewest = "" Then
				Set fNewest = folderIdx
			Else
				If fNewest.DateCreated < folderIdx.DateCreated Then
					Set fNewest = folderIdx
				End If
			End If
		End If
	Next
	If fNewest = "" Then
		Wscript.Echo "Output No VDB file found"
		Wscript.Quit(2)
	Else
		baseName = fso.GetBaseName(fNewest.Name)
		
		XDBFile = sfolder & "\" & baseName & ".XDB"
		If not fso.FileExists(XDBFile) Then
			Wscript.Echo "No corresponding XDB file (" & XDBFile & ") found."
			Wscript.Quit(2)
		End If
		
		strBinary = ""
		For position = 3 to Len(baseName)
			currentHex = Mid(baseName,position, 1)
			Select Case UCase(currentHex)
				Case "0"
					strBinary = strBinary & "0000"
				Case "1"
					strBinary = strBinary & "0001"
				Case "2"
					strBinary = strBinary & "0010"
				Case "3"
					strBinary = strBinary & "0011"
				Case "4"
					strBinary = strBinary & "0100"
				Case "5"
					strBinary = strBinary & "0101"
				Case "6"
					strBinary = strBinary & "0110"
				Case "7"
					strBinary = strBinary & "0111"
				Case "8"
					strBinary = strBinary & "1000"
				Case "9"
					strBinary = strBinary & "1001"
				Case "A"
					strBinary = strBinary & "1010"
				Case "B"
					strBinary = strBinary & "1011"
				Case "C"
					strBinary = strBinary & "1100"
				Case "D"
					strBinary = strBinary & "1101"
				Case "E"
					strBinary = strBinary & "1110"
				Case "F"
					strBinary = strBinary & "1111"
			End Select
		Next
		
		yearBin=Mid(strBinary,1,6)
		monthBin=Mid(strBinary,7,4)
		dayBin=Mid(strBinary,11,5)
		revBin=Mid(strBinary,16,9)
		
		yearDec=BinToDec(yearBin)
		lastUpdateYear=1998 + yearDec
		monthDec=BinToDec(monthBin)
		dayDec=BinToDec(dayBin)
		revDec=BinToDec(revBin)
		
		If len(monthDec) = 1 then
			monthString = "0" & monthDec
		Else
			monthString = monthDec
		End If 
		If len(dayDec) = 1 then
			dayString = "0" & dayDec
		Else
			dayString = dayDec
		End If 
		
		lastUpdateString = monthDec & "/" & dayDec & "/" & lastUpdateYear 
		lastUpdateDate = CDate(lastUpdateString)
	End If
  

Wscript.Echo "daysSinceLastUpdate " & DateDiff("d",lastUpdateDate,now())
Wscript.Echo "lastUpdateDate " & lastUpdateYear & "-" & monthString & "-" & dayString  & " rev. " & revDec

' http://www.sonofsofaman.com/hobbies/code/bintodec.asp
Function BinToDec(strBin)
	dim lngResult
	dim intIndex
	
	lngResult = 0
	for intIndex = len(strBin) to 1 step -1
		strDigit = mid(strBin, intIndex, 1)
		select case strDigit
			case "0"
				'do nothing
			case "1"
				lngResult = lngResult + (2^ (len(strBin) - intIndex))
			case else
				'invalid
				lngResult = 0
				intIndex = 0 'stop loop
			end select
		next
		BinToDec = lngResult
End Function