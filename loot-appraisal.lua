function (event, msg)     
    -- ...single item - "You receive loot: %s." -> item
    local PATTERN_LOOT_ITEM_SELF = LOOT_ITEM_SELF:gsub("%%s", "(.+)")
    
    -- ...multiple item - "You receive loot: %sx%d." -> item + quantity
    local PATTERN_LOOT_ITEM_SELF_MULTIPLE = LOOT_ITEM_SELF_MULTIPLE:gsub("%%s", "(.+)"):gsub("%%d", "(%%d+)")
    
    
    local ToItemID = function (itemString)
        if not itemString then
            return
        end
        
        local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, reforging, Name = string.find(itemString, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
        
        return tonumber(Id)
    end
    
    -- self
    local loottype, itemLink, quantity, source
    
    if msg:match(PATTERN_LOOT_ITEM_SELF_MULTIPLE) then
        loottype = "## self (multi) ##"
        itemLink, quantity = string.match(msg, PATTERN_LOOT_ITEM_SELF_MULTIPLE)
        
    elseif msg:match(PATTERN_LOOT_ITEM_SELF) then
        loottype = "## self (single) ##"
        itemLink = string.match(msg, PATTERN_LOOT_ITEM_SELF)
        quantity = 1
    end    
    
    if loottype then
        
        if not itemLink or not quantity then
            return
        end
        
        local itemID = ToItemID(itemLink)
        
        -- debug
        -- print(loottype);
        -- print(itemID);
        -- print(quantity);
        -- print(source);
        
        local copperValue = _G.TSM_API.GetCustomPriceValue("DBMinBuyout", "i:" .. tostring(itemID));
        
        if (copperValue == nil) then
            return
        end
        
        
        local goldValue = copperValue / 10000;
        local totalValue = goldValue * quantity;
        
        --print("Looted: " .. itemLink)
        print("Value is " .. tostring(totalValue) .. "g (" .. tostring(goldValue) .. "g each).")
        _G.TotalGold = (_G.TotalGold or 0) + totalValue
        return true 
    end
end

