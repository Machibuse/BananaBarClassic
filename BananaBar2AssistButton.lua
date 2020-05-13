--ActionButtonTemplate


local MAJOR_VERSION = "BananaBar2AssistButton-2.0"
local MINOR_VERSION = "$Rev: 101 $"


local SecureActionQueue = LibStub("SecureActionQueue-2.0")



local BananaBar2AssistButton = LibStub:NewLibrary("BananaBar2AssistButton-2.0", 1)


function prnt(text)
    DEFAULT_CHAT_FRAME:AddMessage(tostring(text))
end

local BananaBarAllAssistButtons = {};
local BananaBarButtonNameCounter = 1;
BananaBarButtonUnderMouse = nil;

function BananaShowTargetDropDown()
	ToggleDropDownMenu(1, nil, TargetFrameDropDown, "cursor");
end

function BananaBar2AssistButton:new(addon, name)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o:init(addon,name)
    return o
end

function BananaBar2AssistButton:init(addon,name)
    self.AssistButton = true;
    self.Name = name;
    self.Addon = addon;
    self.FrameName = "BananaBarAssistButton"..BananaBarButtonNameCounter;
    self.ButtonId = BananaBarButtonNameCounter;
    self.Unit = "raid"..self.ButtonId;
    BananaBarAllAssistButtons[BananaBarButtonNameCounter] = self;
    BananaBarButtonNameCounter = BananaBarButtonNameCounter +1;
    self.frame = CreateFrame("CheckButton",self.FrameName,UIParent,"BananaBar2AssistButtonTemplate"); 
    
	SecureActionQueue:FrameSetAttribute(self.frame,"unit", self.Unit.."target");
    SecureActionQueue:FrameSetAttribute(self.frame,"type2", "menu");
    SecureActionQueue:FrameSetAttribute(self.frame,"*type1", "target")

    self.frame.menu = BananaShowTargetDropDown;

    self.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
    self.selected = false;
    self.frame.Id="1"
    self.frame:SetPoint("CENTER",0,0)
    self.frame:Show();
    --self.Addon:Debug("init "..self.FrameName);


    self.TargetSymbol = getglobal(self.FrameName.."TargetSymbol");
    self.Icon = getglobal(self.FrameName.."Icon");
    self.DeadSymbol = getglobal(self.FrameName.."DeadSymbol");
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
    self.ButtonName = getglobal(self.FrameName.."Name");   
    self.ButtonName2 = getglobal(self.FrameName.."Name2");   
    self.Arrows = {};
    self.Arrows[1] = self.Arrow1;
    self.Arrows[2] = self.Arrow2;
    self.Arrows[3] = self.Arrow3;
    self.Arrows[4] = self.Arrow4;
    
    self.dockFrame = nil;
    self.dockDirection = 0;
    self.showButtonFrame = false;
    self.visible = true;
    
    self.HealthBar:Hide();
    self.HealthBar:SetValue(0)
    --self.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
    self.HealthBar:SetStatusBarTexture("Interface\\AddOns\\BananaBarClassic\\Images\\Chess128N");
    self.HealthBar:SetStatusBarColor(0,1,0,1);                    

    self.dead = false;
    self.showDead = false;
    --self.frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonDown", "MiddleButtonUp");
	self.frame:SetScript("OnLoad", function(frame) self:OnLoad(frame); end)
    --self.frame:SetScript("OnClick", function() self:OnClick(arg1); end)
	self.frame:SetScript("OnMouseUp", function(frame,button) self:OnMouseUp(button,frame); end)
	self.frame:SetScript("OnMouseDown", function(frame,button) self:OnMouseDown(button,frame); end)
	self.frame:SetScript("OnEnter", function(frame,button) self:OnEnter(button,frame); end)
	self.frame:SetScript("OnLeave", function(frame,button) self:OnLeave(button,frame); end)
end

-- Functions

function BananaBar2AssistButton:SetButtonSymbol(index)
    BananaBar2AssistButton:SetSymbolTexture(self.Icon,index);
end

function BananaBar2AssistButton:SetButtonTexture(tex)
    BananaBar2AssistButton:SetSymbolTexture2(self.Icon,tex);
