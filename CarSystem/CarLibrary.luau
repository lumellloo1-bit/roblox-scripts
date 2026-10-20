local CarLibrary = {}

CarLibrary["CarValues"] = {
	DefaultValues = {
		Speed = 140, ReverseSpeed = 30, SpeedForce = 6000, ForwardSign = 1,

		Tire = {
			Radius = 1.30,
			MuLong = 1.25,
			MuLat  = 1.30,
			RollingResist = 0.013,
			RaycastPercentile = 0.4
		},

		Steering = {
			MaxSteerDegLow = 28,
			MaxSteerDegHigh = 4,
			SpeedForMaxReduction = 180,
			SteerRateDegPerSec = 170,
			ReturnRateDegPerSec = 230,
			Ackermann = true,
			YawGain = 1.05,
			YawAccelMax = 6.0,
			InvertSteer = false
		},

		CdA = 0.32,
		AirDensity = 1.2,

		SuspencionWeit = 3.5,
		FuerzaDeResorte = 1300,
		FuerzaAmortiguacion = nil,
		DampingRatio = 0.9,
		SuspensionForceMaxMult = 3.5,

		Engine = {
			RpmMin = 900,
			RpmMax = 7500,
			TorqueMinNm = 140,
			TorqueMaxNm = 480,
			TorqueCurveExp = 1.0,
			Inertia = 0.18,

			TorquePeakRpm  = 5200,
			TorqueSigmaRpm = 1600,
			MaxTorqueNm    = 650,
		},

		Transmission = {
			Gears = 6,
			FinalDrive = 3.20,
			FirstGearRatio = 2.20,
			TopGearRatio   = 0.85,
			AutoRatios     = true,

			SpeedBandsKmh = {
				{   0, 110},
				{ 110, 170},
				{ 170, 230},
				{ 230, 280},
				{ 280, 320},
				{ 320, 340},
			},

			BandMarginKmh     = 0,
			BandUpMarginKmh   = 6,
			BandDownMarginKmh = 8,
			BandFilterTime    = 0.20,
			BandHoldTimeUp    = 0.25,
			BandHoldTimeDown  = 0.25,
			TopGearStick      = 0.8,
			GearDwellTop      = 0.60,
			GearDwell         = 0.35,

			StudsToMeters     = 0.28,

			ShiftLatency      = 0.55,
			ShiftDragAcc      = 3.4,
			ShiftDownforceG   = 0.7,
			ShiftDownforceTime= 0.12,
			ShiftRpmBlendK    = 16.0,
			KickdownThrottle  = 0.86,
			MinShiftSpeed     = 0.0,
		},

		Brakes = {
			BrakeAcc = 28,
			ReverseEnableSpeed = 2.0
		},

		EngineSound = {
			SoundName = "Car Engine",
			RpmRef = 2000,
			BasePlaybackSpeed = 1.0,
			PitchSlopePer1000 = 0.36,
			MinPlaybackSpeed = 0.85,
			MaxPlaybackSpeed = 2.35,
			SmoothTimeUp = 0.10,
			SmoothTimeDown = 0.18,
			BaseVolume = 0.38,
			VolByThrottle = 0.55,
			VolByRpm = 0.27,
			ShiftPitchDip = 0.10
		},

		Wheels = {
			RDD = { Radius = 1.30, RestLen = 3.5, SpringK = 1300, DampingRatio = 0.9 },
			RDI = { Radius = 1.30, RestLen = 3.5, SpringK = 1300, DampingRatio = 0.9 },
			RTD = { Radius = 1.30, RestLen = 3.5, SpringK = 1300, DampingRatio = 0.9 },
			RTI = { Radius = 1.30, RestLen = 3.5, SpringK = 1300, DampingRatio = 0.9 },
		},
	},

	torpedo = {
		Speed = 340,
		ReverseSpeed = 30,
		SpeedForce = 6000,
		ForwardSign = 1,

		Tire = {
			Radius = 1.30,
			MuLong = 1.25,
			MuLat  = 1.30,
			RollingResist = 0.03,
			RaycastPercentile = 0.4
		},

		Steering = {
			MaxSteerDegLow = 28,
			MaxSteerDegHigh = 4,
			SpeedForMaxReduction = 180,
			SteerRateDegPerSec = 170,
			ReturnRateDegPerSec = 230,
			Ackermann = true,
			YawGain = 1.05,
			YawAccelMax = 6.0,
			InvertSteer = false
		},

		CdA = 0.1,
		AirDensity = 0.53,

		SuspencionWeit = 3.5,
		FuerzaDeResorte = 1300,
		FuerzaAmortiguacion = nil,
		DampingRatio = 0.9,
		SuspensionForceMaxMult = 3.5,
		Suspension = {
			TopLockTopEps       = 0.015,
			TopLockSlack        = 0.0,
			TopLockReleaseDelay = 0.05,

			TopLockLen = nil,
		},

		Engine = {
			RpmMin = 1500,
			RpmMax = 14000,
			TorqueMinNm = 680,
			TorqueMaxNm = 1600,
			TorqueCurveExp = 1.0,
			Inertia = 0.18,
			TorquePeakRpm  = 9000,
			TorqueSigmaRpm = 1600,
			MaxTorqueNm    = 650,
		},

		Transmission = {
			Gears = 7,
			FinalDrive = 3.20,
			FirstGearRatio = 2.20,
			TopGearRatio   = 2,
			AutoRatios     = false,
			Ratios = { 4, 3, 2.8, 2.4, 2.2, 1.8,1.68 },
			ReverseRatio  = 8,
			ReverseMaxKmh = 40,

			SpeedBandsKmh = {
				{   0, 50},
				{ 50, 90},
				{ 90, 130},
				{ 130, 180},
				{ 180, 230},
				{ 230, 280},
				{ 280, 350},

			},

			BandMarginKmh     = 0,
			BandUpMarginKmh   = 6,
			BandDownMarginKmh = 8,
			BandFilterTime    = 0.20,
			BandHoldTimeUp    = 0.25,
			BandHoldTimeDown  = 0.25,
			TopGearStick      = 0.8,
			GearDwellTop      = 0.60,
			GearDwell         = 0.35,

			StudsToMeters = 0.28,

			ShiftLatency     = 0.1,
			ShiftDragAcc     = 3.4,
			ShiftRpmBlendK   = 16.0,
			KickdownThrottle = 0.86,
			MinShiftSpeed    = 0.0,

			AeroGPerV2   = 0.25e-4,
			AeroGMax     = 1.5,
			BrakeNoseMaxG= 0.1,
			ShiftJoltTime= 0.08,
			ShiftJoltG   = 0.3,
			DownshiftNoseJoltG    = 0.1,
			DownshiftNoseJoltTime = 0.09,

			HillHoldThrottleDead = 0.05,
			HillHoldSpeed        = 0.60,
			HillHoldStopSpeed    = 0.12,
			HillHoldMaxAcc       = 20.0,

		},

		Brakes = {
			BrakeAcc = 100,
			ReverseEnableSpeed = 2.0
		},

		EngineSound = {
			SoundName = "Car Engine",
			RpmRef = 900,
			BasePlaybackSpeed = 1.0,
			PitchSlopePer1000 = 0.36,
			MinPlaybackSpeed = 0,
			MaxPlaybackSpeed = 10,
			SmoothTimeUp = 0,
			SmoothTimeDown = 0,
			BaseVolume = 0.38,
			VolByThrottle = 0.55,
			VolByRpm = 0.27,
			ShiftPitchDip = 0,
			MinVolume = 0.05,
			MaxVolume = 1.0,
		},

		Wheels = {
			RDD = { Radius = 2.97/2, RestLen = 2, SpringK = 2200, DampingRatio = 0.4 },
			RDI = { Radius = 2.97/2, RestLen = 2, SpringK = 2200, DampingRatio = 0.4 },
			RTD = { Radius = 2.97/2, RestLen = 2, SpringK = 2200, DampingRatio = 0.4 },
			RTI = { Radius = 2.97/2, RestLen = 2, SpringK = 2200, DampingRatio = 0.4 },
		},
	},
	dragCar = {
		Speed = 340,
		ReverseSpeed = 30,
		SpeedForce = 6000,
		ForwardSign = 1,

		Tire = {
			Radius = 1.30,
			MuLong = 1.25,
			MuLat  = 1.30,
			RollingResist = 0.03,
			RaycastPercentile = 0.4
		},

		Steering = {
			MaxSteerDegLow = 28,
			MaxSteerDegHigh = 4,
			SpeedForMaxReduction = 180,
			SteerRateDegPerSec = 170,
			ReturnRateDegPerSec = 230,
			Ackermann = true,
			YawGain = 1.05,
			YawAccelMax = 6.0,
			InvertSteer = false
		},

		CdA = 0.1,
		AirDensity = 0.53,

		SuspencionWeit = 3.5,
		FuerzaDeResorte = 1300,
		FuerzaAmortiguacion = nil,
		DampingRatio = 0.9,
		SuspensionForceMaxMult = 3.5,
		Suspension = {
			TopLockTopEps       = 0.015,
			TopLockSlack        = 0.0,
			TopLockReleaseDelay = 0.05,

			TopLockLen = nil,
		},

		Engine = {
			RpmMin = 15000,
			RpmMax = 30000,
			TorqueMinNm = 8000,
			TorqueMaxNm = 16000,
			TorqueCurveExp = 1.0,
			Inertia = 0.18,
			TorquePeakRpm  = 15000,
			TorqueSigmaRpm = 20000,
			MaxTorqueNm    = 6500,
		},

		Transmission = {
			Gears = 7,
			FinalDrive = 3.20,
			FirstGearRatio = 2.20,
			TopGearRatio   = 2,
			AutoRatios     = false,
			Ratios = { 1.68, 1.68, 1.68, 1.68, 1.68, 1.68,1.68 },
			ReverseRatio  = 8,
			ReverseMaxKmh = 40,

			SpeedBandsKmh = {
				{   0, 50},
				{ 50, 90},
				{ 90, 130},
				{ 130, 180},
				{ 180, 230},
				{ 230, 280},
				{ 280, 350},

			},

			BandMarginKmh     = 0,
			BandUpMarginKmh   = 6,
			BandDownMarginKmh = 8,
			BandFilterTime    = 0.20,
			BandHoldTimeUp    = 0.25,
			BandHoldTimeDown  = 0.25,
			TopGearStick      = 0.8,
			GearDwellTop      = 0.60,
			GearDwell         = 0.35,

			StudsToMeters = 0.28,

			ShiftLatency     = 0.1,
			ShiftDragAcc     = 3.4,
			ShiftRpmBlendK   = 16.0,
			KickdownThrottle = 0.86,
			MinShiftSpeed    = 0.0,

			AeroGPerV2   = 0.25e-4,
			AeroGMax     = 1.5,
			BrakeNoseMaxG= 0.1,
			ShiftJoltTime= 0.08,
			ShiftJoltG   = 0.3,
			DownshiftNoseJoltG    = 0.1,
			DownshiftNoseJoltTime = 0.09,

			HillHoldThrottleDead = 0.05,
			HillHoldSpeed        = 0.60,
			HillHoldStopSpeed    = 0.12,
			HillHoldMaxAcc       = 20.0,

		},

		Brakes = {
			BrakeAcc = 100,
			ReverseEnableSpeed = 2.0
		},

		EngineSound = {
			SoundName = "Car Engine",
			RpmRef = 900,
			BasePlaybackSpeed = 1.0,
			PitchSlopePer1000 = 0.36,
			MinPlaybackSpeed = 0,
			MaxPlaybackSpeed = 10,
			SmoothTimeUp = 0,
			SmoothTimeDown = 0,
			BaseVolume = 0.38,
			VolByThrottle = 0.55,
			VolByRpm = 0.27,
			ShiftPitchDip = 0,
			MinVolume = 0.05,
			MaxVolume = 1.0,
		},

		Wheels = {
			RDD = { Radius = 0.7/2, RestLen = 3, SpringK = 2000, DampingRatio = 0.4 },
			RDI = { Radius = 0.7/2, RestLen = 3, SpringK = 2000, DampingRatio = 0.4 },
			RTD = { Radius = 5/2, RestLen = 2, SpringK = 3000, DampingRatio = 0.4 },
			RTI = { Radius = 5/2, RestLen = 2, SpringK = 3000, DampingRatio = 0.4 },
		},
	},

}

	CarLibrary["CarsCFMrelatyve"] = {}
	CarLibrary["CarRelativeChangsCFrams"] = {}
	CarLibrary["CarLastFrameRedner"] = {}

	setmetatable(CarLibrary.CarValues, {
		__index = function(t, key) return rawget(t, "DefaultValues") end,
	})

	local function applyDefaults()
		local defaults = CarLibrary.CarValues.DefaultValues or {}
		defaults.Tire = defaults.Tire or {}
		defaults.Steering = defaults.Steering or {}
		defaults.Wheels = defaults.Wheels or {}
		defaults.Engine = defaults.Engine or {}
		defaults.Transmission = defaults.Transmission or {}

		for carType, cfg in pairs(CarLibrary.CarValues) do
			if carType ~= "DefaultValues" and type(cfg) == "table" then
				setmetatable(cfg, { __index = defaults })

				if type(cfg.Tire) ~= "table" then cfg.Tire = {} end
				setmetatable(cfg.Tire, { __index = defaults.Tire })

				if type(cfg.Steering) ~= "table" then cfg.Steering = {} end
				setmetatable(cfg.Steering, { __index = defaults.Steering })

				if type(cfg.Wheels) ~= "table" then cfg.Wheels = {} end
				setmetatable(cfg.Wheels, { __index = defaults.Wheels })

				if type(cfg.Engine) ~= "table" then cfg.Engine = {} end
				setmetatable(cfg.Engine, { __index = defaults.Engine })

				if type(cfg.Transmission) ~= "table" then cfg.Transmission = {} end
				setmetatable(cfg.Transmission, { __index = defaults.Transmission })
			end
		end
	end
	applyDefaults()

	return CarLibrary
