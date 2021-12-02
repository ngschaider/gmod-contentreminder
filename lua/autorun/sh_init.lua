CR = {}
CR.LeftRightColor = {}
CR.Text = {}
CR.descriptiontext = {}

if CLIENT then
	
	include( "sh_config.lua" )
	
	surface.CreateFont( "cr_trebuchet1", {
		font = "Trebuchet24", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		size = CR.descriptiontext.size,
		weight = CR.descriptiontext.weight
	})

	local function derma_assi(w, h, col)		
		
		--background
		surface.SetDrawColor(col)
		surface.DrawRect(0, 0 , w, h)

		-- color for left and right
		surface.SetDrawColor( CR.LeftRightColor.Red, CR.LeftRightColor.Green, CR.LeftRightColor.Blue, CR.LeftRightColor.Alpha )
		
		--left
		surface.DrawRect(0, 0 , 3, h)

		--right
		surface.DrawRect(w-3, 0 , w-3, h)
		
	end

	function ShowCRMenu()
		
		// My Screen resolution right monitor:  1600 x 900
		// My Screen resolution left monitor : 1920 x 1080

		
		
		local w = ScrW()
		local h = ScrH()
		
		//print( w, h )
			
		local frame = vgui.Create("DFrame")
		frame:SetSize(w - w*0.5, h - h*0.5)
		frame:Center()
		frame:MakePopup()
		frame:ShowCloseButton( false )
		
		local fw = frame:GetWide()
		local fh = frame:GetTall()

		frame:SetTitle( "" )

		frame.Paint = function ()
			derma_assi(fw, fh, CR.windowBackground)
		end
			
		local showagain = vgui.Create( "DCheckBoxLabel", frame ) // Create the checkbox
		showagain:SetPos( fw - w*0.28, fh - h*0.068 )						// Set the position
		showagain:SetText( CR.ShowAgainText )					// Set the text next to the box
		showagain:SetValue( CR_getdontshow() )			 // Initial value ( will determine whether the box is ticked too )
		showagain:SizeToContents()					 // Make its size the same as the contents
		showagain.OnChange = function()
			//print( showagain:GetChecked() )
		end
		
			
		local line1 = vgui.Create( "DLabel", frame )
		line1:SetSize( w*0.75, h )
		line1:SetText("")
		line1:SetPos( w*0.05, h*0.07 )
		line1.Paint = function()
			draw.DrawText( CR.Text.Line1 , "Trebuchet24", 0, 0, Color(255, 255, 255) )
		end
		
		local line2 = vgui.Create( "DLabel", frame )
		line2:SetSize( w*0.75, h )
		line2:SetText("")
		
		line2:SetPos( w*0.05, h*0.10 )
		line2.Paint = function()
			draw.DrawText( CR.Text.Line2 , "Trebuchet24", 0, 0, Color(255, 255, 255) )
		end

		local line3 = vgui.Create( "DLabel", frame )
		line3:SetSize( w*0.75, h )
		line3:SetText("")
		line3:SetPos( w*0.05, h*0.16 )
		line3.Paint = function()
			draw.DrawText( CR.Text.Line3 , "cr_trebuchet1", 0, 0, Color(255, 255, 255) )
		end
		
		local line4 = vgui.Create( "DLabel", frame )
		line4:SetSize( w*0.75, h )
		line4:SetText("")
		line4:SetPos( w*0.05, h*0.19 )
		line4.Paint = function()
			draw.DrawText( CR.Text.Line4 , "cr_trebuchet1", 0, 0, Color(255, 255, 255) )
		end
		
		local line5 = vgui.Create( "DLabel", frame )
		line5:SetSize( w*0.75, h )
		line5:SetText("")
		line5:SetPos( w*0.05, h*0.22 )
		line5.Paint = function()
			draw.DrawText( CR.Text.Line5 , "cr_trebuchet1", 0, 0, Color(255, 255, 255) )
		end
			
			
		local linkClipboard = vgui.Create( "DLabel", frame )
		linkClipboard:SetSize( w*0.75, h*0.027 )
		linkClipboard:SetText("")
		linkClipboard:SetPos( w*0.05, h*0.32 )
		linkClipboard.Paint = function()
			draw.DrawText( CR.clipboard_text , "Trebuchet24", 0, 0, Color(255, 255, 255) )
		end
		linkClipboard:SetMouseInputEnabled( true ) -- We must accept mouse input
		function linkClipboard:DoClick() -- Defines what should happen when the label is clicked
			if showagain then CR_setdontshow( showagain:GetChecked() ) end
			if frame then frame:Close() end
			
			print( "Copying '".. CR.web_link .."' to Clipboard" )
			SetClipboardText( CR.web_link )

			LocalPlayer():ChatPrint( CR.clipboard_message )
		end
		
		local linkBrowser = vgui.Create("DButton", frame)
		linkBrowser:SetSize( w*0.156,h*0.083 )
		linkBrowser:SetPos( w*0.05, h*0.375 )
		linkBrowser:SetText("")
		linkBrowser.DoClick = function()
			if showagain then CR_setdontshow( showagain:GetChecked() ) end
			if frame then frame:Close() end
			
			print( "Opening link '".. CR.web_link .."' in Steam Overlay Browser" )
			gui.OpenURL( CR.web_link )
		end
		linkBrowser.Paint = function()
			derma_assi( linkBrowser:GetWide(), linkBrowser:GetTall(), CR.button_color ) //  Color(50, 150, 150,255)
			draw.DrawText( CR.button_text, "Trebuchet24", linkBrowser:GetWide()*.5, linkBrowser:GetTall()*.3, Color(255, 255, 255),TEXT_ALIGN_CENTER)
		end
		
			
		local closebtn = vgui.Create( "DButton", frame )
		closebtn:SetSize( w*0.022 , h*0.039 )
		closebtn:SetText("")
		closebtn:SetPos( fw - w*0.038, h*0.022 )
		closebtn.DoClick = function()
			if showagain then CR_setdontshow( showagain:GetChecked() ) end
		
			frame:Close()
		end
		closebtn.Paint = function()
			derma_assi( closebtn:GetWide(), closebtn:GetTall(), CR.windowBackground )
			draw.DrawText("X", "Trebuchet24", closebtn:GetWide()*.5, closebtn:GetTall()*.15, CR.closebtnColor, TEXT_ALIGN_CENTER)
		end
		
	end
	concommand.Add( "cr_menu", ShowCRMenu )

	function CR_getdontshow()
		if file.Exists( "content_reminder_showagain.txt", "DATA" ) then
			return false
		else
			return true
		end
	end
	
	function CR_setdontshow(checkbox)
		if checkbox then // WE WANT TO HIDE THE WINDOW
			if file.Exists( "content_reminder_showagain.txt", "DATA" ) then
				file.Delete( "content_reminder_showagain.txt" )
			end
		else // We want to SHOW THE WINDOW AGAIN
			if file.Exists( "content_reminder_showagain.txt", "DATA" ) then
				return
			else
				file.Write( "content_reminder_showagain.txt", "Content Reminder Addon by Swapy97 ( STEAM_0:1:40931233 )" )
			end
		end
	end
	
	net.Receive( "ShowCRMenu", function()
		if CR_getdontshow() or net.ReadString() == "PlayerSay" then
			LocalPlayer():ConCommand( "cr_menu" )
		end
	end )
	
