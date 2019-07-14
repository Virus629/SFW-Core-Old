AddEventHandler('sfw:getModules', function(cb) 
    cb(SFW)
end)

function getModules()
	return SFW
end