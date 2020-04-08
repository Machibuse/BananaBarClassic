--ActionButtonTemplate


local MAJOR_VERSION = "BananaBar2Button-2.0"
local MINOR_VERSION = "$Rev: 101 $"
--Locale
local L = LibStub("AceLocale-3.0"):GetLocale("BananaBar2")

local BananaBar2Button = LibStub:NewLibrary("BananaBar2Button-2.0", 1)

function prnt(text)
    DEFAULT_CHAT_FRAME:AddMessage(tostring(text))
end

local BananaBarAllButtons = {};
local BananaBarButtonNameCounter = 1;
BananaBarButtonUnderMouse = nil;

function BananaBar2Button:new(addon, name)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o:init(addon,name)
    return o
end

function BananaBar2Button:init(addon,name)
    self.Name = name;
    self.Addon = addon;
    self.FrameName = "BananaBarButton"..BananaBarButtonNameCounter;
    self.ButtonId = BananaBarButtonNameCounter;
    BananaBarAllButtons[BananaBarButtonNameCounter] = self;
    BananaBarButtonNameCounter = BananaBarButtonNameCounter +1;
    self.frame = CreateFrame("CheckButton",self.FrameName,UIParent,"BananaBar2ButtonTemplate"); 
    self.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
    self.selected = false;
    self.frame.Id="1"
    self.frame:SetPoint("CENTER",0,0)
    self.frame:Hide();
    self.Addon:Debug("init "..self.FrameName);

    self.TargetSymbol = getglobal(self.FrameName.."TargetSymbol");
    self.Icon = getglobal(self.FrameName.."Icon");
    self.DeadSymbol = getglobal(self.FrameName.."DeadSymbol");
    self.HuntersmarkSymbol = getglobal(self.FrameName.."HuntersmarkSymbol");
    self.Arrow1 = getglobal(self.FrameName.."Arrow1");
    self.Arrow2 = getglobal(self.FrameName.."Arrow2");
    self.Arrow3 = getglobal(self.FrameName.."Arrow3");
    self.Arrow4 = getglobal(self.FrameName.."Arrow4");
    self.Selected = getglobal(self.FrameName.."Selected");
    self.NormalTexture = getglobal(self.FrameName.."NormalTexture");
    self.PushedTexture = getglobal(self.FrameName.."PushedTexture");   
    self.HealthBar = getglobal(self.FrameName.."HealthBar");   
    self.MobName = getglobal(self.FrameName.."MobName");   
    self.Count = getglobal(self.FrameName.."Count");   
    self.Arrows = {};
    self.Arrows[1] = self.Arrow1;
    self.Arrows[2] = self.Arrow2;
    self.Arrows[3] = self.Arrow3;
    self.Arrows[4] = self.Arrow4;
    
    self.dockFrame = nil;
    self.dockDirection = 0;
    self.showButtonFrame = true;
    self.visible = true;
    
    self.HealthBar:SetValue(17)
    --self.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
    self.HealthBar:SetStatusBarTexture("Interface\\AddOns\\BananaBarClassic\\Images\\Chess128N");
    self.HealthBar:SetStatusBarColor(0,1,0,1);                    

    self.dead = false;
    self.showDead = false;
    self:SetHuntersmark(false);

    --self.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonDown", "MiddleButtonUp");
	self.frame:SetScript("OnLoad", function(frame) self:OnLoad(frame) end)
	self.frame:SetScript("OnClick", function(frame,button) self:OnClick(button, frame) end)
	self.frame:SetScript("OnMouseUp", function(frame,button) self:OnMouseUp(button, frame) end)
	self.frame:SetScript("OnMouseDown", function(frame,button) self:OnMouseDown(button, frame) end)
	self.frame:SetScript("OnEnter", function(frame,button) self:OnEnter(button, frame) end)
	self.frame:SetScript("OnLeave", function(frame,button) self:OnLeave(button, frame) end)
end

-- Functions

function BananaBar2Button:SetButtonSymbol(index, unit)
    BananaBar2Button:SetSymbolTexture(self.Icon,index);
end

function BananaBar2Button:SetButtonSymbolExtra(unit)
    BananaBar2Button:SetSymbolTexture(self.Icon,0, unit);
end

