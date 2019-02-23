--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		width = 320,
		height = 480, 
		scale = "letterbox",
		fps = 60,
		
		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		--]]
	},

	orientation =
	{
		-- Supported values for orientation:
		-- portrait, portraitUpsideDown, landscapeLeft, landscapeRight
		
		default = "landscapeLeft",    -- Initial launch orientation
		--supported = { "portrait", "portraitUpsideDown" },  			  -- Table of allowed options for auto-orientation
		supported = { "landscapeLeft" },    -- Limitado a uma posição
	},

}
