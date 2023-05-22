local ConsoleFontsAndSounds = {}

ConsoleFontsAndSounds.name = "ConsoleFontsAndSounds"

local gamepadFont_Light = "EsoUI/Common/Fonts/FTN47.otf"
local gamepadFont_Medium = "EsoUI/Common/Fonts/FTN57.otf"
local gamepadFont_Bold = "EsoUI/Common/Fonts/FTN87.otf"
local skyrimFont = "ConsoleFontsAndSounds/Fonts/fcm.ttf"

local THIN          = 'soft-shadow-thin'
local THICK         = 'soft-shadow-thick'
local SHADOW        = 'shadow'
local NONE          = 'none'

ConsoleFontsAndSounds.FONTSTYLE_VALUES =
{
  FONT_STYLE_NORMAL,
  FONT_STYLE_OUTLINE,
  FONT_STYLE_OUTLINE_THICK,
  FONT_STYLE_SHADOW,
  FONT_STYLE_SOFT_SHADOW_THICK,
  FONT_STYLE_SOFT_SHADOW_THIN,
}

local chatfontSize = 20
local charname = GetUnitName("player")

function ConsoleFontsAndSounds:Initialize()
    for key,value  in zo_insecurePairs(_G) do
        if (key):find("^Zo") and type(value) == "userdata" and value.SetFont then
		   local font = {value:GetFontInfo()}
		   if font[1] == "EsoUI/Common/Fonts/Univers47.otf" then
            font[1] = gamepadFont_Light
            font[2] = font[2] * 1.25
            value:SetFont(table.concat(font, "|"))
           end
           if font[1] == "EsoUI/Common/Fonts/Univers57.otf" then
            font[1] = gamepadFont_Medium
            font[2] = font[2] * 1.25
            value:SetFont(table.concat(font, "|"))
           end
           if font[1] == "EsoUI/Common/Fonts/Univers67.otf" then
            font[1] = gamepadFont_Medium
            font[2] = font[2] * 1.2
            value:SetFont(table.concat(font, "|"))
           end
        end
     end
    -- Update the chat system's font (edit box font won't change until updated)
    CHAT_SYSTEM:SetFontSize(CHAT_SYSTEM.GetFontSizeFromSetting())
     
    -- Set the Scrolling Combat Text font
    SetSCTKeyboardFont(gamepadFont_Bold .. "|" .. 42 .. "|",FONT_STYLE_SOFT_SHADOW_THICK)
    -- Set the Keyboard Nameplate font
    SetNameplateKeyboardFont(skyrimFont .. "|" .. 22 .. "|",FONT_STYLE_OUTLINE_THICK)
    --SetNameplateKeyboardFont(GetNameplateGamepadFont())

end

function ConsoleFontsAndSounds:ChangeChatFonts()
	    -- Entry Box
        ZoFontEditChat:SetFont(gamepadFont_Medium .. "|".. GetChatFontSize() .. "|", FONT_STYLE_SHADOW)

		-- Chat window
        ZoFontChat:SetFont(gamepadFont_Medium .. "|" .. GetChatFontSize() .. "|", FONT_STYLE_SOFT_SHADOW_THIN)
        CHAT_SYSTEM:SetFontSize(CHAT_SYSTEM.GetFontSizeFromSetting())
end

function ConsoleFontsAndSounds:UpdateSCTFonts()
  -- Set the Scrolling Combat Text font
  SetSCTKeyboardFont(gamepadFont_Bold .. "|" .. 42 .. "|",FONT_STYLE_SOFT_SHADOW_THICK)
  -- Set the Keyboard Nameplate font
  SetNameplateKeyboardFont(gamepadFont_Bold .. "|" .. 22 .. "|",FONT_STYLE_OUTLINE_THICK)
end

function ConsoleFontsAndSounds:SetupEvents(toggle)
  --EVENT_ZONE_CHANGED
  if toggle then
    EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_ACTIVATED, ConsoleFontsAndSounds.UpdateSCTFonts)
  else
    EVENT_MANAGER:UnregisterForEvent(self.name, EVENT_PLAYER_ACTIVATED)
  end
end

function ConsoleFontsAndSounds.OnAddonLoaded(event, addonName)
    if addonName ~= ConsoleFontsAndSounds.name then return end
    EVENT_MANAGER:UnregisterForEvent(ConsoleFontsAndSounds.name, EVENT_ADD_ON_LOADED, ConsoleFontsAndSounds.OnAddonLoaded)
    ConsoleFontsAndSounds.Initialize()
    ConsoleFontsAndSounds:SetupEvents(true)
		--ConsoleFontsAndSounds.ChangeChatFonts()
end

EVENT_MANAGER:RegisterForEvent(ConsoleFontsAndSounds.name, EVENT_ADD_ON_LOADED, ConsoleFontsAndSounds.OnAddonLoaded)