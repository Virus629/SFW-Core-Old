FRBS = FRBS or {} --Test from nopixel

FRBS.Debug = function(str) --Test idea from esx
    if settings.useDebug then
        print('^1[FRBS Debug]^0 >>> ^2' .. str .. '^0')
    end
end