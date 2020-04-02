--ActionButtonTemplate
local MAJOR_VERSION = "BananaBar2Scanner-2.0"
local MINOR_VERSION = "$Rev: 0001 $"
--Locale
local L = LibStub("AceLocale-3.0"):GetLocale("BananaBar2")

local BananaBar2Scanner = LibStub:NewLibrary("BananaBar2Scanner-2.0", 1)

local SecureActionQueue = LibStub("SecureActionQueue-2.0")

-- Constants
local HUNTERSMARK_TEXTURE = "Interface\\Icons\\Ability_Hunter_SniperShot";  --Magic
local HUNTERSMARK_TYPE = "Magic";
			

BananaBar2Scanner.RT_MAX = 8; --maximum number of raidsymbol targets
BananaBar2Scanner.HT_MAX = 80; --maximum number of huntersmark targets
BananaBar2Scanner.UT_MAX = 80; --maximum number of random targets


BananaBar2Scanner.RT_FIRST = 1;   -- starting index for found targets with raid  
BananaBar2Scanner.HT_FIRST = 101; -- starting index for found targets with huntersmark 
BananaBar2Scanner.UT_FIRST = 201; -- starting index for found random targets

local IDX_PARTY = 101;
local IDX_PARTYPET = 201;
local IDX_RAID = 301;
local IDX_RAIDPET = 401;
local IDX_PLAYER = 501;
local IDX_PET = 601;
local IDX_PARTYTARGET = 1101;
local IDX_PARTYPETTARGET = 1201;
local IDX_RAIDTARGET = 1301;
local IDX_RAIDPETTARGET = 1401;
local IDX_PLAYERTARGET = 1501;
local IDX_PETTARGET = 1601;