end

if SERVER then

	AddCSLuaFile( "sh_config.lua" )
	include( "sh_config.lua" )

	util.AddNetworkString( "ShowCRMenu" )
	
	if not CR.OpeningDelay or CR.OpeningDelay < 2 then // If not set or it's too small
		CR.OpeningDelay = 2
	else
		CR.OpeningDelay = CR.OpeningDelay + 2       //offset so that the time is adjusted correctly
	end
	
	hook.Add( "PlayerInitialSpawn", "ShowCRMenu", function( ply )
		timer.Simple( CR.OpeningDelay, function()
			if CR.OpenOnJoin and ply:IsValid() then
				net.Start( "ShowCRMenu" )
					net.WriteString( "PlayerInitialSpawn" )
				net.Send( ply )
			end
		end )
	end	)

	function CR_chat( ply, text, public )
		if string.sub( string.lower( text ), 1, string.len( CR.ChatCommand ) ) == string.lower( CR.ChatCommand ) and CR.OpenOnChatCommand then 
			net.Start( "ShowCRMenu" )
				net.WriteString( "PlayerSay" )
			net.Send( ply )
			return false
		end
	end
	hook.Add( "PlayerSay", "chatCommand", CR_chat );
	
	print( "Content-Reminder by Swapy97 successfully initialized" )
	
end