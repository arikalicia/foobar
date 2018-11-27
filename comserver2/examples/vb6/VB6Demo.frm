VERSION 5.00
Begin VB.Form VB6DemoForm 
   Caption         =   "VB6Demo for foobar2000 automation server"
   ClientHeight    =   570
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6105
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   570
   ScaleWidth      =   6105
   StartUpPosition =   3  'Windows-Standard
   Begin VB.Label Display 
      Caption         =   "Not running"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5895
   End
End
Attribute VB_Name = "VB6DemoForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private WithEvents helper As Foobar2000Helper.ApplicationHelper07
Attribute helper.VB_VarHelpID = -1
Private app As Foobar2000.Application07
Private WithEvents playback As Foobar2000.Playback07
Attribute playback.VB_VarHelpID = -1


Private Sub DetectFoobar2000()
    'ignore error when object creation fails
    On Error GoTo NotRunning
    
    If Not helper Is Nothing Then
        If helper.Running Then
            Set app = helper.Server
        Else
            Set app = Nothing
        End If
    Else
        'it is important to leave out the first parameter instead of
        'setting it to ""
        Set app = GetObject(, "Foobar2000.Application.0.7")
    End If
    
    On Error GoTo 0
    
    Exit Sub
    
NotRunning:
    Set app = Nothing
End Sub

Private Sub UpdateDisplay()
    If playback.IsPlaying Then
        Dim status As String
        If playback.IsPaused Then
            status = "Paused"
        Else
            status = "Playing"
        End If
        Display.Caption = status & ": " & playback.FormatTitle("%artist% - %title%")
    Else
        Display.Caption = "Stopped"
    End If
End Sub

Private Sub Update()
    DetectFoobar2000
Start:
    If app Is Nothing Then
        Set playback = Nothing
        Display.Caption = "Not running"
    Else
        On Error GoTo Invalid
        Set playback = app.playback
        UpdateDisplay
    End If
    Exit Sub
    
Invalid:
    'MsgBox Err.Number & vbCrLf & Err.Source & vbCrLf & Err.Description
    If Err.Number = 462 Then
        Set app = Nothing
        GoTo Start
    Else
        Resume Next
    End If
End Sub

Private Sub Form_Load()
    Set helper = New ApplicationHelper07
    
    Update
End Sub

Private Sub helper_ServerStateChanged(ByVal bRunning As Boolean)
    Update
End Sub

Private Sub playback_InfoChanged()
    UpdateDisplay
End Sub

Private Sub playback_Started(ByVal bPaused As Boolean)
    UpdateDisplay
End Sub

Private Sub playback_Stopped(ByVal lStopReason As Foobar2000.fbStopReason)
    UpdateDisplay
End Sub

Private Sub playback_TrackChanged(ByVal bLocationChanged As Boolean)
    UpdateDisplay
End Sub