BananaBar2Scanner.UNITS = {
    [101] = "party1",
    [102] = "party2",
    [103] = "party3",
    [104] = "party4",

    [201] = "partypet1",
    [202] = "partypet2",
    [203] = "partypet3",
    [204] = "partypet4",

    [301] = "raid1",
    [302] = "raid2",
    [303] = "raid3",
    [304] = "raid4",
    [305] = "raid5",
    [306] = "raid6",
    [307] = "raid7",
    [308] = "raid8",
    [309] = "raid9",
    [310] = "raid10",
    [311] = "raid11",
    [312] = "raid12",
    [313] = "raid13",
    [314] = "raid14",
    [315] = "raid15",
    [316] = "raid16",
    [317] = "raid17",
    [318] = "raid18",
    [319] = "raid19",
    [320] = "raid20",
    [321] = "raid21",
    [322] = "raid22",
    [323] = "raid23",
    [324] = "raid24",
    [325] = "raid25",
    [326] = "raid26",
    [327] = "raid27",
    [328] = "raid28",
    [329] = "raid29",
    [330] = "raid30",
    [331] = "raid31",
    [332] = "raid32",
    [333] = "raid33",
    [334] = "raid34",
    [335] = "raid35",
    [336] = "raid36",
    [337] = "raid37",
    [338] = "raid38",
    [339] = "raid39",
    [340] = "raid40",

    [401] = "raidpet1",
    [402] = "raidpet2",
    [403] = "raidpet3",
    [404] = "raidpet4",
    [405] = "raidpet5",
    [406] = "raidpet6",
    [407] = "raidpet7",
    [408] = "raidpet8",
    [409] = "raidpet9",
    [410] = "raidpet10",
    [411] = "raidpet11",
    [412] = "raidpet12",
    [413] = "raidpet13",
    [414] = "raidpet14",
    [415] = "raidpet15",
    [416] = "raidpet16",
    [417] = "raidpet17",
    [418] = "raidpet18",
    [419] = "raidpet19",
    [420] = "raidpet20",
    [421] = "raidpet21",
    [422] = "raidpet22",
    [423] = "raidpet23",
    [424] = "raidpet24",
    [425] = "raidpet25",
    [426] = "raidpet26",
    [427] = "raidpet27",
    [428] = "raidpet28",
    [429] = "raidpet29",
    [430] = "raidpet30",
    [431] = "raidpet31",
    [432] = "raidpet32",
    [433] = "raidpet33",
    [434] = "raidpet34",
    [435] = "raidpet35",
    [436] = "raidpet36",
    [437] = "raidpet37",
    [438] = "raidpet38",
    [439] = "raidpet39",
    [440] = "raidpet40",

    [501] = "player",
    [601] = "pet",

    [1101] = "party1target",
    [1102] = "party2target",
    [1103] = "party3target",
    [1104] = "party4target",

    [1201] = "partypet1target",
    [1202] = "partypet2target",
    [1203] = "partypet3target",
    [1204] = "partypet4target",

    [1301] = "raid1target",
    [1302] = "raid2target",
    [1303] = "raid3target",
    [1304] = "raid4target",
    [1305] = "raid5target",
    [1306] = "raid6target",
    [1307] = "raid7target",
    [1308] = "raid8target",
    [1309] = "raid9target",
    [1310] = "raid10target",
    [1311] = "raid11target",
    [1312] = "raid12target",
    [1313] = "raid13target",
    [1314] = "raid14target",
    [1315] = "raid15target",
    [1316] = "raid16target",
    [1317] = "raid17target",
    [1318] = "raid18target",
    [1319] = "raid19target",
    [1320] = "raid20target",
    [1321] = "raid21target",
    [1322] = "raid22target",
    [1323] = "raid23target",
    [1324] = "raid24target",
    [1325] = "raid25target",
    [1326] = "raid26target",
    [1327] = "raid27target",
    [1328] = "raid28target",
    [1329] = "raid29target",
    [1330] = "raid30target",
    [1331] = "raid31target",
    [1332] = "raid32target",
    [1333] = "raid33target",
    [1334] = "raid34target",
    [1335] = "raid35target",
    [1336] = "raid36target",
    [1337] = "raid37target",
    [1338] = "raid38target",
    [1339] = "raid39target",
    [1340] = "raid40target",

    [1401] = "raidpet1target",
    [1402] = "raidpet2target",
    [1403] = "raidpet3target",
    [1404] = "raidpet4target",
    [1405] = "raidpet5target",
    [1406] = "raidpet6target",
    [1407] = "raidpet7target",
    [1408] = "raidpet8target",
    [1409] = "raidpet9target",
    [1410] = "raidpet10target",
    [1411] = "raidpet11target",
    [1412] = "raidpet12target",
    [1413] = "raidpet13target",
    [1414] = "raidpet14target",
    [1415] = "raidpet15target",
    [1416] = "raidpet16target",
    [1417] = "raidpet17target",
    [1418] = "raidpet18target",
    [1419] = "raidpet19target",
    [1420] = "raidpet20target",
    [1421] = "raidpet21target",
    [1422] = "raidpet22target",
    [1423] = "raidpet23target",
    [1424] = "raidpet24target",
    [1425] = "raidpet25target",
    [1426] = "raidpet26target",
    [1427] = "raidpet27target",
    [1428] = "raidpet28target",
    [1429] = "raidpet29target",
    [1430] = "raidpet30target",
    [1431] = "raidpet31target",
    [1432] = "raidpet32target",
    [1433] = "raidpet33target",
    [1434] = "raidpet34target",
    [1435] = "raidpet35target",
    [1436] = "raidpet36target",
    [1437] = "raidpet37target",
    [1438] = "raidpet38target",
    [1439] = "raidpet39target",
    [1440] = "raidpet40target",

    [1501] = "playertarget",
    [1601] = "pettarget",
}











--- Constructor
function BananaBar2Scanner:Initialize()
    BananaBar2Scanner.TSRA = {ht_count = 0,ut_count = 0};
    BananaBar2Scanner.TSRB = {ht_count = 0,ut_count = 0};
    for i = 0,BananaBar2Scanner.RT_MAX-1,1 do
        BananaBar2Scanner.TSRA[BananaBar2Scanner.RT_FIRST+i] = {used = 0};
        BananaBar2Scanner.TSRB[BananaBar2Scanner.RT_FIRST+i] = {used = 0};
        BananaBar2Scanner.TSRA[BananaBar2Scanner.RT_FIRST+i].from = {};
        BananaBar2Scanner.TSRB[BananaBar2Scanner.RT_FIRST+i].from = {};
    end
    
    for i = 0,BananaBar2Scanner.HT_MAX-1,1 do
        BananaBar2Scanner.TSRA[BananaBar2Scanner.HT_FIRST+i] = {};
        BananaBar2Scanner.TSRB[BananaBar2Scanner.HT_FIRST+i] = {};
        BananaBar2Scanner.TSRA[BananaBar2Scanner.HT_FIRST+i].from = {};
        BananaBar2Scanner.TSRB[BananaBar2Scanner.HT_FIRST+i].from = {};
    end
    
    for i = 0,BananaBar2Scanner.UT_MAX-1,1 do
        BananaBar2Scanner.TSRA[BananaBar2Scanner.UT_FIRST+i] = {};
        BananaBar2Scanner.TSRB[BananaBar2Scanner.UT_FIRST+i] = {};
        BananaBar2Scanner.TSRA[BananaBar2Scanner.UT_FIRST+i].from = {};
        BananaBar2Scanner.TSRB[BananaBar2Scanner.UT_FIRST+i].from = {};
    end
