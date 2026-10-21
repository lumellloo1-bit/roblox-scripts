local DataStore = game:GetService("DataStoreService")

local DataManager = {}
DataManager.__index = DataManager

function DataManager.New(Key)
	local self = {}
	self.OrderedDataStore = DataStore:GetOrderedDataStore(Key)
	return setmetatable(self, DataManager)
end

function DataManager:GetTop(Order, Amount, MinValue, MaxValue)
	local PageSize = Amount or 100
	MinValue = MinValue or 1
	MaxValue = MaxValue or math.huge
	
	local Page;
	pcall(function()
		Page = self.OrderedDataStore:GetSortedAsync(Order, PageSize, MinValue, MaxValue)
	end)
	
	if Page then 
		return Page:GetCurrentPage()
	end
end

function DataManager:SaveAsync(Key, Value)
	local Succes, Error = pcall(function()
		self.OrderedDataStore:SetAsync(Key, Value)
	end)
	
	return Succes, Error
end

function DataManager:RemoveAsync(Key)
	pcall(function()
		self.OrderedDataStore:RemoveAsync(Key)
	end)
end

function DataManager:CleanStore()
	local Page;
	
	pcall(function()
		Page = self.OrderedDataStore:GetSortedAsync(false, 100)
	end)
	
	if Page then 
		task.spawn(function()
			repeat 
				local CurrentPage = Page:GetCurrentPage()

				for _, Data in pairs(CurrentPage) do 
					self:RemoveAsync(Data.key)
				end

				if not Page.IsFinished then 
					Page:AdvanceToNextPageAsync()
				end
			until Page.IsFinished
		end)
	end
end

return DataManager
