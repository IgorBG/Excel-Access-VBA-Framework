Attribute VB_Name = "Functions"
Public Function ValueIsInCollection(col As Collection, key As String) As Boolean
Dim obj As Variant
On Error GoTo err
    ValueIsInCollection = True
    obj = col.Item(key)
    Exit Function
err:
    ValueIsInCollection = False
End Function

Public Function ObjectIsInCollection(col As Collection, key As String) As Boolean
Dim obj As Object
On Error GoTo err
    ObjectIsInCollection = True
    Set obj = col.Item(key)
    Exit Function
err:
    ObjectIsInCollection = False
End Function

Public Function IsMarkedParticularRange(ByVal Marked As Range, Optional ByVal CheckCol As Long, _
                                Optional ByVal StartRow As Long, Optional ByVal LastRow As Long) As Boolean
    Dim RngCell As Range
IsMarkedParticularRange = False
If CheckCol > 0 Then
    For Each RngCell In Selection.Rows
        If Not RngCell.Column = CheckCol Then GoTo FalseExit
    Next RngCell
End If
If StartRow > 0 Then
    For Each RngCell In Selection.Rows
        If RngCell.Row < StartRow Then GoTo FalseExit
    Next RngCell
End If
If LastRow > 0 Then
    For Each RngCell In Selection.Rows
        If RngCell.Row > LastRow Then GoTo FalseExit
    Next RngCell
End If
    'Here code will executes if only if it is needed range
        IsMarkedParticularRange = True
        Exit Function
            
FalseExit:
Exit Function

End Function




Public Function ExtractPartSizeFromName(ByVal ArtName As String) As Variant
' ��������� �� ������ �� ������ ��������� �� ������������, ������������ � ����� ��� ������� �� ������� ������������
    Dim Name As String, R As String
    Dim PosSym As Integer, PosSym2 As Integer
    Dim Result(0 To 2) As Double
On Error GoTo ErrHandler
' �������� ��������������� ��� �� ��������� - �������� �� ������� ����� � ������� ���������
Name = Replace(ArtName, "-", " ")
Name = WorksheetFunction.Trim(Name)
' ��� ���� � �������������� ���� ������� ���� �� �� ������ ���������� /, �� �� ������ �� �� ������ ����� / � ��������������. ��� ���� ������ �� ������ ������, ����� ����� �� ������������� �����.
' 1. ������ ��������, �������� � /
PosSym = InStrRev(Name, "/")
R = Mid(Name, PosSym + Len("/"), Len(Name) - PosSym)
        ' 1.1 ������ ���������� ���� /, �� �� ������� ������ ���� ���� /
        PosSym2 = InStr(R, " ")
        If PosSym2 <> 0 Then
            R = Left(R, PosSym2 - 1)
        End If
    '1.2. ��� ���������� ���� ������ �� �����, ����� ��� ������� ��������
    If IsNumeric(R) Then Result(1) = CDbl(R) Else Result(1) = 0
'2. �� ������� ����� ������ ���������
PosSym2 = InStrRev(Name, " ", PosSym)
R = Mid(Name, PosSym2 + Len(" "), PosSym - PosSym2 - Len(" "))
    If IsNumeric(R) Then Result(0) = CDbl(R) Else Result(0) = 0
R = vbNullString

'3. ������ ����������. �� ������� "��"
PosSym = InStr(Name, "��")
If PosSym <> 0 Then
    If Mid(Name, PosSym - 1, 1) = " " Then
        PosSym = PosSym - 1
    End If
    PosSym = PosSym - 1
    R = Left(Name, PosSym)
PosSym2 = InStrRev(R, " ", PosSym)
    If PosSym2 <> 0 Then
        R = Mid(R, PosSym2 + 1, Len(R) - PosSym2)
    End If
    If IsNumeric(R) Then Result(2) = CDbl(R) Else Result(2) = 0
End If
ExtractPartSizeFromName = Result
Exit Function

ErrHandler:
   Result(0) = 0:   Result(1) = 0:   Result(2) = 0
ExtractPartSizeFromName = Result
End Function

