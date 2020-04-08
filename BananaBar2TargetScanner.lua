--ActionButtonTemplate
local MAJOR_VERSION = "BananaBar2Scanner-2.0"
local MINOR_VERSION = "$Rev: 0001 $"
--Locale
local L = LibStub("AceLocale-3.0"):GetLocale("BananaBar2")

local BananaBar2Scanner = LibStub:NewLibrary("BananaBar2Scanner-2.0", 1)

local SecureActionQueue = LibStub("SecureActionQueue-2.0")


			



--- Constructor
function BananaBar2Scanner:Initialize()
    self.TARGETS = { };
    self.TARGETMARKS = { };
end

function BananaBar2Scanner:AssistScan(i,target,unit,raidIndex)
	
	local tooltipInfo1 = nil;
	local tooltipInfo2 = nil;
	BananaBar2.AssistButtons[i].AssistUnit = unit;
	BananaBar2.AssistButtons[i].AssistTarget = target;
	local MT = nil;

	if unit then
		if BananaBar2.AssistButtons[i].frame:GetAttribute("unit") ~= target then
			--BananaBar2:Print("set b"..i.."="..(target or "<nil>").." old="..(BananaBar2.AssistButtons[i].frame:GetAttribute("unit") or "<nil>"));
			SecureActionQueue:FrameSetAttribute(BananaBar2.AssistButtons[i].frame,"unit", target);
			SecureActionQueue:FrameSetAttribute(BananaBar2.AssistButtons[i].frame,"type2", "menu");
			SecureActionQueue:FrameSetAttribute(BananaBar2.AssistButtons[i].frame,"*type1", "target")
			BananaBar2.AssistButtons[i].frame.menu = BananaShowTargetDropDown;
		end
	else
		if BananaBar2.AssistButtons[i].frame:GetAttribute("unit") ~= "" then
			--BananaBar2:Print("clr b"..i.."="..(target or "<nil>").." old="..(BananaBar2.AssistButtons[i].frame:GetAttribute("unit") or "<nil>"));
			SecureActionQueue:FrameSetAttribute(BananaBar2.AssistButtons[i].frame,"unit", nil);
			SecureActionQueue:FrameSetAttribute(BananaBar2.AssistButtons[i].frame,"type2", nil);
			SecureActionQueue:FrameSetAttribute(BananaBar2.AssistButtons[i].frame,"*type1", nil)
			BananaBar2.AssistButtons[i].frame.menu = nil;
		end
	end    	

	if UnitExists(unit) then
		BananaBar2.AssistButtons[i].AssistUnit = unit;
		BananaBar2.AssistButtons[i].AssistTarget = target;

		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(raidIndex);

		if not online then
			BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_OFFLINE);
			tooltipInfo1 = "Offline";
			tooltipInfo2 = nil;
		elseif UnitIsGhost(unit) then
			BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_GHOST);
			MT = "";
			tooltipInfo1 = "Ghost released";
			tooltipInfo2 = nil;
		elseif isDead then
			BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_DEAD);
			MT = "";
			tooltipInfo1 = "Dead";
			tooltipInfo2 = nil;
		elseif CT_RA_Stats and CT_RA_Stats[name] and CT_RA_Stats[name]["AFK"] then
			BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_AWAY);		
			MT = "";
			tooltipInfo1 = "<AFK>";
			tooltipInfo2 = nil;
		else
			if UnitExists(target) then
				if UnitIsDead(target) then
					BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_X);
					MT = "";
					tooltipInfo1 = "has selected a dead target";
					tooltipInfo2 = UnitName(target);
				elseif UnitCanAttack(unit,target) then
					tooltipInfo1 = "has selected an enemy target";
					tooltipInfo2 = UnitName(target);
					local rti = GetRaidTargetIndex(target);
					if rti then
						BananaBar2.AssistButtons[i]:SetButtonSymbol(rti);
					else
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_ENEMY);
					end
				else
					tooltipInfo1 = "has selected an friendly target";
					tooltipInfo2 = UnitName(target);

					if fileName == "PRIEST" then
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_PRIEST);
						MT = BananaBar2Scanner:GetMt(target);
					elseif fileName == "PALADIN" then
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_PALADIN);
						MT = BananaBar2Scanner:GetMt(target);
					elseif fileName == "SHAMAN" then
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_SHAMAN);
						MT = BananaBar2Scanner:GetMt(target);
					elseif fileName == "DRUID" then
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_DRUID);
						MT = BananaBar2Scanner:GetMt(target);
					else
						local rti = GetRaidTargetIndex(target);
						if rti then
							BananaBar2.AssistButtons[i]:SetButtonSymbol(rti);
						else
							BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_FRIEND);
						end
					end												
				end;
			else
				BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_X);
				tooltipInfo1 = "has nothing selected";
				tooltipInfo2 = nil;
			end
		end
	else
		BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_NULL);
		tooltipInfo1 = nil;
		tooltipInfo2 = nil;
	end
    BananaBar2.AssistButtons[i]:SetButtonName2("") -- MT ehemals
	BananaBar2.AssistButtons[i].TooltipInfo1 = tooltipInfo1;
	BananaBar2.AssistButtons[i].TooltipInfo2 = tooltipInfo2;