end


function BananaBar2AssistButton:SetTargetSymbol(index)
    if index <= 0 then
        self.TargetSymbol:Hide();            
        BananaBar2AssistButton:SetSymbolTexture(self.TargetSymbol,index);
    else
        BananaBar2AssistButton:SetSymbolTexture(self.TargetSymbol,index);
        self.TargetSymbol:Show();            
    end
end


function BananaBar2AssistButton:SetDead(isdead)
    self.dead = isdead;
    self:UpdateDeadSymbol();
end

function BananaBar2AssistButton:UpdateDeadSymbol()
    if self.dead and self.showDead then
        self.DeadSymbol:Show();
    else
        self.DeadSymbol:Hide();
    end
end

function BananaBar2AssistButton:EnableDeadSymbol(showDead)
    self.showDead = showDead;
    self:UpdateDeadSymbol();
end


function BananaBar2AssistButton:UpdateLayoutArrows(direction)
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

function BananaBar2AssistButton:UpdateNormalArrows()
    self.Arrows[1]:Hide();
    self.Arrows[2]:Hide();
    self.Arrows[3]:Hide();
    self.Arrows[4]:Hide();
end

function BananaBar2AssistButton:UpdateArrows()
    if self.Addon.layoutmode then
        self:UpdateLayoutArrows()
    else
        self:UpdateNormalArrows()
    end
end



function BananaBar2AssistButton:Dock(direction, other)
    self.dockFrame = other;       
    self.dockDirection = direction;       
    self:UpdateArrows();
    
    self.frame:ClearAllPoints();

    if other then
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
        --self.Addon:Debug("Docking "..self.FrameName.." on top of "..other.FrameName)
    	self.frame:SetPoint("BOTTOM", other.frame, "TOP",0,2);
    elseif direction == BANANA_DOCK_RIGHT then
        --self.Addon:Debug("Docking "..self.FrameName.." at the right side of "..other.FrameName)
    	self.frame:SetPoint("LEFT", other.frame, "RIGHT",2,0);
    elseif direction == BANANA_DOCK_BOTTOM then
        --self.Addon:Debug("Docking "..self.FrameName.." at the bottom of "..other.FrameName)
    	self.frame:SetPoint("TOP", other.frame, "BOTTOM",0,-2);
    elseif direction == BANANA_DOCK_LEFT then
        --self.Addon:Debug("Docking "..self.FrameName.." at the left side of "..other.FrameName)
    	self.frame:SetPoint("RIGHT", other.frame, "LEFT",-2,0);
    elseif direction == BANANA_DOCK_NONE then
        --self.Addon:Debug("UnDocking "..self.FrameName)
    else        
        error("Invalid docking direction.");
    end
end

function BananaBar2AssistButton:OnLoad(mouseButton)
--    self.Addon:Print("OnLoad:"..self.FrameName);
end

function BananaBar2AssistButton:OnClick(mouseButton)
	--self.Addon:Debug("Click:"..self.FrameName.." "..mouseButton);
    if not self.Addon.layoutmode then
	    local  clicktype = BananaBar2AssistButton:GetClickType(mouseButton);
		--self.Addon:Print(clicktype);
		if clicktype == 8 then
			if self.AssistUnit then
				TargetUnit(self.AssistUnit);
			end
		elseif clicktype == 0 then
			if self.AssistTarget then
				TargetUnit(self.AssistTarget);
			end
		end
	    --self.Addon:ExecuteAction(self, clicktype);
	end
end

function BananaBar2AssistButton:OnMouseDown(mouseButton)
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
            BananaBar2AssistButton:UndockAll();
        else
            --self.Addon:Debug("OnMouseDown:"..self.FrameName.." "..mouseButton);
        end
        return;
    end
end

function BananaBar2AssistButton:OnMouseUp(mouseButton)
    if self.Addon.layoutmode then
        self:DragStop();
        BananaBar2AssistButton:SaveAllPos();
    end
end

function BananaBar2AssistButton:GetClickType(mouseButton)
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

function BananaBar2AssistButton:OnEnter()
	BananaBarButtonUnderMouse = self;
    self.Addon:SetTooltipButton(self);
end