end



function BananaBar2Scanner:AssistScan(i,target,unit,tt)
	
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

		local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(tt);

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
	if not MT then
		MT = BananaBar2Scanner:GetMt(unit);
		if MT then
			BananaBar2.AssistButtons[i]:SetButtonName2(MT)
		else
			BananaBar2.AssistButtons[i]:SetButtonName2("")
		end
	else
		BananaBar2.AssistButtons[i]:SetButtonName(MT)
	end
	BananaBar2.AssistButtons[i].TooltipInfo1 = tooltipInfo1;
	BananaBar2.AssistButtons[i].TooltipInfo2 = tooltipInfo2;
end

function BananaBar2Scanner:GetMt(unit)
	if UnitExists(unit) then
		if CT_RA_MainTanks then
			name = UnitName(unit);			
			if name then
				for i=1,10,1 do
					if CT_RA_MainTanks[i] == name then
						if i==10 then
							i = 0
						end
						return i;
					end 								
				end
			end
		end
	end
	return nil;
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
			self:AssistScan(i*5+j-4,BananaBar2Scanner.UNITS[1300+gruppen[i][j]],BananaBar2Scanner.UNITS[300+gruppen[i][j]],gruppen[i][j]); 
		end    
	end    
	
end

function BananaBar2Scanner:Scan()


    self:ResetScanBlock(BananaBar2Scanner.TSRA)
    self:AssistScanning();



    if UnitInRaid("player") then
        BananaBar2:Debug("Scanning Raid...");
        for i=1,GetNumGroupMembers(),1 do
          self:ScanUnit(BananaBar2Scanner.UNITS[300+i],nil); --raid*
          self:ScanUnit(BananaBar2Scanner.UNITS[1300+i],BananaBar2Scanner.UNITS[300+i]); --raid*target
        end    

        for i=1,GetNumGroupMembers(),1 do
          self:ScanUnit(BananaBar2Scanner.UNITS[400+i],nil); --raidpet*
          self:ScanUnit(BananaBar2Scanner.UNITS[1400+i],BananaBar2Scanner.UNITS[400+i]); --raidpet*target
        end    
        
        self:AssistScanning();
        
    elseif UnitInParty("player") then
        BananaBar2:Debug("Scanning Party...");
        -- party
        self:ScanUnit(BananaBar2Scanner.UNITS[501],nil); --player
        self:ScanUnit(BananaBar2Scanner.UNITS[1501],BananaBar2Scanner.UNITS[501]); --playertarget

        self:ScanUnit(BananaBar2Scanner.UNITS[601],nil); --pet
        self:ScanUnit(BananaBar2Scanner.UNITS[1601],BananaBar2Scanner.UNITS[601]); --pettarget

        for i=1,GetNumGroupMembers(),1 do
          self:ScanUnit(BananaBar2Scanner.UNITS[100+i],nil); --party*
          self:ScanUnit(BananaBar2Scanner.UNITS[1100+i],BananaBar2Scanner.UNITS[100+i]); --party*target
        end    

        for i=1,GetNumGroupMembers(),1 do
          self:ScanUnit(BananaBar2Scanner.UNITS[200+i],nil); --partypet*
          self:ScanUnit(BananaBar2Scanner.UNITS[1200+i],BananaBar2Scanner.UNITS[200+i]); --partypet*target
        end    
    else
        BananaBar2:Debug("Scanning Single...");
        self:ScanUnit(BananaBar2Scanner.UNITS[501],nil); --player
        self:ScanUnit(BananaBar2Scanner.UNITS[1501],BananaBar2Scanner.UNITS[501]); --playertarget

        self:ScanUnit(BananaBar2Scanner.UNITS[601],nil); --pet
        self:ScanUnit(BananaBar2Scanner.UNITS[1601],BananaBar2Scanner.UNITS[601]); --pettarget
    end    
  
end


function BananaBar2Scanner:Switch()
    local x = BananaBar2Scanner.TSRA;
    BananaBar2Scanner.TSRA = BananaBar2Scanner.TSRB;
    BananaBar2Scanner.TSRB = x;
    self:ResetScanBlock(BananaBar2Scanner.TSRA)
end

function BananaBar2Scanner:ResetScanBlock(block)
    block.ht_count = 0;
    block.ut_count = 0;
    for i = 0,BananaBar2Scanner.RT_MAX-1,1 do
        block[BananaBar2Scanner.RT_FIRST+i].used = 0;
    end
