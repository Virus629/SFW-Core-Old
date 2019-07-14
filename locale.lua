--
-- TAKEN FROM es_extended 
-- ESX: https://github.com/ESX-Org/es_extended
-- ALL RIGHTS TO OWNER
-- 

Locales = {}

function _(str, ...) --Translate String

    if Locales[Setting.Locale] ~= nil then

        if Locales[Setting.Locale][str] ~= nil then
            return string.format(Locales[Setting.Locale][str], ...)
        else
            return 'Translation [' .. Setting.Locale .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Setting.Locale .. '] does not exist'
    end
end

function _U(str, ...)
    return tostring(_(str, ...):gsub('^1', string.upper))
end