function BananaBar2Button:SetSymbolTexture(frame, index, unit)
    if unit then
        SetPortraitTexture(frame,unit)
        frame:SetTexCoord(0, 1, 0, 1);
        return;
    end
    if index <= 0 then
        frame:SetTexture(nil);
        return;
    end
    if index >= 9 then
        --frame:SetTexture(BANANA_TEXTURE_HUNTERSMARK);            
        --frame:SetTexCoord(0, 1, 0, 1);
    else
        frame:SetTexture(BANANA_TEXTURE_RAIDICONS);            
        frame:SetTexCoord(
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordLeft, 
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordRight, 
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordTop, 
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordBottom
        );
    end
end


function BananaBar2Button:SetTargetSymbol(index)
    if index <= 0 then
        self.TargetSymbol:Hide();            
        BananaBar2Button:SetSymbolTexture(self.TargetSymbol,index);
    else
        BananaBar2Button:SetSymbolTexture(self.TargetSymbol,index);
        self.TargetSymbol:Show();            
    end
end


function BananaBar2Button:SetDead(isdead)
    self.dead = isdead;
    self:UpdateDeadSymbol();
end

function BananaBar2Button:UpdateDeadSymbol()
    if self.dead and self.showDead then
        self.DeadSymbol:Show();
    else
        self.DeadSymbol:Hide();
    end
end

function BananaBar2Button:SetHuntersmark(huntersmark)
    self.huntersmark = huntersmark;
    self:UpdateHuntersmarkSymbol();
end

function BananaBar2Button:UpdateHuntersmarkSymbol()
    if self.huntersmark then
        self.HuntersmarkSymbol:Show();
    else
        self.HuntersmarkSymbol:Hide();
    end
end

function BananaBar2Button:EnableDeadSymbol(showDead)
    self.showDead = showDead;
    self:UpdateDeadSymbol();
end


function BananaBar2Button:UpdateLayoutArrows(direction)
    if self.dockDirection == 1 then
        self.Arrows[3]:Show();
    else
        self.Arrows[3]:Hide();
    end
    if self.dockDirection == 2 then
        self.Arrows[4]:Show();
    else
        self.Arrows[4]:Hide();
    end
    if self.dockDirection == 3 then
        self.Arrows[1]:Show();
    else
        self.Arrows[1]:Hide();
    end
    if self.dockDirection == 4 then
        self.Arrows[2]:Show();
    else
        self.Arrows[2]:Hide();
    end
end

function BananaBar2Button:UpdateNormalArrows()
    self.Arrows[1]:Hide();
    self.Arrows[2]:Hide();
    self.Arrows[3]:Hide();
    self.Arrows[4]:Hide();
end

function BananaBar2Button:UpdateArrows()
    if self.Addon.layoutmode then
        self:UpdateLayoutArrows()
    else
        self:UpdateNormalArrows()
    end
end



function BananaBar2Button:Dock(direction, other)

    self.Addon:Debug("Dock called");
    self.Addon:Debug(direction);
    self.Addon:Debug(self.Name);
    

    self.dockFrame = other;       
    self.dockDirection = direction;       
    self:UpdateArrows();
    
    self.frame:ClearAllPoints();

    if other then
        self.Addon:Debug(other.Name);
        if direction == 0 then
            error("Docking direction=NONE but other dockung frame given.");
            return;
        end
        local oldDockFrame = self.dockFrame;
        if self  == other then
            error("Try to dock on myself");
        end
        if not self:GetMoveFrame() then
            self.dockFrame = nil;       
            self.dockDirection = 0;       
            self:UpdateArrows();
            self.Addon:Print("Can not set docking frame, recursion detected.");
            return;
        end
    else
        if direction ~= 0 then
            error("Docking direction~=NONE but no other dockung frame given.");
        end
    end

    if direction == BANANA_DOCK_TOP then
        self.Addon:Debug("Docking "..self.FrameName.." on top of "..other.FrameName)
    	self.frame:SetPoint("BOTTOM", other.frame, "TOP",0,2);
    elseif direction == BANANA_DOCK_RIGHT then
        self.Addon:Debug("Docking "..self.FrameName.." at the right side of "..other.FrameName)
    	self.frame:SetPoint("LEFT", other.frame, "RIGHT",2,0);
    elseif direction == BANANA_DOCK_BOTTOM then
        self.Addon:Debug("Docking "..self.FrameName.." at the bottom of "..other.FrameName)
    	self.frame:SetPoint("TOP", other.frame, "BOTTOM",0,-2);
    elseif direction == BANANA_DOCK_LEFT then
        self.Addon:Debug("Docking "..self.FrameName.." at the left side of "..other.FrameName)
    	self.frame:SetPoint("RIGHT", other.frame, "LEFT",-2,0);
    elseif direction == BANANA_DOCK_NONE then
        self.Addon:Debug("UnDocking "..self.FrameName)
    else        
        error("Invalid docking direction.");
    end