end

function BananaBar2Scanner:ScanUnit(unit,source)
    --BananaBar2:Print("ScanUnit "..(unit or "err").." "..(source or ""));
    
    if UnitExists(unit) then
        local rti = GetRaidTargetIndex(unit) or 0
        if rti ~= 0 then
            self:AddNewOrExistingRaidSymbolTarget(rti,unit,source);
            return;
        end
        -- checking if it is an already known target should be fastern than checking for huntersmark debuff
        -- if source is set, chechunit is a target of an other unit
        if source then
            if self:TestScanThisTarget(unit) then
                local ant = self:FindAlreadyScannedHtOrUt(unit);
                if ant then
                    -- yes it is an already known target in this scan
                    if ant < BananaBar2Scanner.UT_FIRST then
                        -- it is known al huntersmark target
                        self:AddSourceToExistingHuntersmarkTarget(ant,source)
                    else
                        -- it is known as random target
                        self:AddSourceToExistingUnmarkedTarget(ant,source)
                    end
                else
                    if self:UnitHasHuntersMark(unit) then
                        self:AddNewHuntersmarkTarget(unit,source)
                    else
                        self:AddNewUnmarkedTarget(unit,source)
                    end
                end
            end
        end
    end
end


function BananaBar2Scanner:AddNewOrExistingRaidSymbolTarget(rti,unit,source)
    --BananaBar2:Debug("AddNewOrExistingRaidSymbolTarget");
    if BananaBar2Scanner.TSRA[rti].used == 1 then
        -- this symbol has already been found before, fields already filled
        if source then
            BananaBar2Scanner.TSRA[rti].from[BananaBar2Scanner.TSRA[rti].fromcount] = source;
            BananaBar2Scanner.TSRA[rti].fromcount = BananaBar2Scanner.TSRA[rti].fromcount+1;
        end
    else
        BananaBar2Scanner.TSRA[rti].used = 1;
        if source then
            BananaBar2Scanner.TSRA[rti].from[0] = source;
            BananaBar2Scanner.TSRA[rti].fromcount = 1;
        else
            BananaBar2Scanner.TSRA[rti].fromcount = 0;
        end
        self:FillTargetInfo(rti,unit);
    end
end

function BananaBar2Scanner:FindAlreadyScannedHtOrUt(unit)
    --assert(unit);
    if BananaBar2Scanner.TSRA.ht_count > 0 then
        for i = BananaBar2Scanner.HT_FIRST,BananaBar2Scanner.HT_FIRST+BananaBar2Scanner.TSRA.ht_count-1,1 do
            if UnitIsUnit(unit,BananaBar2Scanner.TSRA[i].info_unit) then
                return i;
            end
        end
    end
    if BananaBar2Scanner.TSRA.ut_count > 0 then
        for i = BananaBar2Scanner.UT_FIRST,BananaBar2Scanner.UT_FIRST+BananaBar2Scanner.TSRA.ut_count-1,1 do
            if UnitIsUnit(unit,BananaBar2Scanner.TSRA[i].info_unit) then
                return i;
            end
        end
    end
    return nil;    
end

function BananaBar2Scanner:AddSourceToExistingHuntersmarkTarget(ant,source)
    --assert(ant);
    --assert(source);
    -- this symbol has already been found before, fields already filled
    BananaBar2Scanner.TSRA[ant].from[BananaBar2Scanner.TSRA[ant].fromcount] = source;
    BananaBar2Scanner.TSRA[ant].fromcount = BananaBar2Scanner.TSRA[ant].fromcount+1;
end

function BananaBar2Scanner:AddSourceToExistingUnmarkedTarget(ant,source)
    --assert(ant);
    --assert(source);
    -- this symbol has already been found before, fields already filled
    BananaBar2Scanner.TSRA[ant].from[BananaBar2Scanner.TSRA[ant].fromcount] = source;
    BananaBar2Scanner.TSRA[ant].fromcount = BananaBar2Scanner.TSRA[ant].fromcount+1;
end

function BananaBar2Scanner:AddNewHuntersmarkTarget(unit,source)
    --assert(unit);
    --assert(source);
    local num = BananaBar2Scanner.HT_FIRST+BananaBar2Scanner.TSRA.ht_count;
    BananaBar2Scanner.TSRA.ht_count = BananaBar2Scanner.TSRA.ht_count+1;