end


local gruppen =
{
	[1] ={count=0},
	[2] ={count=0},
	[3] ={count=0},
	[4] ={count=0},
	[5] ={count=0},
	[6] ={count=0},
	[7] ={count=0},
	[8] ={count=0},
}


function BananaBar2Scanner:AssistScanning()
	gruppen =
	{
		[1] ={count=0},
		[2] ={count=0},
		[3] ={count=0},
		[4] ={count=0},
		[5] ={count=0},
		[6] ={count=0},
		[7] ={count=0},
		[8] ={count=0},
	}
	for i=1,40,1 do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		gruppen[subgroup][gruppen[subgroup].count] = i;
		gruppen[subgroup].count = gruppen[subgroup].count+1;
	end    
	for i=1,8,1 do
		if gruppen[i].count < 5 then
			for j=gruppen[i].count,4,1 do
				gruppen[i][j] = 0;
			end    
		end
	end    
	for i=1,8,1 do
		for j=0,4,1 do
			self:AssistScan(i*5+j-4,"RAIDTARGET"..gruppen[i][j],"RAID"..gruppen[i][j],gruppen[i][j]); 
		end    
	end    
	
end

function BananaBar2Scanner:GetUnitsToScan()
    local units = {}
    if UnitInRaid("player") then
        for unitNumber=1,40,1 do
            units["RAID"..unitNumber] = "";
            units["RAID"..unitNumber.."TARGET"] = "RAID"..unitNumber;
            units["RAIDPET"..unitNumber] = "";
            units["RAIDPET"..unitNumber.."TARGET"] = "RAIDPET"..unitNumber;
        end    
    else
        units["PLAYER"] = "";
        units["PLAYERTARGET"] = "PLAYER";
        units["PET"] = "";
        units["PETTARGET"] = "PET";

        if UnitInParty("player") then
            for unitNumber=1,4,1 do
                units["PARTY"..unitNumber] = "";
                units["PARTY"..unitNumber.."TARGET"] = "PARTY"..unitNumber;
                units["PARTYPET"..unitNumber] = "";
                units["PARTYPET"..unitNumber.."TARGET"] = "PARTYPET"..unitNumber;
            end    
        end
    end
    units["MOUSEOVER"] = "MOUSEOVER";
    return units;
end

function BananaBar2Scanner:Scan()


    self:ResetScanBlock()

    self:AssistScanning();

    local unitsToScan = self:GetUnitsToScan();

    for unit,unitparent in pairs(unitsToScan) do
        self:ScanUnit(unit,unitparent); 
    end
end

function BananaBar2Scanner:ResetScanBlock(block)
    self.TARGETS = { };
    self.TARGETMARKS = { };
end

