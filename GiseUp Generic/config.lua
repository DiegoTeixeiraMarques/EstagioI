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
--[[
	orientation = {

		default = "landscapeLeft",    -- Initial launch orientation
		--supported = { "portrait", "portraitUpsideDown" },  			  -- Table of allowed options for auto-orientation
		supported = { "landscapeLeft" },    -- Limitado a uma posição
	},


	android =
    {
        usesFeatures =
        {
            --{ name="android.hardware.camera", required=true },
            --{ name="android.hardware.location", required=false },
            --{ name="android.hardware.location.gps", required=false },
        },
	},


	iphone =
    {
        plist =
        {
            CFBundleIconFiles = {},  -- Required!
            UILaunchStoryboardName = "LaunchScreen",  -- Required!
            UIStatusBarHidden = true,
            CFBundleDisplayName = "Corona App",
            CFBundleName = "Corona App",
        },
	},
	--]]
}
