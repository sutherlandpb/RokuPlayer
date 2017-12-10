'********************************************************************
'**  Main
'** This contains the launch parameters stuff that enables the Roku to accept
'** REST calls that make it play videos via web commands.
'********************************************************************

Sub Main(launchParameters)

    if launchParameters.url <> invalid
    	port = CreateObject("roMessagePort")
    	screen = CreateObject("roVideoScreen")
    	screen.SetMessagePort(port)

    	' build a content-meta-data using the passed in URL   
    	screen.SetContent({
    		stream: { url: launchParameters.url }
    	})

    	' play the video
    	screen.Show()
    
    	while true
		' wait for an event from our video screen
		msg = Wait(0, port)

		if type(msg) = "roVideoScreenEvent"
			if msg.isScreenClosed()
			  exit while
			end if
		end if
    	end while
    
	screen.Close()	    

    else

	    'initialize theme attributes like titles, logos and overhang color
	    initTheme()

	    'prepare the screen for display and get ready to begin
	    screen=preShowHomeScreen("", "")
	    if screen=invalid then
		print "unexpected error in preShowHomeScreen"
		return
	    end if

	    'set to go, time to get started
	    showHomeScreen(screen)
    end if    

End Sub


'*************************************************************
'** Set the configurable theme attributes for the application
'** 
'** Configure the custom overhang and Logo attributes
'** Theme attributes affect the branding of the application
'** and are artwork, colors and offsets specific to the app
'*************************************************************

Sub initTheme()

    app = CreateObject("roAppManager")
    theme = CreateObject("roAssociativeArray")

    theme.OverhangOffsetSD_X = "72"
    theme.OverhangOffsetSD_Y = "31"
    theme.OverhangSliceSD = "pkg:/images/Overhang_Background_SD.png"
    theme.OverhangLogoSD  = "pkg:/images/Overhang_Logo_SD.png"

    theme.OverhangOffsetHD_X = "125"
    theme.OverhangOffsetHD_Y = "35"
    theme.OverhangSliceHD = "pkg:/images/Overhang_Background_HD.png"
    theme.OverhangLogoHD  = "pkg:/images/Overhang_Logo_HD.png"

    app.SetTheme(theme)

End Sub