end

function BananaBar2Button:OnLoad(frame)
    self.Addon:Print("OnLoad:"..self.FrameName);
end

function BananaBar2Button:OnClick(mouseButton)
	self.Addon:Debug("Click:"..self.FrameName.." "..(mouseButton or 'null'));
    if not self.Addon.layoutmode then
	    local  clicktype = BananaBar2Button:GetClickType(mouseButton);
	    self.Addon:ExecuteAction(self, clicktype);
	end
end

function BananaBar2Button:OnMouseDown(mouseButton, frame)
    self.Addon:Debug("OnMouseDown:"..self.FrameName.." "..(mouseButton or 'null'));
    if self.Addon.layoutmode then
        if mouseButton == "RightButton" then
            self:Dock(BANANA_DOCK_NONE);
            self:DragStart();
        elseif mouseButton == "LeftButton" then
            self:DragStart();
        elseif mouseButton == "MiddleButton" then
            self.Addon:Set_layoutmode(false);
        elseif mouseButton == "Button4" then
            self.Addon:Set_layoutmode(false);
        elseif mouseButton == "Button5" then
            BananaBar2Button:UndockAll();
        else
            self.Addon:Debug("OnMouseDown:"..self.FrameName.." "..(mouseButton or 'null'));
        end
        return;
    else
    	BananaBar2:DragPrepare(self,mouseButton);
    end
end

function BananaBar2Button:OnMouseUp(mouseButton, frame)
    if self.Addon.layoutmode then
        self:DragStop();
        BananaBar2Button:SaveAllPos();
    else
    	BananaBar2:DragStop(BananaBarButtonUnderMouse,mouseButton);
    end
end

function BananaBar2Button:GetClickType(mouseButton, frame)
    local b = 0;
    if mouseButton == "LeftButton" then
        b = 0*8;
    elseif mouseButton == "RightButton" then
        b = 1*8;
    elseif mouseButton == "MiddleButton" then
        b = 2*8;
    elseif mouseButton == "Button4" then
        b = 3*8;
    elseif mouseButton == "Button5" then
        b = 4*8;
    else
        return 0;
    end
    if IsShiftKeyDown() then
        b = b + 1;
    end
    if IsControlKeyDown() then
        b = b + 2;
    end
    if IsAltKeyDown() then
        b = b + 4;
    end
    return b;
end

function BananaBar2Button:OnEnter()
    --self.Addon:Print("BananaBar2Button:OnEnter")
	BananaBarButtonUnderMouse = self;
    self.Addon:SetTooltipButton(self);
end


function BananaBar2Button:OnLeave()
    --self.Addon:Print("BananaBar2Button:OnLeave")
	self.Addon:BananaSetCursor(nil)
	BananaBarButtonUnderMouse = nil;
    self.Addon:SetTooltipButton(nil);
end

function BananaBar2Button:DragStart()
    moveButton = self:GetMoveFrame();
    moveButton.frame:SetMovable(true);
    moveButton.frame:StartMoving();
    self.moving = true;
end

function BananaBar2Button:DragStop()
    if self.moving then
        moveButton = self:GetMoveFrame();
        moveButton.frame:StopMovingOrSizing();
        moveButton.frame:SetMovable(false);
        self.moving = false;
        self:AutoDock();
    end
end

