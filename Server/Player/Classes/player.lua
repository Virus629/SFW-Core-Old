--
-- IDEA AND SOME PARTS ARE TAKEN (can be modded) FROM ESX AND ESSENTIALMODE  
-- 
--

function CreatePlayer(source, identifier, license, name, lastPosition, rank)
    local self = {}

    self.source       = source
    self.identifier   = identifier
    self.license      = license
    self.name         = name
    self.lastPosition = lastPosition
    self.rank         = rank
    
    self.getCoords = function()
        return self.coords
    end

    self.setCoords = function(x, y, z)
        self.coords = {x = x, y = y, z = z}
    end

    self.kick = function(reason)
        DropPlayer(self.source, reason)
    end

    self.getLastPosition = function()
        if self.lastPosition and self.lastPosition.x and self.lastPosition.y and self.lastPosition.z then
            self.lastPosition.x = SFW.Math.Round(self.lastPosition.x, 2)
            self.lastPosition.y = SFW.Math.Round(self.lastPosition.y, 2)
            self.lastPosition.z = SFW.Math.Round(self.lastPosition.z, 2)
        end

        return self.lastPosition
    end

    self.setLastPosition = function(position)
        self.lastPosition = position
    end
    
    self.getIdentifier = function()
        return self.identifier
    end

    self.getPlayer = function()
        return self.source
    end

    self.getName = function()
        return self.name
    end

    self.getRank = function()
        return self.rank
    end

    return self
end