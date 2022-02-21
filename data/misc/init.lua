local misc = {}

function misc.unpack(tbl)
	return
		-- Default options
		tbl.W or 1, 
		tbl.H or 1, 
		tbl.caption or nil, 
		tbl.onClick or function() return end, 
		tbl.color or nil,
		tbl.fontColor or nil,
     	tbl.centered or nil,
	    tbl.border or nil,
	    tbl.type or nil,

	    --Timer options
		tbl.interval or nil,
		tbl.onTime or nil
end

return misc