function BananaBar2Button:AutoDock()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        if self.ButtonId ~= i then
            local dx = self.frame:GetLeft()-BananaBarAllButtons[i].frame:GetLeft();
            local dy = self.frame:GetTop()-BananaBarAllButtons[i].frame:GetTop();
            if i == 5 then
                self.Addon:Debug("xy:"..dx.." "..dy);
            end
            if BananaBar2Button:TestDiff(dx,dy,0,25,9) then
                self.Addon:Debug("AutoDock:"..self.ButtonId.." oberhalb von "..i);
                self:Dock(BANANA_DOCK_TOP,BananaBarAllButtons[i]);
                return;
            end
            if BananaBar2Button:TestDiff(dx,dy,25,0,9) then
                self.Addon:Debug("AutoDock:"..self.ButtonId.." rechts von "..i);
                self:Dock(BANANA_DOCK_RIGHT,BananaBarAllButtons[i]);
                return;
            end
            if BananaBar2Button:TestDiff(dx,dy,0,-25,9) then
                self.Addon:Debug("AutoDock:"..self.ButtonId.." unterhalb von "..i);
                self:Dock(BANANA_DOCK_BOTTOM,BananaBarAllButtons[i]);
                return;
            end
            if BananaBar2Button:TestDiff(dx,dy,-25,0,9) then
                self.Addon:Debug("AutoDock:"..self.ButtonId.." links von "..i);
                self:Dock(BANANA_DOCK_LEFT,BananaBarAllButtons[i]);
                return;
            end
        end
    end
end


function BananaBar2Button:SavePos()
	if self.dockFrame then
        --dock settings speichern
        self.Addon.db.profile.ButtonLayout[self.Name].DockTo = self.dockFrame.Name;
        self.Addon.db.profile.ButtonLayout[self.Name].DockDir = self.dockDirection;
        self.Addon.db.profile.ButtonLayout[self.Name].x = 0;
        self.Addon.db.profile.ButtonLayout[self.Name].y = 0;
    else
        --position speichern
		local x = self.frame:GetLeft()*self.frame:GetScale()
		local y = self.frame:GetTop()*self.frame:GetScale()-GetScreenHeight()
        self.Addon.db.profile.ButtonLayout[self.Name].DockTo = "";
        self.Addon.db.profile.ButtonLayout[self.Name].DockDir = 0;
        self.Addon.db.profile.ButtonLayout[self.Name].x = x;
        self.Addon.db.profile.ButtonLayout[self.Name].y = y;
    end
end


function BananaBar2Button:LoadPos()
    if self.Addon.db.profile.ButtonLayout[self.Name] then
        if self.Addon.db.profile.ButtonLayout[self.Name].DockDir ~= 0 then
            local other = BananaBar2Button:FindButtonByName(self.Addon.db.profile.ButtonLayout[self.Name].DockTo);
            if other then
                --self.Addon:Print("other= "..other.Name);
                self:Dock(self.Addon.db.profile.ButtonLayout[self.Name].DockDir,other)
            else
                self.Addon:Debug(self.Name.." kein other");
            end
        else
            if self.Addon.db.profile.ButtonLayout[self.Name].x then
                local x = self.Addon.db.profile.ButtonLayout[self.Name].x;
                local y = self.Addon.db.profile.ButtonLayout[self.Name].y;
                --self.Addon:Print("o "..(x or "xxx").." "..(y or "yyy"));
                self.dockFrame = nil;
                self.dockDirection = 0;
                self.frame:ClearAllPoints();
                self.frame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",x/self.frame:GetScale(),y/self.frame:GetScale())
            else
                self.Addon:Debug(self.Name.." kein pos");
            end
        end
    else
        self.Addon:Debug(self.Name.." kein lay");
    end
end

function BananaBar2Button:UpdateVisible()
    if (self.visible and self.Addon:IsActive() and self.Addon.ShowButtons) or self.Addon.layoutmode then
        self.frame:Show();
    else
        self.frame:Hide();
    end
end

function BananaBar2Button:SetVisible(visible)
    self.visible = visible;
    self:UpdateVisible();
end


function BananaBar2Button:GetMoveFrame()
    local moveFrame = self;
    for i= 1,BANANA_MAX_BUTTONS,1 do
        if moveFrame.dockFrame then
            --self.Addon:Print(moveFrame.Name.." -> "..moveFrame.dockFrame.Name);
            moveFrame = moveFrame.dockFrame;
        else
            --self.Addon:Print(moveFrame.Name.." -> nil");
            return moveFrame;    
        end
    end
    return nil;
end

function BananaBar2Button:SetCount(number)
    if number then
        self.Count:SetText(tostring(number));
    else
        self.Count:SetText("");
    end
end