function BananaBar2AssistButton:OnLeave()
	self.Addon:BananaSetCursor(nil)
	BananaBarButtonUnderMouse = nil;
    self.Addon:SetTooltipButton(nil);
end

function BananaBar2AssistButton:DragStart()
    moveButton = self:GetMoveFrame();
    moveButton.frame:SetMovable(true);
    moveButton.frame:StartMoving();
    self.moving = true;
end

function BananaBar2AssistButton:DragStop()
    if self.moving then
        moveButton = self:GetMoveFrame();
        moveButton.frame:StopMovingOrSizing();
        moveButton.frame:SetMovable(false);
        self.moving = false;
        self:AutoDock();
    end
end

function BananaBar2AssistButton:AutoDock()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        if self.ButtonId ~= i then
            local dx = self.frame:GetLeft()-BananaBarAllAssistButtons[i].frame:GetLeft();
            local dy = self.frame:GetTop()-BananaBarAllAssistButtons[i].frame:GetTop();
            if i == 5 then
                --self.Addon:Debug("xy:"..dx.." "..dy);
            end
            if BananaBar2AssistButton:TestDiff(dx,dy,0,25,9) then
                --self.Addon:Debug("AutoDock:"..self.ButtonId.." oberhalb von "..i);
                self:Dock(BANANA_DOCK_TOP,BananaBarAllAssistButtons[i]);
                return;
            end
            if BananaBar2AssistButton:TestDiff(dx,dy,25,0,9) then
                --self.Addon:Debug("AutoDock:"..self.ButtonId.." rechts von "..i);
                self:Dock(BANANA_DOCK_RIGHT,BananaBarAllAssistButtons[i]);
                return;
            end
            if BananaBar2AssistButton:TestDiff(dx,dy,0,-25,9) then
                --self.Addon:Debug("AutoDock:"..self.ButtonId.." unterhalb von "..i);
                self:Dock(BANANA_DOCK_BOTTOM,BananaBarAllAssistButtons[i]);
                return;
            end
            if BananaBar2AssistButton:TestDiff(dx,dy,-25,0,9) then
                --self.Addon:Debug("AutoDock:"..self.ButtonId.." links von "..i);
                self:Dock(BANANA_DOCK_LEFT,BananaBarAllAssistButtons[i]);
                return;
            end
        end
    end
end


function BananaBar2AssistButton:SavePos()
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


function BananaBar2AssistButton:LoadPos()
    if self.Addon.db.profile.ButtonLayout[self.Name] then
        if self.Addon.db.profile.ButtonLayout[self.Name].DockDir ~= 0 then
            local other = BananaBar2AssistButton:FindButtonByName(self.Addon.db.profile.ButtonLayout[self.Name].DockTo);
            if other then
                --self.Addon:Print("other= "..other.Name);
                self:Dock(self.Addon.db.profile.ButtonLayout[self.Name].DockDir,other)
            else
                --self.Addon:Debug(self.Name.." kein other");
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
                --self.Addon:Debug(self.Name.." kein pos");
            end
        end
    else
        --self.Addon:Debug(self.Name.." kein lay");
    end
end


function BananaBar2AssistButton:UpdateVisible()
    if (self.visible and self.Addon:IsActive() and self.Addon.db.profile.showraidinfo and self.Addon.ShowRaidInfo) or self.Addon.layoutmode or self.Addon.db.profile.showraidinfoall then
		SecureActionQueue:FrameShow(self.frame);
        --self.frame:Show();
    else
		SecureActionQueue:FrameHide(self.frame);
        --self.frame:Hide();
    end
end

function BananaBar2AssistButton:SetVisible(visible)
    self.visible = visible;
    self:UpdateVisible();
end


function BananaBar2AssistButton:GetMoveFrame()
    local moveFrame = self;
    for i= 1,50,1 do
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

function BananaBar2AssistButton:SetCount(number)
    if number then
        self.Count:SetText(tostring(number));
    else
        self.Count:SetText("");
    end
end

function BananaBar2AssistButton:SetButtonName(name)
    if name then
        self.ButtonName:SetText(name);
    else
        self.ButtonName:SetText("");
    end
    self.ButtonName2:SetText("");
