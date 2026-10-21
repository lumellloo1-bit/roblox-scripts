
local Mapas = {
	["MapaInvierno"] = {
		["Atmosphere"] = {
			["Density"] = 0.3,
			["Offset"] = 0,
		},
		["Bloom"] = {
			["Intensity"] = 0.75,
			["Size"] = 22,
			["Threshold"] = 3.213
		},
		["Blur"] = {
			["Size"] = 1,
		},
		["ColorCorrection"] = {
			["Brightness"] = 0.1,
			["Contrast"] = 0,
			["Saturation"] = 1,
			["TintColor"] = Color3.new(1, 1, 1)
		},
		["SunRays"] = {
			["Intensity"] = 0.082,
			["Spread"] = 1
		},
		["Sky"] = {
			["SkyboxBk"] = "rbxasset://textures/sky/sky512_bk.tex",
			["SkyboxDn"] = "rbxasset://textures/sky/sky512_dn.tex",
			["SkyboxFt"] = "rbxasset://textures/sky/sky512_ft.tex",
			["SkyboxLf"] = "rbxasset://textures/sky/sky512_lf.tex",
			["SkyboxRt"] = "rbxasset://textures/sky/sky512_rt.tex",
			["SkyboxUp"] = "rbxasset://textures/sky/sky512_up.tex"
		},
		["Lighting"] = {
			["ClockTime"] = 20,
			["GeographicLatitude"] = 0
		}
	},
	["MapaOtono"] = {
		["Atmosphere"] = {
			["Density"] = 0.377,
			["Offset"] = 0,
		},
		["Bloom"] = {
			["Intensity"] = 1,
			["Size"] = 34,
			["Threshold"] =1.776
		},
		["Blur"] = {
			["Size"] = 1,
		},
		["ColorCorrection"] = {
			["Brightness"] = 0,
			["Contrast"] = 0.2,
			["Saturation"] =0.598,
			["TintColor"] = Color3.new(1, 1, 1)
		},
		["SunRays"] = {
			["Intensity"] = 0,
			["Spread"] =0
		},
		["Sky"] = {
			["SkyboxBk"] = "rbxassetid://600830446",
			["SkyboxDn"] = "rbxassetid://600831635",
			["SkyboxFt"] = "rbxassetid://600832720",
			["SkyboxLf"] = "rbxassetid://600886090",
			["SkyboxRt"] = "rbxassetid://600833862",
			["SkyboxUp"] = "rbxassetid://600835177"
		},
		["Lighting"] = {
			["ClockTime"] = 17.6,
			["GeographicLatitude"] = 0
		}
	},
	["MapaPrimavera"] = {
		["Atmosphere"] = {
			["Density"] = 0.442,
			["Offset"] = 0,
		},
		["Bloom"] = {
			["Intensity"] =1,
			["Size"] = 24,
			["Threshold"] = 2
		},
		["Blur"] = {
			["Size"] = 2,
		},
		["ColorCorrection"] = {
			["Brightness"] = -0.1,
			["Contrast"] = 0.1,
			["Saturation"] = 0.2,
			["TintColor"] = Color3.fromRGB(255, 255, 255)
		},
		["SunRays"] = {
			["Intensity"] = 0.25,
			["Spread"] = 1
		},
		["Sky"] = {
			["SkyboxBk"] = "rbxassetid://600830446",
			["SkyboxDn"] = "rbxassetid://600831635",
			["SkyboxFt"] = "rbxassetid://600832720",
			["SkyboxLf"] = "rbxassetid://600886090",
			["SkyboxRt"] = "rbxassetid://600833862",
			["SkyboxUp"] = "rbxassetid://600835177"
		},
		["Lighting"] = {
			["Ambient"] = Color3.fromRGB(70, 70, 70),
			["Brightness"] = 3,
			["ColorShift_Top"] = Color3.fromRGB(0, 0, 0),
			["ColorShift_Bottom"] = Color3.fromRGB(0, 0, 0),
			["EnvironmentDiffuseScale"] =1,
			["EnvironmentSpecularScale"] = 1,
			["OutdoorAmbient"] = Color3.fromRGB(70, 70, 70),
			["ShadowSoftness"] = 0.2,			
			["ClockTime"] = 14.5,
			["GeographicLatitude"] = 0,
			["ExposureCompensation"] = 0
		}
	},
	["MapaVerano"] = {
		["Atmosphere"] = {
			["Density"] = 0.361,
			["Offset"] = 0,
		},
		["Bloom"] = {
			["Intensity"] = 1,
			["Size"] = 45,
			["Threshold"] = 3.056
		},
		["Blur"] = {
			["Size"] = 2,
		},
		["ColorCorrection"] = {
			["Brightness"] = 0,
			["Contrast"] = 0.3,
			["Saturation"] = 0.5,
			["TintColor"] = Color3.fromRGB(255, 202, 138)
		},
		["SunRays"] = {
			["Intensity"] =0.016,
			["Spread"] = 1
		},
		["Sky"] = {
			["SkyboxBk"] = "rbxassetid://6444884337",
			["SkyboxDn"] = "rbxassetid://6444884785",
			["SkyboxFt"] = "rbxassetid://6444884337",
			["SkyboxLf"] = "rbxassetid://6444884337",
			["SkyboxRt"] = "rbxassetid://6444884337",
			["SkyboxUp"] = "rbxassetid://6412503613"
		},
		["Lighting"] = {
			["Ambient"] = Color3.fromRGB(152, 150, 121),
			["Brightness"] = 0,
			["ColorShift_Top"] = Color3.fromRGB(134, 134, 134),
			["ColorShift_Bottom"] = Color3.fromRGB(134, 134, 134),
			["EnvironmentDiffuseScale"] = 0.741,
			["EnvironmentSpecularScale"] = 0.192,
			["OutdoorAmbient"] = Color3.fromRGB(152, 150, 121),
			["ShadowSoftness"] = 0.2,			
			["ClockTime"] = 7.1,
			["GeographicLatitude"] =307,
			["ExposureCompensation"] =0.81
		}
	},
	["Lobby"] = {
		["Atmosphere"] = {
			["Density"] = 0.39,
			["Offset"] = 0,
		},
		["Bloom"] = {
			["Intensity"] = 1,
			["Size"] = 24,
			["Threshold"] = 1.85
		},
		["Blur"] = {
			["Size"] = 2,
		},
		["ColorCorrection"] = {
			["Brightness"] = 0.1,
			["Contrast"] = 0.8,
			["Saturation"] = 0.4,
			["TintColor"] = Color3.fromRGB(255, 193, 107)
		},
		["SunRays"] = {
			["Intensity"] =0.033,
			["Spread"] = 1
		},
		["Sky"] = {
			["SkyboxBk"] = "rbxassetid://600830446",
			["SkyboxDn"] = "rbxassetid://600831635",
			["SkyboxFt"] = "rbxassetid://600832720",
			["SkyboxLf"] = "rbxassetid://600886090",
			["SkyboxRt"] = "rbxassetid://600833862",
			["SkyboxUp"] = "rbxassetid://600835177"
		},
		["Lighting"] = {
			["Ambient"] = Color3.fromRGB(148, 148, 148),
			["Brightness"] = 1,
			["ColorShift_Top"] = Color3.fromRGB(255, 255, 255),
			["ColorShift_Bottom"] = Color3.fromRGB(255, 255, 255),
			["EnvironmentDiffuseScale"] = 0.407,
			["EnvironmentSpecularScale"] = 0,
			["OutdoorAmbient"] = Color3.fromRGB(252, 252, 252),
			["ShadowSoftness"] = 0,			
			["ClockTime"] = 15.6,
			["GeographicLatitude"] = 333,
			["ExposureCompensation"] = 0.11
		}
	}
	
}




return Mapas