function BananaBar2Button:UpdateScale(scale)
    if self.frame.dockFrame then
		self.frame:SetScale(scale);
	else
		self:SavePos()
		self.frame:SetScale(scale);
		self:LoadPos()
	end
	
end


-- STATIC Functions


function BananaBar2Button:TestDiff(dx1,dy1,dx2,dy2,diff)
    local dx = dx1-dx2;
    local dy = dy1-dy2;
    if dx < 0 then 
        dx = 0-dx;
    end
    if dy < 0 then 
        dy = 0-dy;
    end
    if dx > diff then 
        return false;
    end
    if dy > diff then 
        return false;
    end
    return true;
end

function BananaBar2Button:FindButtonByName(name)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        if BananaBarAllButtons[i].Name == name then
            return BananaBarAllButtons[i];
        end
    end
    return nil;
end

function BananaBar2Button:UpdateAllArrows()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllButtons[i]:UpdateArrows();
    end
end

function BananaBar2Button:UpdateAllExtraInfo(show)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
		if show then
			BananaBarAllButtons[i].HealthBar:Show();
			BananaBarAllButtons[i].MobName:Show();
		else
			BananaBarAllButtons[i].HealthBar:Hide();
			BananaBarAllButtons[i].MobName:Hide();
		end
    end
end


function BananaBar2Button:UpdateAllScale(scale)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllButtons[i]:UpdateScale(scale);
    end
end

function BananaBar2Button:UndockAll()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllButtons[i]:Dock(BANANA_DOCK_NONE);
    end
end
function BananaBar2Button:SaveAllPos()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllButtons[i]:SavePos()
    end
end
function BananaBar2Button:LoadAllPos()
    BananaBar2Button:UndockAll();
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllButtons[i]:LoadPos()
    end
end
function BananaBar2Button:UpdateAllVisible()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllButtons[i]:UpdateVisible();
    end
end
function BananaBar2Button:EnableAllDeadSymbol(showDead)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllButtons[i].showDead = showDead;
        BananaBarAllButtons[i]:UpdateDeadSymbol();
    end
end 

function BananaBar2Button:UpdateAllButtonFrame(show)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        if show then
            BananaBarAllButtons[i].NormalTexture:SetAlpha(1);
            BananaBarAllButtons[i].frame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress");            
            showButtonFrame = true;
        else
            BananaBarAllButtons[i].NormalTexture:SetAlpha(0);
            BananaBarAllButtons[i].frame:SetPushedTexture("Interface\\AddOns\\BananaBarClassic\\Images\\Pressed");            
            showButtonFrame = false;
        end
    end
end

function BananaBar2Button:SetOrRemoveSymbol()
    if not UnitExists("target") then
        Banana_TargetRaidSymbol(index);
        if not UnitExists("target") then
            self.Addon:Debug("keine target ausgewählt und kein mob gefunden um target zu entfernen");
            return;
        end
    end
    
    local oldindex = (Banana_GetSymbol("TARGET") or 0);
	if oldindex == index then
		Banana_SetSymbol("TARGET", 0)
		Banana_PlayRemove1();
	else
		Banana_SetSymbol("TARGET", index)
	end
	Banana_UpdateStatus();
end

function BananaBar2Button:TargetSymbol()
  for i = 1, 40, 1 do
    if Banana_TargetRaidSymbolUnit("raid"..i,index) then
        return;
    end
  end;
  for i = 1, 4, 1 do
    if Banana_TargetRaidSymbolUnit("party"..i,index) then
        return;
    end
  end;
  if Banana_TargetRaidSymbolUnit("player",index) then
      return;
  end
  Banana_PlayError();
  Banana_Print("Nothing to target");
  Banana_UpdateStatus();
end

function BananaBar2Button:SetMobName(name)
    if name then
        self.MobName:SetText(name);
    else
        self.MobName:SetText("");
    end
end

function CanSetSymbols()
    if GetNumGroupMembers() > 0 then
        if IsRaidOfficer() or IsRaidLeader() then
            return true;
        end
    elseif GetNumGroupMembers() > 0 then
        if IsPartyLeader() then
            return true;
        end
    end
    return false;
end

function BananaBar2Button:SetSelected(value)
	if self.selected == value then
		return;
	end
	self.selected = value;
	if value then
		self.Selected:Show();
	else
		self.Selected:Hide();
	end
end