end

function BananaBar2AssistButton:SetButtonName2(name)
    if name then
        self.ButtonName2:SetText(name);
    else
        self.ButtonName2:SetText("");
    end
    self.ButtonName:SetText("");
end


function BananaBar2AssistButton:UpdateScale(scale)
    if self.frame.dockFrame then
		self.frame:SetScale(scale);
	else
		self:SavePos()
		self.frame:SetScale(scale);
		self:LoadPos()
	end
	
end


-- STATIC Functions

function BananaBar2AssistButton:SetSymbolTexture(frame, index)
    if index <= 0 then
        frame:SetTexture(BANANA_TEXTURE_NULL);            
        frame:SetTexCoord(0, 1, 0, 1);
    elseif index == 99 then
        frame:SetTexture(BANANA_TEXTURE_X);            
        frame:SetTexCoord(0, 1, 0, 1);
    elseif index == 98 then
        frame:SetTexture(BANANA_TEXTURE_N);            
        frame:SetTexCoord(0, 1, 0, 1);
    elseif index >= 9 then
        frame:SetTexture(BANANA_TEXTURE_NULL);            
        frame:SetTexCoord(0, 1, 0, 1);
    else
        frame:SetTexture(BANANA_TEXTURE_RAIDICONS_FLAT);            
        frame:SetTexCoord(
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordLeft, 
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordRight, 
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordTop, 
            UnitPopupButtons[BANANA_RAID_TARGET_X[index]].tCoordBottom
        );
    end
end
function BananaBar2AssistButton:SetSymbolTexture2(frame, tex)
    frame:SetTexture(tex);            
	frame:SetTexCoord(0, 1, 0, 1);
end


function BananaBar2AssistButton:TestDiff(dx1,dy1,dx2,dy2,diff)
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

function BananaBar2AssistButton:FindButtonByName(name)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        if BananaBarAllAssistButtons[i].Name == name then
            return BananaBarAllAssistButtons[i];
        end
    end
    return nil;
end

function BananaBar2AssistButton:UpdateAllArrows()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllAssistButtons[i]:UpdateArrows();
    end
end
function BananaBar2AssistButton:UpdateAllScale(scale)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllAssistButtons[i]:UpdateScale(scale);
    end
end

function BananaBar2AssistButton:UndockAll()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllAssistButtons[i]:Dock(BANANA_DOCK_NONE);
    end
end
function BananaBar2AssistButton:SaveAllPos()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllAssistButtons[i]:SavePos()
    end
end
function BananaBar2AssistButton:LoadAllPos()
    BananaBar2AssistButton:UndockAll();
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllAssistButtons[i]:LoadPos()
    end
end
function BananaBar2AssistButton:UpdateAllVisible()
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllAssistButtons[i]:UpdateVisible();
    end
end
function BananaBar2AssistButton:EnableAllDeadSymbol(showDead)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        BananaBarAllAssistButtons[i].showDead = showDead;
        BananaBarAllAssistButtons[i]:UpdateDeadSymbol();
    end
end 

function BananaBar2AssistButton:UpdateAllButtonFrame(show)
    for i = 1, BananaBarButtonNameCounter-1, 1 do
        if show then
            BananaBarAllAssistButtons[i].NormalTexture:SetAlpha(1);
            BananaBarAllAssistButtons[i].frame:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress");            
            showButtonFrame = true;
        else
            BananaBarAllAssistButtons[i].NormalTexture:SetAlpha(0);
            BananaBarAllAssistButtons[i].frame:SetPushedTexture("Interface\\AddOns\\BananaBarClassic\\Images\\Pressed");            
            showButtonFrame = false;
        end
    end
end


function BananaBar2AssistButton:SetMobName(name)
    if name then
        self.MobName:SetText(name);
    else
        self.MobName:SetText("");
    end
end

function CanSetSymbols()
    if GetNumRaidMembers() > 0 then
        if IsRaidOfficer() or IsRaidLeader() then
            return true;
        end
    elseif GetNumPartyMembers() > 0 then
        if IsPartyLeader() then
            return true;
        end
    end
    return false;
end

function BananaBar2AssistButton:SetSelected(value)
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