function BananaBar2Scanner:ScanUnit(unit,source)
    
    if source == "" then
        source = nil;
    end

    if UnitExists(unit) then
        --BananaBar2:Print("ScanUnit "..unit);    
        local rti = GetRaidTargetIndex(unit)
        
        self:AddTargetToList(rti,unit,source);
    end
end


function BananaBar2Scanner:AddTargetToList(rti,unit,source)
    local guid = UnitGUID(unit)
    
    if rti then
        if self.TARGETMARKS[rti] == nil then
            self.TARGETMARKS[rti] = guid
        end
    end

    if self.TARGETS[guid] == nil then
        self.TARGETS[guid] = { }
        self.TARGETS[guid].from = {}
        self.TARGETS[guid].symbol = rti;
        self.TARGETS[guid].info_unit = unit;
        self.TARGETS[guid].info_name = UnitName(unit);
        self.TARGETS[guid].info_dead = UnitIsDead(unit);
        self.TARGETS[guid].info_health = UnitHealth(unit);
        self.TARGETS[guid].info_healthmax = UnitHealthMax(unit);
        self.TARGETS[guid].has_huntersmark = self:UnitHasHuntersMark(unit)
    end
    
    if source then
        self.TARGETS[guid].from[source] = 1;
    end
end

function BananaBar2Scanner:UnitHasHuntersMark(unit)
    local iIterator = 1
    local debuffName, debuffTexture, debuffApplications, debuffDispelType = UnitDebuff(unit, iIterator);
    while (debuffTexture) do

        if debuffTexture==132212 then
            return true
        end
        iIterator = iIterator + 1
    	debuffName, debuffTexture, debuffApplications, debuffDispelType = UnitDebuff(unit, iIterator);
    end
    return false
end

function BananaBar2Scanner:TestScanThisTarget(unit)
    if UnitCanAttack("player", unit)  and (not UnitIsCivilian(unit)) then
        return true;
    else
        return false;
    end
    --UnitExists
    --UnitIsDead
    --UnitIsCorpse
end

function BananaBar2Scanner:CanSetSymbols()
    if UnitInRaid("player") then
        if UnitIsGroupAssistant("player") or UnitIsGroupLeader("player") then
            return true;
        end
    elseif UnitInParty("player") then
        return true;
    else
        return true;
    end
    return false;
end

function BananaBar2Scanner:TargetSymbol(index)
	local unit = BananaBar2Scanner:GetUnitBySymbol(index);
	if unit then
		TargetUnit(unit);
	else
		BananaBar2:PlayError();
	end
end

function BananaBar2Scanner:ChangeSymbol(indexFrom, indexTo)
	local unit1 = BananaBar2Scanner:GetUnitBySymbol(indexFrom);
	local unit2 = BananaBar2Scanner:GetUnitBySymbol(indexTo);
	if unit1 then
		if unit2 then
			--swap
			SetRaidTarget(unit1,indexTo);
            SetRaidTarget(unit2,indexFrom);
            BananaBar2:PlaySet();
            BananaBar2:PlayRemove();
		else
			--move
			SetRaidTarget(unit1,indexTo);
            BananaBar2:PlaySet();
            BananaBar2:PlayRemove();
		end
	else
		if unit2 thensw
			--move
			SetRaidTarget(unit2,indexFrom);
            BananaBar2:PlaySet();
            BananaBar2:PlayRemove();
		else
			BananaBar2:PlayError();
		end
	end
end

function BananaBar2Scanner:GetUnitBySymbol(index)
    if self.TARGETMARKS[index] then
        return self.TARGETS[self.TARGETMARKS[index]].info_unit
    end
    return nil;
end

function BananaBar2Scanner:SetSymbol(index)
    BananaBar2:Print("ss")
    if GetRaidTargetIndex("target") == index then
        BananaBar2:PlayRemove();
        SetRaidTarget("target", 0);
    else
        SetRaidTarget("target", index);
        BananaBar2:PlaySet();
    end
end


BananaBar2Scanner:Initialize();

function tablelength(T)
    local count = 0
    for a in pairs(T) do 
        count = count + 1 
    end
    return count
end
