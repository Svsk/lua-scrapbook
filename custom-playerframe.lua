-- Enable "All triggers"
-- Add as Trigger 2
-- Type = Custom
-- Event type = Event
-- Event(s) = PLAYER_ENTERING_WORLD

-- Custom trigger
function (e)
    local r = WeakAuras.regions["Player health"].region
    local b = CreateFrame("Button", "WAPlayerFrameButton", r, "SecureUnitButtonTemplate")
    
    b:SetAllPoints()
    
    b:SetAttribute("unit", "player")
    b:SetAttribute("type1", "target")
    
    b:SetScript("OnMouseDown", function(self, button)            
		if button == "RightButton" then
			ToggleDropDownMenu(1, nil, PlayerFrameDropDown, self, 0, 0)
		end
	end)
    
    return true
end

-- Custom untrigger
function (e)
	return false
end
