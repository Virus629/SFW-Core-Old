SFW.Math = {}

SFW.Math.Round = function(value, decimalsValues) --Idea from ESX
    if (value ~= nil) then
        return tonumber(string.format("%." .. (decimalsValues or 0) .. "f", value))
    elseif (value == nil) then
        return "error"
    end
end