--    if not BananaBar2Scanner.TSRA[num].from then
--        BananaBar2Scanner.TSRA[num].from = {};
--    end
    BananaBar2Scanner.TSRA[num].from[0] = source;
    BananaBar2Scanner.TSRA[num].fromcount = 1;
    self:FillTargetInfo(num,unit);
end

function BananaBar2Scanner:AddNewUnmarkedTarget(unit,source)
    --assert(unit);
    --assert(source);
    local num = BananaBar2Scanner.UT_FIRST+BananaBar2Scanner.TSRA.ut_count;
    BananaBar2Scanner.TSRA.ut_count = BananaBar2Scanner.TSRA.ut_count+1;
--    if not BananaBar2Scanner.TSRA[num].from then
--        BananaBar2Scanner.TSRA[num].from = {};
--    end
    BananaBar2Scanner.TSRA[num].from[0] = source;
    BananaBar2Scanner.TSRA[num].fromcount = 1;
    self:FillTargetInfo(num,unit);
end

function BananaBar2Scanner:FillTargetInfo(num,unit)
    BananaBar2Scanner.TSRA[num].info_unit = unit;
    BananaBar2Scanner.TSRA[num].info_name = UnitName(unit);
    BananaBar2Scanner.TSRA[num].info_dead = UnitIsDead(unit);
    BananaBar2Scanner.TSRA[num].info_health = UnitHealth(unit);
    BananaBar2Scanner.TSRA[num].info_healthmax = UnitHealthMax(unit);
end

function BananaBar2Scanner:UnitHasHuntersMark(unit)
    local iIterator = 1
    local debuffName, debuffRank, debuffTexture, debuffApplications, debuffDispelType = UnitDebuff(unit, iIterator,false);
    while (debuffTexture) do
        if debuffTexture==HUNTERSMARK_TEXTURE then
       		BananaBar2:Debug(debuffDispelType);
            if debuffDispelType == HUNTERSMARK_TYPE then
        		BananaBar2:Debug(HUNTERSMARK_TYPE);
                return true
            end
        end
        iIterator = iIterator + 1
    	debuffName, debuffRank, debuffTexture, debuffApplications, debuffDispelType = UnitDebuff(unit, iIterator,false);
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
        if UnitIsGroupLeader("player") then
            return true;
        end
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
		else
			--move
			SetRaidTarget(unit1,indexTo);
		end
	else
		if unit2 then
			--move
			SetRaidTarget(unit2,indexFrom);
		else
			BananaBar2:PlayError();
		end
	end
end


function BananaBar2Scanner:GetUnitBySymbol(index)
    if index >= BananaBar2Scanner.RT_FIRST and index <= BananaBar2Scanner.RT_MAX then
        if BananaBar2Scanner.TSRA[index].used == 1 then
            BananaBar2:Debug(BananaBar2Scanner.TSRA[index].info_unit);
            --search direct
            if GetRaidTargetIndex(BananaBar2Scanner.TSRA[index].info_unit) == index then
                return BananaBar2Scanner.TSRA[index].info_unit;
            else
              --search indirect         
              for from=0,BananaBar2Scanner.TSRA[index].fromcount-1,1 do
                  --BananaBar2:Print("symbol "..index.." ist targeted by "..BananaBar2Scanner.TSRA[index].from[from]);
                  if GetRaidTargetIndex(BananaBar2Scanner.TSRA[index].from[from].."target") == index then
                      return BananaBar2Scanner.TSRA[index].from[from].."target";
                  else
                      return nil; 
                  end
              end
              return nil; 
            end
        else
			return nil; 
        end
	elseif index >= 9 then
	    if index < BananaBar2Scanner.TSRA.ht_count+9 then
			if BananaBar2Scanner:UnitHasHuntersMark(BananaBar2Scanner.TSRA[index-9+BananaBar2Scanner.HT_FIRST].info_unit) then
				AssistUnit(BananaBar2Scanner.TSRA[index-9+BananaBar2Scanner.HT_FIRST].from[0]);
				BananaBar2:Debug("AssistUnit: "..BananaBar2Scanner.TSRA[index-9+BananaBar2Scanner.HT_FIRST].from[0]);
			else
				BananaBar2:Debug("Target Found but has no huntersmark");
			end
		else
			BananaBar2:Debug("Not used");
	    end
    end
end





function BananaBar2Scanner:SetSymbol(index)
	if index <= 8 then
		if GetRaidTargetIndex("target") == index then
			BananaBar2:PlayRemove();
			SetRaidTarget("target", 0);
		else
			SetRaidTarget("target", index);
			BananaBar2:PlaySet();
		end
	else
		BananaBar2:SpellHuntersmark();
	end
end


BananaBar2Scanner:Initialize();

