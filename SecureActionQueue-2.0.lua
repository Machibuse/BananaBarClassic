--[[
Name: SecureActionQueue-2.0
Revision: $Rev: 101 $
Developed by: Bordeaux
Website: http://www.???????.com/
Documentation: http://www.???????.com/
SVN: http://svn.wowace.com/root/trunk/SecureActionQueue-2.0

Description: Queue events until out of combat.
Dependencies: AceLibrary, AceEvent-2.0
]]

local MAJOR_VERSION = "SecureActionQueue-2.0"
local MINOR_VERSION = "$Rev: 101 $"


local SheduleList = nil;
local InCombat = UnitAffectingCombat("player");




local SecureActionQueue = LibStub:NewLibrary("SecureActionQueue-2.0", 1)


function SecureActionQueue:PLAYER_REGEN_DISABLED()
    InCombat = true;
end

function SecureActionQueue:PLAYER_REGEN_ENABLED()
    InCombat = false;
    
    if SheduleList then
	    for sheduleid,param in pairs(SheduleList) do
	        self:Execute(param.type, param.par1, param.par2, param.par3, param.par4);
	    end
	    SheduleList = nil;
    end
end

function SecureActionQueue:Shedule(sheduleid,type,par1,par2,par3,par4)
    if InCombat then
        if not SheduleList then
        	SheduleList = {};
        end
        SheduleList[sheduleid]    =
        {
            ["type"] = type;
            ["par1"] = par1;
            ["par2"] = par2;
            ["par3"] = par3;
            ["par4"] = par4;
        }
    else
        self:Execute(type,par1,par2,par3,par4);
    end
end

function SecureActionQueue:Execute(type,par1,par2,par3,par4)
    --BananaBar2:Print("type "..type.." "..tostring(InCombat).." "..tostring(UnitAffectingCombat("player")))
    xpcall(self[type],onerror, self,par1,par2,par3,par4)
end

function onerror()
    BananaBar2:Debug("SecureActionQueue:Execute Failed")
end

------------------------------------------------------------------

function SecureActionQueue:FrameShow(frame)
    local sheduleid = "FRAME_VISIBLE_"..frame:GetName();
    self:Shedule(sheduleid,"FRAME_VISIBLE",frame,true);
end

function SecureActionQueue:FrameHide(frame)
    local sheduleid = "FRAME_VISIBLE_"..frame:GetName();
    self:Shedule(sheduleid,"FRAME_VISIBLE",frame,false);
end
    
function SecureActionQueue:FRAME_VISIBLE(frame,show)
    if show then
        --prnt("show"..tostring(show or "<nil>") );
        frame:Show();
    else
        --prnt("hide"..tostring(show or "<nil>") );
        frame:Hide();
    end
end

------------------------------------------------------------------

function SecureActionQueue:FrameSetAttribute(frame,key,value)
    local sheduleid = "FRAME_SETATTRIBUTE_"..frame:GetName().."#"..key;
    self:Shedule(sheduleid,"FRAME_SETATTRIBUTE",frame,key,value);
end

function SecureActionQueue:FRAME_SETATTRIBUTE(frame,key,value)
    frame:SetAttribute(key,value);
end

------------------------------------------------------------------

local function external(self, major, instance)
    if major == "AceEvent-2.0" then
        instance:embed(self)
        if instance:IsFullyInitialized() then
            self:AceEvent_FullyInitialized()
        else
            self:RegisterEvent("AceEvent_FullyInitialized")
        end
    end
end


