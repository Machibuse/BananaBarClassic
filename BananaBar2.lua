BananaBar2 = LibStub("AceAddon-3.0"):NewAddon("BananaBar2", "AceConsole-3.0", "AceHook-3.0","AceEvent-3.0","AceBucket-3.0","AceTimer-3.0");

local L = LibStub("AceLocale-3.0"):GetLocale("BananaBar2")


--local Tablet = LibStub("Tablet-2.0") 

local BananaBar2AssistButton = LibStub("BananaBar2AssistButton-2.0");
local BananaBar2Button = LibStub("BananaBar2Button-2.0");

local SecureActionQueue = LibStub("SecureActionQueue-2.0")


local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local actual_settings_version = 4;

-- $Id: BananaBar2.lua 107 2006-10-12 23:48:21Z ceejay $
-- $LastChangedDate: 2006-10-13 01:48:21 +0200 (Fr, 13 Okt 2006) $
-- $LastChangedRevision: 107 $
-- $LastChangedBy: ceejay $
-- $HeadURL: https://dev.tuscom.de/subversion/public/WOW/Addons/BananaBar2/BananaBar2.lua $
-- $LastChangedDate: 2006-10-13 01:48:21 +0200 (Fr, 13 Okt 2006) $


BINDING_HEADER_BANANABAR2_PLUGINNAME = L["addonnamelong"];
BINDING_NAME_BANANABAR2_BINDING_MOUSEOVER = L["binding_mouseover"];
BINDING_NAME_BANANABAR2_BINDING_KEY = L["binding_key"];
BINDING_NAME_BANANABAR2_BINDING_SEARCH = L["binding_search"];


BananaBar2.name = L["addonname"]
BananaBar2.version = "2.0." .. string.sub("$Revision: 107 $", 12, -3)
BananaBar2.date = string.sub("$Date: 2006-10-13 01:48:21 +0200 (Fr, 13 Okt 2006) $", 8, 17)
BananaBar2.hasIcon = "Interface\\Addons\\BananaBarClassic\\Images\\BananaBar64"
BananaBar2.defaultMinimapPosition = 170



--local options = {
options = {
    handler = BananaBar2, 

    type = "group", 
    args = {
        updaterate = {
            type = "range",
            width = "full",
            name = L["updaterate"],
            desc = L["updateratedesc"],
            get = function() return BananaBar2:Get_updaterate() end,
            set = function(info,v) BananaBar2:Set_updaterate(v) end,
            min = 0.1, max = 2, step = 0.1,
            order = 1,
        },
		reset = {
			name = L["reset"],
			desc = L["resetdesc"],
            width = "full",
			type = "execute",
			func = function()
				BananaBar2:ResetSettings()
			end,
		},			

        layoutmode = {
            type = 'toggle',
            name = L["layoutmode"],
            width = "full",
            desc = L["layoutmodedesc"],
            get = function() return BananaBar2:Get_layoutmode() end,
            set = function(info,v) BananaBar2:Set_layoutmode(v) end,
            order = 5,
        },
        autosetcombat = {
            type = 'toggle',
            width = "full",
            name = L["autosetcombat"],
            desc = L["autosetcombatdesc"],
            get = function() return BananaBar2:Get_autosetcombat() end,
            set = function(info,v) BananaBar2:Set_autosetcombat(v) end,
            order = 5,
        },

        mobsettings = {
            type = "group", 
            hidden = true,
            name = L["mobsettings"],
            desc = L["mobsettingsdesc"],
            args = {
            },
            order = 2,
        },
        mousebutton = 
        {
            type = "group", 
            name = L["mousebutton"],
            desc = L["mousebuttondesc"],
            hidden = true,
            args = {
                action_config = {
                    type = "group", 
                    name = L["action_config"],
                    desc = L["action_configdesc"],
                    args = {
                        shift = {
                            type = "toggle",
                            name = L["shift"],
                            desc = L["shiftdesc"],
                            get = function() return BananaBar2:Get_action_part("action_config",1); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",1,v); end,
                            order = 1,
                        },
                        control = {
                            type = "toggle",
                            name = L["control"],
                            desc = L["controldesc"],
                            get = function() return BananaBar2:Get_action_part("action_config",2); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",2,v); end,
                            order = 2,
                        },
                        alt = {
                            type = "toggle",
                            name = L["alt"],
                            desc = L["altdesc"],
                            get = function() return BananaBar2:Get_action_part("action_config",3); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",3,v); end,
                            order = 3,
                        },
                        leftmouse = {
                            type = "toggle",
                            name = L["leftmouse"],
                            desc = L["leftmousedesc"],
                            get = function() return BananaBar2:Get_action_part("action_config",10); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",10,v); end,
                            order = 10,
                        },
                        rightmouse = {
                            type = "toggle",
                            name = L["rightmouse"],
                            desc = L["rightmousedesc"],
                            get = function() return BananaBar2:Get_action_part("action_config",11); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",11,v); end,
                            order = 11,
                        },
                        middlemouse = {
                            type = "toggle",
                            name = L["middlemouse"],
                            desc = L["middlemousedesc"],
                            get = function() return BananaBar2:Get_action_part("action_config",12); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",12,v); end,
                            order = 12,
                        },
                        mouse4 = {
                            type = "toggle",
                            name = L["mouse4"],
                            desc = L["mouse4desc"],
                            get = function() return BananaBar2:Get_action_part("action_config",13); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",13,v); end,
                            order = 13,
                        },
                        mouse5 = {
                            type = "toggle",
                            name = L["mouse5"],
                            desc = L["mouse5desc"],
                            get = function() return BananaBar2:Get_action_part("action_config",14); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_config",14,v); end,
                            order = 14,
                        },
                    }
                },
                action_setsymbol = {
                    type = "group", 
                    name = L["action_setsymbol"],
                    desc = L["action_setsymboldesc"],
                    args = {
                        shift = {
                            type = "toggle",
                            name = L["shift"],
                            desc = L["shiftdesc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",1); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",1,v); end,
                            order = 1,
                        },
                        control = {
                            type = "toggle",
                            name = L["control"],
                            desc = L["controldesc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",2); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",2,v); end,
                            order = 2,
                        },
                        alt = {
                            type = "toggle",
                            name = L["alt"],
                            desc = L["altdesc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",3); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",3,v); end,
                            order = 3,
                        },
                        leftmouse = {
                            type = "toggle",
                            name = L["leftmouse"],
                            desc = L["leftmousedesc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",10); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",10,v); end,
                            order = 10,
                        },
                        rightmouse = {
                            type = "toggle",
                            name = L["rightmouse"],
                            desc = L["rightmousedesc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",11); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",11,v); end,
                            order = 11,
                        },
                        middlemouse = {
                            type = "toggle",
                            name = L["middlemouse"],
                            desc = L["middlemousedesc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",12); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",12,v); end,
                            order = 12,
                        },
                        mouse4 = {
                            type = "toggle",
                            name = L["mouse4"],
                            desc = L["mouse4desc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",13); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",13,v); end,
                            order = 13,
                        },
                        mouse5 = {
                            type = "toggle",
                            name = L["mouse5"],
                            desc = L["mouse5desc"],
                            get = function() return BananaBar2:Get_action_part("action_setsymbol",14); end,
                            set = function(info,v) BananaBar2:Set_action_part("action_setsymbol",14,v); end,
                            order = 14,
                        },
                    }
                },
            }
        },
        visibility = {
            type = "group", 
            name = L["design"],
            desc = L["designdesc"],
            args = {
                scale = {
                    type = "range",
                    width = "full",
                    name = L["scale"],
                    desc = L["scaledesc"],
                    get = function() return BananaBar2:Get_scale() end,
                    set = function(info,v) BananaBar2:Set_scale(v) end,
                    min = 10, max = 200, step = 1,
                    order = 1,
                },
                scaleassist = {
                    type = "range",
                    width = "full",
                    name = L["scaleassist"],
                    desc = L["scaleassistdesc"],
                    get = function() return BananaBar2:Get_scaleassist() end,
                    set = function(info,v) BananaBar2:Set_scaleassist(v) end,
                    min = 10, max = 200, step = 1,
                    order = 1,
                },
                hideunused = {
                    type = "toggle",
                    width = "full",
                    name = L["hideunused"],
                    desc = L["hideunuseddesc"],
                    get = function() return BananaBar2:Get_hideunused() end,
                    set = function(info,v) BananaBar2:Set_hideunused(v) end,
                    order = 2,
                },
                hideframes = {
                    type = "toggle",
                    width = "full",
                    name = L["hidebuttonframes"],
                    desc = L["hidebuttonframesdesc"],
                    get = function() return BananaBar2:Get_hidebuttonframes() end,
                    set = function(info,v) BananaBar2:Set_hidebuttonframes(v) end,
                    order = 3,
                },
                markdead = {
                    type = "toggle",
                    width = "full",
                    name = L["markdead"],
                    desc = L["markdeaddesc"],
                    get = function() return BananaBar2:Get_markdead() end,
                    set = function(info,v) BananaBar2:Set_markdead(v) end,
                    order = 4,
                },
                showinraid = {
                    type = "toggle",
                    width = "full",
                    name = L["showinraid"],
                    desc = L["showinraiddesc"],
                    get = function() return BananaBar2:Get_showinraid() end,
                    set = function(info,v) BananaBar2:Set_showinraid(v) end,
                    order = 20,
                },
                showinparty = {
                    type = "toggle",
                    width = "full",
                    name = L["showinparty"],
                    desc = L["showinpartydesc"],
                    get = function() return BananaBar2:Get_showinparty() end,
                    set = function(info,v) BananaBar2:Set_showinparty(v) end,
                    order = 21,
                },
                showoutofgroup = {
                    type = "toggle",
                    width = "full",
                    name = L["showoutofgroup"],
                    desc = L["showoutofgroupdesc"],
                    get = function() return BananaBar2:Get_showoutofgroup() end,
                    set = function(info,v) BananaBar2:Set_showoutofgroup(v) end,
                    order = 22,
                },
                showraidinfo = {
                    type = "toggle",
                    width = "full",
                    name = L["showraidinfo"],
                    desc = L["showraidinfodesc"],
                    get = function() return BananaBar2:Get_showraidinfo() end,
                    set = function(info,v) BananaBar2:Set_showraidinfo(v) end,
                    order = 23,
                },
                showextrainfo = {
                    type = "toggle",
                    width = "full",
                    name = L["showextrainfo"],
                    desc = L["showextrainfodesc"],
                    get = function() return BananaBar2:Get_showextrainfo() end,
                    set = function(info,v) BananaBar2:Set_showextrainfo(v) end,
                    order = 24,
                },



                buttons = {
                    type = "group", 
                    name = L["showbutton"],
                    desc = L["showbuttondesc"],
                    order = 10,
                    args = {
                        button1 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR1..L["symbolname1"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(1) end,
                            set = function(info,v) BananaBar2:Set_showbutton(1,v) end,
                            order = 1,
                        },
                        button2 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR2..L["symbolname2"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(2) end,
                            set = function(info,v) BananaBar2:Set_showbutton(2,v) end,
                            order = 2,
                        },
                        button3 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR3..L["symbolname3"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(3) end,
                            set = function(info,v) BananaBar2:Set_showbutton(3,v) end,
                            order = 3,
                        },
                        button4 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR4..L["symbolname4"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(4) end,
                            set = function(info,v) BananaBar2:Set_showbutton(4,v) end,
                            order = 4,
                        },
                        button5 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR5..L["symbolname5"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(5) end,
                            set = function(info,v) BananaBar2:Set_showbutton(5,v) end,
                            order = 5,
                        },
                        button6 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR6..L["symbolname6"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(6) end,
                            set = function(info,v) BananaBar2:Set_showbutton(6,v) end,
                            order = 6,
                        },
                        button7 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR7..L["symbolname7"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(7) end,
                            set = function(info,v) BananaBar2:Set_showbutton(7,v) end,
                            order = 7,
                        },
                        button8 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLOR8..L["symbolname8"].."|r",
                            desc = L["showbuttondesc"],
                            get = function() return BananaBar2:Get_showbutton(8) end,
                            set = function(info,v) BananaBar2:Set_showbutton(8,v) end,
                            order = 8,
                        },
                        huntersmarkbutton1 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLORHM..L["unmarked"].." 1|r",
                            desc = L["showunmarkeddesc"],
                            get = function() return BananaBar2:Get_showbutton(9) end,
                            set = function(info,v) BananaBar2:Set_showbutton(9,v) end,
                            order = 9,
                        },
                        huntersmarkbutton2 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLORHM..L["unmarked"].." 2|r",
                            desc = L["showunmarkeddesc"],
                            get = function() return BananaBar2:Get_showbutton(10) end,
                            set = function(info,v) BananaBar2:Set_showbutton(10,v) end,
                            order = 10,
                        },
                        huntersmarkbutton3 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLORHM..L["unmarked"].." 3|r",
                            desc = L["showunmarkeddesc"],
                            get = function() return BananaBar2:Get_showbutton(11) end,
                            set = function(info,v) BananaBar2:Set_showbutton(11,v) end,
                            order = 11,
                        },
                        huntersmarkbutton4 = {
                            type = "toggle",
                            name = "|c"..BANANA_SYMBOL_COLORHM..L["unmarked"].." 4|r",
                            desc = L["showunmarkeddesc"],
                            get = function() return BananaBar2:Get_showbutton(12) end,
                            set = function(info,v) BananaBar2:Set_showbutton(12,v) end,
                            order = 12,
                        },
                    },
                },
            },
        },
        

    }
}

local defaults = 
{
    profile = 
    {
        mobsettings =
        {
        },

        settingsversion = 0,
        scale = 100;
        scaleassist = 50;
        hideunused = false,
        hidebuttonframes = true,
        markdead = true;
        updaterate = 0.3,
        minimapPosition = 170,


        showinraid = true,
        showinparty = true,
        showoutofgroup = true,
        showraidinfo = true,

        showextrainfo = true,

        showiconsonctraidmt = true,

        showiconsonctraidpl = true,


        actions = {
            action_setsymbol = 2,
            action_config = 8,
        },
        showbutton = {
            [1] = true,
            [2] = true,
            [3] = true,
            [4] = true,
            [5] = true,
            [6] = true,
            [7] = true,
            [8] = true,
            [9] = true,
            [10] = true,
            [11] = false,
            [12] = false,
        },
        ButtonLayout = {
            Nr1 = {
                DockDir = 0,
                DockTo = "",
                y = -232.4001067109999,
                x = 0,
            },
            Nr2 = {
                DockDir = 3,
                DockTo = "Nr1",
                y = 0,
                x = 0,
            },
            Nr3 = {
                DockDir = 3,
                DockTo = "Nr2",
                y = 0,
                x = 0,
            },
            Nr4 = {
                DockDir = 3,
                DockTo = "Nr3",
                y = 0,
                x = 0,
            },
            Nr5 = {
                DockDir = 3,
                DockTo = "Nr4",
                y = 0,
                x = 0,
            },
            Nr6 = {
                DockDir = 3,
                DockTo = "Nr5",
                y = 0,
                x = 0,
            },
            Nr7 = {
                DockDir = 3,
                DockTo = "Nr6",
                y = 0,
                x = 0,
            },
            Nr8 = {
                DockDir = 3,
                DockTo = "Nr7",
                y = 0,
                x = 0,
            },
            Nr9 = {
                DockDir = 1,
                DockTo = "Nr1",
                y = 0,
                x = 0,
            },
            Nr10 = {
                DockDir = 1,
                DockTo = "Nr9",
                y = 0,
                x = 0,
            },
            Nr11 = {
                DockDir = 1,
                DockTo = "Nr10",
                y = 0,
                x = 0,
            },
            Nr12 = {
                DockDir = 1,
                DockTo = "Nr11",
                y = 0,
                x = 0,
            },
            Assist1 = {
                DockDir = 0,
                DockTo = "",
                y = -100,
                x = 100,
            },
            Assist2 = {
                DockDir = 2,
                DockTo = "Assist1",
                y = 0,
                x = 0,
            },
            Assist3 = {
                DockDir = 2,
                DockTo = "Assist2",
                y = 0,
                x = 0,
            },
            Assist4 = {
                DockDir = 2,
                DockTo = "Assist3",
                y = 0,
                x = 0,
            },
            Assist5 = {
                DockDir = 2,
                DockTo = "Assist4",
                y = 0,
                x = 0,
            },
            Assist6 = {
                DockDir = 3,
                DockTo = "Assist1",
                y = 0,
                x = 0,
            },
            Assist7 = {
                DockDir = 2,
                DockTo = "Assist6",
                y = 0,
                x = 0,
            },
            Assist8 = {
                DockDir = 2,
                DockTo = "Assist7",
                y = 0,
                x = 0,
            },
            Assist9 = {
                DockDir = 2,
                DockTo = "Assist8",
                y = 0,
                x = 0,
            },
            Assist10 = {
                DockDir = 2,
                DockTo = "Assist9",
                y = 0,
                x = 0,
            },
            Assist11 = {
                DockDir = 3,
                DockTo = "Assist6",
                y = 0,
                x = 0,
            },
            Assist12 = {
                DockDir = 2,
                DockTo = "Assist11",
                y = 0,
                x = 0,
            },
            Assist13 = {
                DockDir = 2,
                DockTo = "Assist12",
                y = 0,
                x = 0,
            },
            Assist14 = {
                DockDir = 2,
                DockTo = "Assist13",
                y = 0,
                x = 0,
            },
            Assist15 = {
                DockDir = 2,
                DockTo = "Assist14",
                y = 0,
                x = 0,
            },
            Assist16 = {
                DockDir = 3,
                DockTo = "Assist11",
                y = 0,
                x = 0,
            },
            Assist17 = {
                DockDir = 2,
                DockTo = "Assist16",
                y = 0,
                x = 0,
            },
            Assist18 = {
                DockDir = 2,
                DockTo = "Assist17",
                y = 0,
                x = 0,
            },
            Assist19 = {
                DockDir = 2,
                DockTo = "Assist18",
                y = 0,
                x = 0,
            },
            Assist20 = {
                DockDir = 2,
                DockTo = "Assist19",
                y = 0,
                x = 0,
            },
            Assist21 = {
                DockDir = 3,
                DockTo = "Assist16",
                y = 0,
                x = 0,
            },
            Assist22 = {
                DockDir = 2,
                DockTo = "Assist21",
                y = 0,
                x = 0,
            },
            Assist23 = {
                DockDir = 2,
                DockTo = "Assist22",
                y = 0,
                x = 0,
            },
            Assist24 = {
                DockDir = 2,
                DockTo = "Assist23",
                y = 0,
                x = 0,
            },
            Assist25 = {
                DockDir = 2,
                DockTo = "Assist24",
                y = 0,
                x = 0,
            },
            Assist26 = {
                DockDir = 3,
                DockTo = "Assist21",
                y = 0,
                x = 0,
            },
            Assist27 = {
                DockDir = 2,
                DockTo = "Assist26",
                y = 0,
                x = 0,
            },
            Assist28 = {
                DockDir = 2,
                DockTo = "Assist27",
                y = 0,
                x = 0,
            },
            Assist29 = {
                DockDir = 2,
                DockTo = "Assist28",
                y = 0,
                x = 0,
            },
            Assist30 = {
                DockDir = 2,
                DockTo = "Assist29",
                y = 0,
                x = 0,
            },
            Assist31 = {
                DockDir = 3,
                DockTo = "Assist26",
                y = 0,
                x = 0,
            },
            Assist32 = {
                DockDir = 2,
                DockTo = "Assist31",
                y = 0,
                x = 0,
            },
            Assist33 = {
                DockDir = 2,
                DockTo = "Assist32",
                y = 0,
                x = 0,
            },
            Assist34 = {
                DockDir = 2,
                DockTo = "Assist33",
                y = 0,
                x = 0,
            },
            Assist35 = {
                DockDir = 2,
                DockTo = "Assist34",
                y = 0,
                x = 0,
            },
            Assist36 = {
                DockDir = 3,
                DockTo = "Assist31",
                y = 0,
                x = 0,
            },
            Assist37 = {
                DockDir = 2,
                DockTo = "Assist36",
                y = 0,
                x = 0,
            },
            Assist38 = {
                DockDir = 2,
                DockTo = "Assist37",
                y = 0,
                x = 0,
            },
            Assist39 = {
                DockDir = 2,
                DockTo = "Assist38",
                y = 0,
                x = 0,
            },
            Assist40 = {
                DockDir = 2,
                DockTo = "Assist39",
                y = 0,
                x = 0,
            },
            
        },
    }
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("BananaBar2", options, { "bb2", "bb", "bananabar" })


------------------------------------------
--- OnInitialize
------------------------------------------
function BananaBar2:OnInitialize()
    self.TARGETS = { };
    self.TARGETMARKS = { };
    self.IGNOREMARKS = { };
    self.IGNOREMOBS = { };

    self.db = LibStub("AceDB-3.0"):New("BananaBarClassicData", defaults, true)

    self.BananaUpdateTimer = self:ScheduleRepeatingTimer("BananaUpdate", self.db.profile.updaterate, self);
    self.BananaCursorTimer = self:ScheduleRepeatingTimer("BananaCursor", 1, self);


    AceConfigDialog:AddToBlizOptions("BananaBar2")

    --self.dewdrop = AceLibrary("Dewdrop-2.0")

    --self:RegisterChatCommand("bb2", options);
    

    self.Buttons = {};
    for i = 1,BANANA_MAX_BUTTONS,1 do
        self:Debug("create new button ".."Nr"..i);
        self.Buttons[i] = BananaBar2Button:new(self,"Nr"..i);
        if i > BANANA_RAIDSYMBOL_BUTTON_COUNT then
            self.Buttons[i]:SetButtonSymbolExtra(nil);
        else
            self.Buttons[i]:SetButtonSymbol(i);
        end


        if i > 1 then
            self.Buttons[i]:Dock(BANANA_DOCK_LEFT,self.Buttons[i-1]);
        end
    end
    self.AssistButtons = {};
    for i = 1,40,1 do
        self.AssistButtons[i] = BananaBar2AssistButton:new(BananaBar2,"Assist"..i);
        self.AssistButtons[i]:SetButtonSymbol(4);
        if i > 1 then
        	if mod(i,5) == 1 then
	            self.AssistButtons[i]:Dock(BANANA_DOCK_BOTTOM,self.AssistButtons[i-5]);
        	else
    	        self.AssistButtons[i]:Dock(BANANA_DOCK_RIGHT,self.AssistButtons[i-1]);
        	end
            self.AssistButtons[i]:SetVisible(true);
        end
    end
    BananaBar2AssistButton:UpdateAllButtonFrame(false);
    
    --self.AssistButtons[1].frame:SetPoint("CENTER", "UIParent", "CENTER",-2,0);
	
    self:CheckSettingsVersion();
    
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
    self:RegisterEvent("CHAT_MSG_ADDON");
    self:RegisterEvent("PLAYER_REGEN_DISABLED");
    self:RegisterEvent("PLAYER_REGEN_ENABLED");

    --LibStub("AceConsole-3.0"):InjectAceOptionsTable(self, options) todo


    --self.OnMenuRequest = options;


--	foo = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(self)
--	local args = AceLibrary("AceDB-2.0"):GetAceOptionsDataTable(self)
--	for k,v in pairs(args) do
--		if self.OnMenuRequest.args[k] == nil then
--		BananaBar2:Print("ä:"..k);
--			self.OnMenuRequest.args[k] = v
--		end
--	end


    self.frame = CreateFrame("Frame","BananaBar2DummyFrame"); 
    self.frame:Hide();
    self.GetIcon = function() return BananaBar2.hasIcon; end
    self.GetTitle = function() return L["addonname"] end
    self.IsDisabled = function() return false end
    self.OpenMenu = function() BananaBar2:Execute_Config() end

    self.mouseOverlayFrame = CreateFrame("Frame", "BananaMouseOverlay", UIParent)
    self.mouseOverlayFrame:SetFrameStrata("TOOLTIP");
    self.mouseOverlayFrame:SetWidth(32)
    self.mouseOverlayFrame:SetHeight(32)
    self.mouseOverlayFrame:SetMovable(true);
    --self.mouseOverlayFrame.texture = self.mouseOverlayFrame:CreateTexture(nil, "BACKGROUND")
    --self.mouseOverlayFrame.texture:SetAllPoints(true)
    --self.mouseOverlayFrame.texture:SetColorTexture(0, 0, 0, 0)
    self.mouseOverlayFrame:SetPoint("CENTER",0,0)
    self.mouseOverlayFrame:Show();
    self.mouseOverlayFrame:EnableMouse(false);
    self.mouseOverlayFrame:SetScript("OnUpdate", function(...) self:OnMouseOverlayUpdate(...) end);
    self.mouseOverlayFrameTex = self.mouseOverlayFrame:CreateTexture(nil,"TOOLTIP") 
    self.mouseOverlayFrameTex:SetTexture(nil)
    self.mouseOverlayFrameTex:SetAllPoints(self.mouseOverlayFrame)
    self.mouseOverlayFrame.texture = self.mouseOverlayFrameTex;
end

function BananaBar2:BananaSetCursor(texture)
    self.mouseOverlayFrameTex:SetTexture(texture)
end

function BananaBar2:PLAYER_REGEN_DISABLED(event)
    self:Print("Enter Combat")
    self.IGNOREMARKS = {};
    self.IGNOREMOBS = {};
    for mark,mobguid in pairs(BananaBar2.TARGETMARKS) do
        if mobguid ~= nil and mark < 9 then
            self.IGNOREMARKS[mark] = 1;
            self.IGNOREMOBS[mobguid] = 1;
        end
    end
    self:Debug(self.IGNOREMARKS)
    self:Debug(self.IGNOREMOBS)
end

function BananaBar2:PLAYER_REGEN_ENABLED(event)
    self:Print("Leave Combat")
end


function BananaBar2:OnMouseOverlayUpdate(frame)
    local mx, my = GetCursorPosition();
    local uiscale = UIParent:GetEffectiveScale();
    local screenW = GetScreenWidth();
    local screenH = GetScreenHeight();
    local screenScaledW = screenW * uiscale;
    local screenScaledH = screenH * uiscale;
    
    local screenWStep = screenW/100;
    local screenHStep = screenH/100;
        
    local screenScaledWStep = 100 / screenScaledW;
    local screenScaledHStep = 100 / screenScaledH;
    

    local tx = screenScaledWStep * mx; -- gives: 0 to 100 %
    local ty = screenScaledHStep * my; -- gives: 0 to 100 %
    tx = screenWStep * tx; -- converts % to actual screenW x
    ty = screenHStep * ty; -- converts % to actual screenH y

    ty = ty - 32
    tx = tx + 0
    --tx = tx + containerFrameOffsetX; -- compensate for container size
    --ty = ty + containerFrameOffsetY; -- compensate for container size

        -- NOTE: To prevent taint you can't use frame hide/show in combat so we offset position by a long way
    --tx = tx + DMouse.mouseOverlayFrameXOffset;
    --ty = ty + DMouse.mouseOverlayFrameXOffset;

    --DMouse.mouseOverlayFrame:ClearAllPoints();
    -- DMouse.mouseOverlayFrame:SetPoint("BOTTOMLEFT",DMouse.tx,DMouse.ty);
    frame:SetPoint("BOTTOMLEFT",tx,ty);    
end
------------------------------------------
--- OnEnable / OnDisable
------------------------------------------

function BananaBar2:OnEnable()
    self:Debug("OnEnable");
    self:CheckSettingsVersion();
    BananaBar2:OnProfileEnable();
end

function BananaBar2:OnDisable()
    self:Debug("OnDisable");
    self:CheckSettingsVersion();
    BananaBar2Button:UpdateAllVisible();
    BananaBar2AssistButton:UpdateAllVisible();
end

------------------------------------------
--- OnProfileEnable / OnProfileDisable
------------------------------------------

function BananaBar2:OnProfileEnable()
    self:Debug("OnProfileEnable");
    self:CheckSettingsVersion();
    BananaBar2:ProfileUpdated();
end

function BananaBar2:OnProfileDisable()
    self:Debug("OnProfileDisable");
    self:CheckSettingsVersion();
end


------------------------------------------
--- hideunused
------------------------------------------

function BananaBar2:Get_hideunused()
    return self.db.profile.hideunused;
end

function BananaBar2:Set_hideunused(value)
    if self.db.profile.hideunused ~= value then
        self.db.profile.hideunused = value;
    end
end

------------------------------------------
--- showbutton
------------------------------------------

function BananaBar2:Get_showbutton(index)
    return self.db.profile.showbutton[index];
end

function BananaBar2:Set_showbutton(index,value)
    self.db.profile.showbutton[index] = value;
    self.Buttons[index]:SetVisible(value);
end

------------------------------------------
--- scale
------------------------------------------

function BananaBar2:Set_scale(value)
    self.db.profile.scale = value;
    BananaBar2Button:UpdateAllScale(self.db.profile.scale / 100);
end

function BananaBar2:Get_scale()
    return self.db.profile.scale;
end

------------------------------------------
--- scaleassist
------------------------------------------

function BananaBar2:Set_scaleassist(value)
    self.db.profile.scaleassist = value;
    BananaBar2AssistButton:UpdateAllScale(self.db.profile.scaleassist / 100);
end

function BananaBar2:Get_scaleassist()
    return self.db.profile.scaleassist;
end

------------------------------------------
--- updaterate
------------------------------------------

function BananaBar2:Set_updaterate(value)
    self.db.profile.updaterate = value;
    self:CancelTimer(self.BananaUpdateTimer)
    self.BananaUpdateTimer = self:ScheduleRepeatingTimer("BananaUpdate", self.db.profile.updaterate or 0.3, self);
end



function BananaBar2:Get_updaterate()
    return self.db.profile.updaterate;
end

------------------------------------------
--- hidebuttonframes
------------------------------------------

function BananaBar2:Set_hidebuttonframes(value)
    self.db.profile.hidebuttonframes = value;
    BananaBar2Button:UpdateAllButtonFrame(not self.db.profile.hidebuttonframes);
end

function BananaBar2:Get_hidebuttonframes()
    return self.db.profile.hidebuttonframes;
end

------------------------------------------
--- markdead
------------------------------------------

function BananaBar2:Set_markdead(value)
    self.db.profile.markdead = value;
    BananaBar2Button:EnableAllDeadSymbol(self.db.profile.markdead)
end

function BananaBar2:Get_markdead()
    return self.db.profile.markdead;
end


------------------------------------------
--- showinraid
------------------------------------------


function BananaBar2:Get_showinraid() 
    return self.db.profile.showinraid;
end;

function BananaBar2:Set_showinraid(v) 
    self.db.profile.showinraid = v;
    BananaBar2Button:UpdateAllVisible();
end;

------------------------------------------
--- showinparty
------------------------------------------

function BananaBar2:Get_showinparty() 
    return self.db.profile.showinparty;
end;

function BananaBar2:Set_showinparty(v) 
    self.db.profile.showinparty = v;
    BananaBar2Button:UpdateAllVisible();
end;

------------------------------------------
--- showoutofgroup
------------------------------------------

function BananaBar2:Get_showoutofgroup() 
    return self.db.profile.showoutofgroup;
end;

function BananaBar2:Set_showoutofgroup(v) 
    self.db.profile.showoutofgroup = v;
    BananaBar2Button:UpdateAllVisible();
end;

------------------------------------------
--- showraidinfo
------------------------------------------

function BananaBar2:Get_showraidinfo() 
    return self.db.profile.showraidinfo;
end;

function BananaBar2:Set_showraidinfo(v) 
    self.db.profile.showraidinfo = v;
    BananaBar2AssistButton:UpdateAllVisible();
end;

------------------------------------------
--- showiconsonctraidmt
------------------------------------------

function BananaBar2:Get_showiconsonctraidmt() 
    return self.db.profile.showiconsonctraidmt;
end;

function BananaBar2:Set_showiconsonctraidmt(v) 
    self.db.profile.showiconsonctraidmt = v;
end;

------------------------------------------
--- showiconsonctraidpl
------------------------------------------

function BananaBar2:Get_showiconsonctraidpl() 
    return self.db.profile.showiconsonctraidpl;
end;

function BananaBar2:Set_showiconsonctraidpl(v) 
    self.db.profile.showiconsonctraidpl = v;
end;

------------------------------------------
--- showextrainfo
------------------------------------------

function BananaBar2:Get_showextrainfo() 
    return self.db.profile.showextrainfo;
end;

function BananaBar2:Set_showextrainfo(v) 
    self.db.profile.showextrainfo = v;
    BananaBar2Button:UpdateAllExtraInfo(self.db.profile.showextrainfo);
end;

-----------------------------------------
--- layout
------------------------------------------

function BananaBar2:Set_layoutmode(value) 
    self.layoutmode = value;
    BananaBar2Button:UpdateAllArrows();
    BananaBar2Button:UpdateAllVisible();
    BananaBar2AssistButton:UpdateAllArrows();
    if self.layoutmode then
    	self:HookEscape();
    else
    	self:UnhookEscape();
    end
end

function BananaBar2:Get_layoutmode() 
    return self.layoutmode;
end

function BananaBar2:Set_autosetcombat(value) 
    self.db.profile.autosetcombat = value;
end

function BananaBar2:Get_autosetcombat() 
    return self.db.profile.autosetcombat == true;    
end


function BananaBar2:EscapePressed()
	BananaBarEscapeHookFrame:Hide();
	BananaBar2:Set_layoutmode(false) 
end

function BananaBar2:HookEscape()
	BananaBarEscapeHookFrame:Show();
end

function BananaBar2:UnhookEscape()
	BananaBarEscapeHookFrame:Hide();
end




function BananaBar2:Get_action(action) 
    return self.db.profile.actions[action];
end

function BananaBar2:Set_action(action,v)

--    for key,value in pairs(self.db.profile.actions) do
--        if key ~= action then
--            if value == v then
--                self:Print("%s is alreadyused by %s",options.args.mousebutton.args.action_config.validate[value],key);
--                return;
--            end
--        end
--    end
    self:Debug("Set_action "..v)
    self.db.profile.actions[action] = v;

    BananaBar2:UpdateActions();
end

function BananaBar2:UpdateActions()
    self:Debug("Updating Action List");
    self.Actions = {};
    for key,value in pairs(self.db.profile.actions) do
        self.Actions[value] = key;
        self:Debug("click_type_"..value.." = "..key);
    end
end
------------------------------------------
--- Execute_XXX
------------------------------------------

function BananaBar2:Execute_Config()
--    self.dewdrop:Open(
--        UIParent, 
--        'children', function() self.dewdrop:FeedAceOptionsTable(options) end,
--        'cursorX', true, 
--        'cursorY', true
--    )
end

function BananaBar2:ExecuteAction(button, clicktype)
    local action = self.Actions[clicktype];
    if not action then
        self:Debug("No Action for clicktype "..clicktype);
        return;
    end;
    if action == "action_config" then
        self:Execute_Config();
    elseif action == "action_setsymbol" then
        BananaBar2:SetSymbol(button.ButtonId)
    else
        self:Debug("Unknown action".." "..action);
    end
end

------------------------------------------
--- Functions
------------------------------------------

function BananaBar2:ResetSettings()
    --self:ResetDB("profile"); todo
    self.db.profile.settingsversion = actual_settings_version;
    self:ProfileUpdated();
end

function BananaBar2:CheckSettingsVersion()
    if actual_settings_version ~= self.db.profile.settingsversion then
        self:Print(L["oldprofilemessage"]);
        self:ResetSettings();
    end
end


------------------------------------------
--- Called always when any setting is changed
------------------------------------------

function BananaBar2:SettingsChanged()
end

function BananaBar2:ProfileUpdated(layout)
    BananaBar2Button:UpdateAllVisible();
    BananaBar2Button:LoadAllPos();
    BananaBar2Button:UpdateAllArrows();
    BananaBar2Button:UpdateAllButtonFrame(not self.db.profile.hidebuttonframes)
    BananaBar2Button:UpdateAllScale(self.db.profile.scale / 100);
    BananaBar2Button:EnableAllDeadSymbol(self.db.profile.markdead)
    BananaBar2Button:UpdateAllExtraInfo(self.db.profile.showextrainfo)

    for index=1,BANANA_MAX_BUTTONS,1 do
        self.Buttons[index]:SetVisible(self.db.profile.showbutton[index]);
    end
    BananaBar2:UpdateActions();
    --self:Debug("mobsettings?");
    
    for zone,mobs in pairs(self.db.profile.mobsettings) do
        for name,mobsetting in pairs(mobs) do
            AddOptionEntry(zone,name);
        end
    end
    -- self.metro:ChangeMetroRate("BananaUpdate",self.db.profile.updaterate); todo

    BananaBar2AssistButton:UpdateAllVisible();
    BananaBar2AssistButton:LoadAllPos();
    BananaBar2AssistButton:UpdateAllArrows();
    BananaBar2AssistButton:UpdateAllScale(self.db.profile.scaleassist / 100);
    
end
function BananaBar2:SetTooltipButton(button)
    if not button and not self.TooltipButton then
        -- kein button vorher, kein button nachher
        return;
    end

    if button and self.TooltipButton then
        -- tooltip update
        self.TooltipButton = button;
        BananaBar2:UpdateTooltip();
        return;
    end
    
    if not button then
        -- kein button mehr
        self.TooltipButton = nil;
        GameTooltip:Hide();
    else
        -- neuer button
        self.TooltipButton = button;
        BananaBar2:UpdateTooltip();
        GameTooltip:Show();
    end
end    

local tooltip_sort_array = 
{
    ["HUNTER"] = { [0] = 0 },
    ["WARLOCK"] = { [0] = 0 },
    ["PRIEST"] = { [0] = 0 },
    ["PALADIN"] = { [0] = 0 },
    ["MAGE"] = { [0] = 0 },
    ["ROGUE"] = { [0] = 0 },
    ["DRUID"] = { [0] = 0 },
    ["SHAMAN"] = { [0] = 0 },
    ["WARRIOR"] = { [0] = 0 },
    [0] = { [0] = 0 }, --pet
}

function BananaBar2:UpdateTooltip()
    if self.TooltipButton then
        if self.layoutmode then
            GameTooltip:SetOwner(self.TooltipButton.frame, "ANCHOR_BOTTOMRIGHT");
            GameTooltip:ClearLines();
            GameTooltip:SetText(L["layoutmodetooltip"]);
            return;
        end
        
        if self.TooltipButton.AssistButton then
	        GameTooltip:SetOwner(self.TooltipButton.frame, "ANCHOR_TOPRIGHT");
	        GameTooltip:ClearLines();
	        if self.TooltipButton.AssistUnit then
		 		GameTooltip:AddLine(UnitName(self.TooltipButton.AssistUnit),0.9,0.9,0.9)
	        else
		 		return;
            end
            
            if self.TooltipButton.TooltipInfo1 and self.TooltipButton.TooltipInfo2 then
                GameTooltip:AddLine(self.TooltipButton.TooltipInfo1,0.6,0.6,0.6)
                GameTooltip:AddLine(self.TooltipButton.TooltipInfo2,0.9,0.9,0.9)
            elseif self.TooltipButton.TooltipInfo1 then
                GameTooltip:AddLine(self.TooltipButton.TooltipInfo1,0.8,0.5,0.5)
            elseif self.TooltipButton.TooltipInfo2 then
                GameTooltip:AddLine(self.TooltipButton.TooltipInfo2,0.4,0.8,0.5)
            end
        
            --GameTooltip:Show()
            return;
        end
        
        tooltip_sort_array["HUNTER"][0] = 0;
        tooltip_sort_array["WARLOCK"][0] = 0;
        tooltip_sort_array["PRIEST"][0] = 0;
        tooltip_sort_array["PALADIN"][0] = 0;
        tooltip_sort_array["MAGE"][0] = 0;
        tooltip_sort_array["ROGUE"][0] = 0;
        tooltip_sort_array["DRUID"][0] = 0;
        tooltip_sort_array["SHAMAN"][0] = 0;
        tooltip_sort_array["WARRIOR"][0] = 0;
        tooltip_sort_array[0][0] = 0;
        
        local id = self.TooltipButton.ButtonId;

        GameTooltip:SetOwner(self.TooltipButton.frame, "ANCHOR_TOPRIGHT");
        GameTooltip:ClearLines();

        if self.TARGETMARKS[id] then
            local t = self.TARGETS[self.TARGETMARKS[id]];
		 	GameTooltip:AddLine(UnitName(t.info_unit),0.7,0.7,0.7)
            local i;
            for i in pairs(t.from) do
                localizedClass, englishClass = UnitClass(i);
				--
				if UnitIsPlayer(i)  then
					tooltip_sort_array[englishClass][0] = tooltip_sort_array[englishClass][0]+1;
					tooltip_sort_array[englishClass][tooltip_sort_array[englishClass][0]] = i;
				else
					tooltip_sort_array[0][0] = tooltip_sort_array[0][0]+1;
					tooltip_sort_array[0][tooltip_sort_array[0][0]] = i;
				end
				
            end
	        self:AddToolTipLines("WARRIOR",RAID_CLASS_COLORS["WARRIOR"]);
	        self:AddToolTipLines("PALADIN",RAID_CLASS_COLORS["PALADIN"]);
	        self:AddToolTipLines("SHAMAN",RAID_CLASS_COLORS["SHAMAN"]);
	        self:AddToolTipLines("PRIEST",RAID_CLASS_COLORS["PRIEST"]);
	        self:AddToolTipLines("DRUID",RAID_CLASS_COLORS["DRUID"]);
	        self:AddToolTipLines("MAGE",RAID_CLASS_COLORS["MAGE"]);
	        self:AddToolTipLines("WARLOCK",RAID_CLASS_COLORS["WARLOCK"]);
	        self:AddToolTipLines("HUNTER",RAID_CLASS_COLORS["HUNTER"]);
	        self:AddToolTipLines("ROGUE",RAID_CLASS_COLORS["ROGUE"]);
	        self:AddToolTipLines(0,{ r = 0.4, g = 0.4, b = 0.4 });
        else
			GameTooltip:AddLine("not used",0.7,0.7,0.7)
        end
	    --GameTooltip:Show()
    else
    end
end    


function BananaBar2:AddToolTipLines(class,col)
	local i;
	for i = 1,tooltip_sort_array[class][0],1 do
	    GameTooltip:AddLine(UnitName(tooltip_sort_array[class][i]),col.r,col.g,col.b);
	end
end
				


--CT_RAPTGroupUnitButton

function BananaBar2:BananaUpdate()

	local show = false;
    if GetNumGroupMembers() ~= 0 then
    	if self.db.profile.showinraid then
    		show = true;
    	end
    elseif GetNumGroupMembers() ~= 0 then
    	if self.db.profile.showinparty then
    		show = true;
    	end
    else
    	if self.db.profile.showoutofgroup then
    		show = true;
    	end
    end    

	if show ~= self.ShowButtons then
		self.ShowButtons = show;
		BananaBar2Button:UpdateAllVisible();
	end

	show = UnitInRaid("player") and self.db.profile.showraidinfo;

	if show ~= 	self.ShowRaidInfo then
		self.ShowRaidInfo = show;
		BananaBar2AssistButton:UpdateAllVisible();
	end

    BananaBar2:UpdateTooltip();
    
    --debugprofilestart()
    BananaBar2:Scan();

    targets = {}
    for guid,info in pairs(self.TARGETS) do 
        if BananaBar2:TableCount(info.from) > 0 and info.symbol == nil and UnitCanAttack("PLAYER",info.info_unit) then
            table.insert(targets, guid) 
        end
    end

    
    table.sort(targets, 
      function(c1,c2) 
        self:Print(c1)
        if BananaBar2:FromCount(self.TARGETS[c1].from) == BananaBar2:FromCount(self.TARGETS[c2].from) then
          return c1 > c2;
        end
        return BananaBar2:FromCount(self.TARGETS[c1].from) > BananaBar2:FromCount(self.TARGETS[c2].from) 
      end)
    local index = BANANA_RAIDSYMBOL_BUTTON_COUNT+1;
    for _, guid in ipairs(targets) do 
        self.TARGETMARKS[index] = guid;
        index = index + 1;
    end    


    for but=1,BANANA_MAX_BUTTONS,1 do
        if self.TARGETMARKS[but] then
            local t = self.TARGETS[self.TARGETMARKS[but]];
            self.Buttons[but]:SetCount(BananaBar2:FromCount(t.from));
            self.Buttons[but]:SetDead(t.info_dead);
            self.Buttons[but]:SetHuntersmark(t.has_huntersmark);
            self.Buttons[but].HealthBar:SetMinMaxValues(0,t.info_healthmax);
            self.Buttons[but].HealthBar:SetValue(t.info_health);
            self.Buttons[but]:SetMobName(t.info_name);
            if UnitIsUnit("playertarget",t.info_unit) then
	            self.Buttons[but]:SetSelected(false)
            else
	            self.Buttons[but]:SetSelected(false)
            end

            if but > BANANA_RAIDSYMBOL_BUTTON_COUNT then
                self.Buttons[but]:SetButtonSymbolExtra(t.info_unit)
            end
        else
            self.Buttons[but]:SetCount(nil);
            self.Buttons[but]:SetDead(false);
            self.Buttons[but]:SetHuntersmark(false);            
            self.Buttons[but].HealthBar:SetValue(0);
            self.Buttons[but]:SetMobName(nil);
            self.Buttons[but]:SetSelected(false)
            if but > BANANA_RAIDSYMBOL_BUTTON_COUNT then
                self.Buttons[but]:SetButtonSymbolExtra(nil)
            end
        end
    end

    if self:Get_autosetcombat() then
        self:AutoSetSymbols(true);
    end
    
    if self.SetSymbolsOnNextUpdate then
    	self.SetSymbolsOnNextUpdate = false;
        if not BananaBar2:CanSetSymbols() then
            self:Print("Autoset symbols fail, cant set symbols");
	        return;
        end;
        self:Print("Autoset symbols start");
    	self:AutoSetSymbols(false);
    end
    local t2=GetTime();
end

function BananaBar2:SetSymbolsKeyPressed()
    self:Print("Autoset symbols...");
	self.SetSymbolsOnNextUpdate = true;			
end

function BananaBar2:AutoSetSymbols(combatOnly)
    if not BananaBar2:CanSetSymbols() then
	    return;
    end;
    targets = {}
    --self:Dump("self.IGNOREMOBS",self.IGNOREMOBS)    
    local loop = 0
    for guid,info in pairs(self.TARGETS) do    
        if self.IGNOREMOBS[guid] == 1 then
            -- skip
        else
            loop = loop +1;   
            if BananaBar2:FromCount(info.from) > 0 and info.symbol == nil and UnitCanAttack("PLAYER",info.info_unit) and info.symbol == nil then            
                if UnitAffectingCombat(info.info_unit) or combatOnly == false then                
                    self:Print(loop..": "..guid)
                    for j=1,8,1 do                
                        if self.IGNOREMARKS[j] == 1 then
                            -- skip
                        else
                            if self.TARGETMARKS[j] == nil then
                                self:Print("Setting Symbol "..L[("symbolname"..j)].." on "..info.info_name..UnitGUID(info.info_unit));
                                BananaBar2:PlaySet();
                                SetRaidTarget(info.info_unit,j);          
                                self.IGNOREMARKS[j] = 1;
                                self.IGNOREMOBS[guid] = 1;
                                self.TARGETMARKS[j] = UnitGUID(info.info_unit);
                                info.symbol = j;
                                break;
                            end
                        end
                    end            
                end        
            end    
        end
    end

--    if self.TSRA.ut_count > 0 then
--        for i=0,self.TSRA.ut_count-1,1 do
--            local uid = self.TSRA[self.UT_FIRST+i].info_unit;
--            if settype ~= "sscombat" or UnitAffectingCombat(uid) then
--                 local name = UnitName(uid);
--                if self.db.profile.mobsettings[GetLocale()].byname[name] then
--                    if self.db.profile.mobsettings[GetLocale()].byname[name][settype] then
--                        local search = true;
--                        for j=1,8,1 do
--                            if search and self.TSRB[j].used==0 and self.TSRA[j].used==0 then
--                                if self.db.profile.mobsettings[GetLocale()].byname[name][j] then
  --                                	BananaBar2:PlaySet();
--                                    self:Print("Setting Symbol "..L[("symbolname"..j)].." on "..name);
--                                    SetRaidTarget(uid,j);          
--                                    self.TSRA[j].used = 1;
--                                    search = false;
--                                end
--                            end
--                        end
--                    end
--                end
--            end
--        end
--    end
end

function BananaBar2:Get_mobsetting(zone,name,setting)
    local v = self.db.profile.mobsettings[zone][name][setting] or false;
    --BananaBar2:Print("Get_mobsetting '"..zone.."' '"..name.."' '"..setting.."' '"..tostring(v).."'");
    return v;
end

function BananaBar2:Set_mobsetting(v,zone,name,setting)
    --BananaBar2:Print("Set_mobsetting '"..zone.."' '"..name.."' '"..setting.."' '"..tostring(v).."'");
    self.db.profile.mobsettings[zone][name][setting] = v;
end
--/script BananaBar2:AddNewMob("Area51","Bar");
--/script BananaBar2:Print(GetRealZoneText());
--/script BananaBar2:Print(GetRealZoneText().." /// "..GetZoneText());
function BananaBar2:AddNewMob(zone,name)
    local id = self.db.profile.mobsettings
    if not self.db.profile.mobsettings[zone]  then
        self.db.profile.mobsettings[zone] = { }
    end
    if not self.db.profile.mobsettings[zone][name] then
        self.db.profile.mobsettings[zone][name] = { }
        self:Debug("Added new mob: "..UnitName("mouseover"))
    end

    AddOptionEntry(zone,name)
end
    
function BananaBar2:CHAT_MSG_ADDON(prefix,message,messagetype,sender)
    if prefix == "CTRA" then
        --BananaBar2:Print("M:"..message.."<:>"..messagetype.."<:>"..sender);
    end
end
function BananaBar2:ZoneText()
    return GetRealZoneText() or "Unknown";
end

function BananaBar2:UPDATE_MOUSEOVER_UNIT(a1,a2,a3)
    if UnitExists("mouseover") then
        if UnitCanAttack("player", "mouseover")  and (not UnitIsCivilian("mouseover")) then
            if not UnitIsPlayer("mouseover") then
                self:AddNewMob(self:ZoneText(),UnitName("mouseover"))
            end
        end
    end
end;

function AddOptionEntry(zone,name,mobid)
    if not options.args.mobsettings.args[zone] then
        options.args.mobsettings.args[zone] =
        {
            type = "group", 
            name = zone,
            desc = zone,
            args = {
            },
        }
    end
	
    if not options.args.mobsettings.args[zone].args[name] then
        options.args.mobsettings.args[zone].args[name] =
        {
            type = "group", 
            name = name,
            desc = name,
            args = {
                combat = {
                    type = "toggle", 
                    width = "full",
                    name = L["autosymbolsoncombat"],
                    desc = L["autosymbolsoncombatdesc"],
                    get = function(info) return BananaBar2:Get_mobsetting(zone,name,"sscombat"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sscombat"); end,
                    order = 110;
                },
                mouseover = {
                    type = "toggle", 
                    width = "full",
                    name = L["autosymbolsonmouseover"],
                    desc = L["autosymbolsonmouseoverdesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"ssmo"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"ssmo"); end,
                    order = 120;
                },
                spacer = {
                    type = "header", 
                    name = "-",
                    order = 130;
                },
                symbol1 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR1..L["symbolname1"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym1"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym1"); end,
                    order = 201;
                },
                symbol2 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR2..L["symbolname2"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym2"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym2"); end,
                    order = 202;
                },
                symbol3 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR3..L["symbolname3"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym3"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym3"); end,
                    order = 203;
                },
                symbol4 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR4..L["symbolname4"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym4"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym4"); end,
                    order = 204;
                },
                symbol5 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR5..L["symbolname5"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym5"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym5"); end,
                    order = 205;
                },
                symbol6 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR6..L["symbolname6"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym6"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym6"); end,
                    order = 206;
                },
                symbol7 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR7..L["symbolname7"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym7"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym7"); end,
                    order = 207;
                },
                symbol8 = {
                    type = "toggle", 
                    name = "|c"..BANANA_SYMBOL_COLOR8..L["symbolname8"].."|r",
                    desc = L["autosymboldesc"],
                    get = function() return BananaBar2:Get_mobsetting(zone,name,"sym8"); end,
                    set = function(info,v) BananaBar2:Set_mobsetting(v,zone,name,"sym8"); end,
                    order = 208;
                },
            }
        }
    end
end






function BananaBar2:Get_action_part(action,x) 
    local a = BananaBar2:Get_action(action);
    if x == 1 then
        return bit.band(a,1) ~= 0;     
    end
    if x == 2 then
        return bit.band(a,2) ~= 0;     
    end
    if x == 3 then
        return bit.band(a,4) ~= 0;     
    end
    return math.floor(a/8) == (x-10)
end

function BananaBar2:Set_action_part(action,x,v)
    local a = BananaBar2:Get_action(action);
    if x == 1 then
        if v then
            a = bit.bor(a,1);
        else
            a = bit.band(a,255-1);
        end
    elseif x == 2 then
        if v then
            a = bit.bor(a,2);
        else
            a = bit.band(a,255-2);
        end
    elseif x == 3 then
        if v then
            a = bit.bor(a,4);
        else
            a = bit.band(a,255-4);
        end
    else
        a = bit.mod(a,8) + (8 * (x-10));
    end
    BananaBar2:Set_action(action,a);
end


function BananaBar2:PlaySet()
    PlaySoundFile(BANANA_SOUND_SET);
end
function BananaBar2:PlayRemove()
    PlaySoundFile(BANANA_SOUND_REMOVE);
end
function BananaBar2:PlayRemoveAll()
    PlaySoundFile(BANANA_SOUND_REMOVE_ALL);
end

function BananaBar2:PlayError()
    PlaySoundFile(BANANA_SOUND_ERROR);
end





function BananaBar2:FindSpellIdByTexture(searchtex)
    local searchid = 1;
    local tex;
    local resultid = nil;
    repeat
        tex = GetSpellTexture(searchid, BOOKTYPE_SPELL); 

        if tex == searchtex then
            return searchid;
        end
        searchid = searchid +1;
    until tex == nil;
    return nil;
end


function BananaBar2:SpellHuntersmark()
	if not UnitCanAttack("player", "target")    then
    	BananaBar2:PlayError();
		return;
	end
    local spell = BananaBar2:FindSpellIdByTexture(BANANA_ABILITY_HUNTER_SNIPERSHOT);
    if spell == nil then
        BananaBar2:Print("Huntersmark Spell not found");
        BananaBar2:PlayError();
        return;
    end
    CastSpell(spell,BOOKTYPE_SPELL);
    BananaBar2:PlaySet();
end



function BananaBar2:OnClick()
	PlaySoundFile("Interface\\AddOns\\BananaBarClassic\\Sound\\2hh.mp3");
end

function BananaBar2:OnTooltipUpdate()
	Tablet:SetHint("")
end


function BananaBar2:BananaCursor()
	if BananaBar2.Dragging then
		if BananaBar2.DragPreparing then
			local x, y = GetCursorPosition();
			x = x - self.DragCursorPosX
			y = y - self.DragCursorPosY
			dist = math.sqrt(x*x+y*y)

			if BananaBar2.DragMouseButton == "LeftButton" and dist > 10 then
				BananaBar2.DragPreparing = false
			elseif BananaBar2.DragMouseButton == "RightButton" and dist > 20 then
                BananaBar2.CancelTimer(self.BananaCursorTimer)
				BananaBar2.Dragging = false;
                self:Print("Starting Layoutmode")
				self:BananaSetCursor(nil);
                self:Set_layoutmode(true)
                return;
			else
				return;
			end
		end
				
		if UnitExists("MOUSEOVER") then
			if self.DragStartButton.ButtonId <= 8 then
				self:BananaSetCursor(BANANA_RAID_CURSORS[self.DragStartButton.ButtonId])
			else
				self:BananaSetCursor(BANANA_RAID_CURSORS[9])
			end
		elseif BananaBarButtonUnderMouse and BananaBarButtonUnderMouse ~= self.DragStartButton then
			if self.DragStartButton.ButtonId <= 8 then
				self:BananaSetCursor(BANANA_RAID_CURSORS[self.DragStartButton.ButtonId])
			else
				self:BananaSetCursor(BANANA_RAID_CURSORS[9])
			end
		else
			if self.DragStartButton.ButtonId <= 8 then
				self:BananaSetCursor(BANANA_RAID_CURSORS_GREY[self.DragStartButton.ButtonId])
			else
				self:BananaSetCursor(BANANA_RAID_CURSORS_GREY[9])
			end
		end
	elseif BananaBar2.MouseOverPainting then
		self:BananaSetCursor("Interface\\AddOns\\BananaBarClassic\\Images\\raidiconcursor");
		self:MouseOverTargeting();
	elseif self.ShowMouseSymbol then
		if UnitExists("MOUSEOVER") then
			local idx = GetRaidTargetIndex("MOUSEOVER");
			if idx and idx>=1 and idx <=8 then
				self:BananaSetCursor(BANANA_RAID_CURSORS[idx])
			else
				self:BananaSetCursor(nil)
            end
        else
            self:BananaSetCursor(nil)
        end
        
	end
end

function BananaBar2:SearchDown()
	if BananaBar2.Dragging or BananaBar2.MouseOverPainting then
		return;
	end
	self:Print("Changing mouse cursor when over marked mob now.");
	self.ShowMouseSymbol = true;
    self.BananaCursorTimer = self:ScheduleRepeatingTimer("BananaCursor", 0.1 , self);
end

function BananaBar2:SearchUp()
	if self.ShowMouseSymbol then
		self:Print("No more changing mouse cursor when over marked mob now.");
		self.ShowMouseSymbol = false;
        BananaBar2.CancelTimer(self.BananaCursorTimer)
   	end
end

local targetingsymbol=1;
function BananaBar2:MouseOverTargeting()
    --self:Print("MouseOverTargeting")
	if UnitExists("MOUSEOVER") then
		if targetingsymbol > 8 then
			--BananaBar2:Print("alle symbole verbraucht");
			return;
		end

		if not BananaBar2:TestScanThisTarget("MOUSEOVER") then
			--BananaBar2:Print("not BananaBar2:TestScanThisTarget");
			return;
		end
		
		local name = UnitName("MOUSEOVER");
		local zone = self:ZoneText();
        
        local ms = self:GetMobSettings(zone, name);

        if not ms then
            self:BananaSetCursor("Interface\\AddOns\\BananaBarClassic\\Images\\raidiconcursorno");
        	return;
        end
        local guid = UnitGUID("MOUSEOVER")
        

        
		local rti = GetRaidTargetIndex("MOUSEOVER") or 0;

        if rti == 0 then
            if (targetingduplist[guid]) then
                self:BananaSetCursor("Interface\\AddOns\\BananaBarClassic\\Images\\raidiconcursorno");
                return;
            end
                
			BananaBar2:PlaySet();
			BananaBar2:Print("Set Symbol "..L[("symbolname"..targetingsymbol)].." on "..UnitName("MOUSEOVER"));
            SetRaidTarget("MOUSEOVER",targetingsymbol);
            targetingduplist[guid] = targetingsymbol;
			targetingsymbol = targetingsymbol+1;
        else
            self:BananaSetCursor("Interface\\AddOns\\BananaBarClassic\\Images\\raidiconcursorno");
        end
        
	end	
end



function BananaBar2:GetMobSettings(zone, name)
    if not self.db.profile.mobsettings[zone] then
        self.db.profile.mobsettings[zone] = {}
    end
    if not self.db.profile.mobsettings[zone][name] then
        self.db.profile.mobsettings[zone][name] = {
            symbols = "12345678";
        }
    end
    
    return self.db.profile.mobsettings[zone][name];
end
function BananaBar2:MouseOverSymbolsDown()
	if BananaBar2.Dragging then
		-- dont start, dragging in progress
		--BananaBar2:Print("dragging in progress, not painting");
	elseif self.ShowMouseSymbol then
		-- dont start, dragging in progress
		--BananaBar2:Print("searching in progress, not painting");
	else
		-- start mouseoverpainting
		BananaBar2.MouseOverPainting = true;	
        self.BananaCursorTimer = self:ScheduleRepeatingTimer("BananaCursor", 1, self);

        targetingsymbol = 1;
        targetingduplist = {}
	end
end

function BananaBar2:MouseOverSymbolsUp()
    if 	BananaBar2.MouseOverPainting then
        BananaBar2.CancelTimer(self.BananaCursorTimer)
		self:BananaSetCursor(nil)
	end
	BananaBar2.MouseOverPainting = false;	
end



function BananaBar2:DragPrepare(dragStartButton,mouseButton)
	if 	BananaBar2.MouseOverPainting then
		--BananaBar2:Print("painting in progress, not dragging");
		-- painting in progress
	elseif self.ShowMouseSymbol then
		--BananaBar2:Print("searching in progress, not dragging");
		-- painting in progress
	else
		BananaBar2.Dragging = true;
		BananaBar2.DragPreparing = true;
		BananaBar2.DragStartButton = dragStartButton;
		BananaBar2.DragMouseButton = mouseButton;
        self.BananaCursorTimer = self:ScheduleRepeatingTimer("BananaCursor", 0.1, self);
		local x, y = GetCursorPosition();
		self.DragCursorPosX = x;
		self.DragCursorPosY = y;
	end
end

function BananaBar2:DragStop(dragStopButton,mouseButton)
    if BananaBar2.Dragging then
		BananaBar2.Dragging = false;
        BananaBar2.CancelTimer(self.BananaCursorTimer)
		self:BananaSetCursor(nil);
		if BananaBar2.DragPreparing then
			--self:Debug("drag not started, preparing only")	
			return;
		end
		if dragStopButton == nil or dragStopButton.AssistButton then
			--self:Debug("drag from "..self.DragStartButton.ButtonId.." to nothing")	
			if UnitExists("MOUSEOVER") then
				BananaBar2:DragButtonOnUnit(self.DragStartButton,mouseButton)		
				
			else	
				local unit = BananaBar2:GetUnitBySymbol(self.DragStartButton.ButtonId)
				if unit then
                    SetRaidTarget(unit,0);
                    PlayRemove();
				end
			end
		elseif dragStopButton == self.DragStartButton then
			--self:Debug("no drag")	
		else
				--self:Debug("drag from "..self.DragStartButton.ButtonId.." to "..dragStopButton.ButtonId)	
				BananaBar2:ChangeSymbol(self.DragStartButton.ButtonId, dragStopButton.ButtonId)
		end
	end
end


function BananaBar2:DragButtonOnUnit(button,mouseButton)		
    if GetRaidTargetIndex("MOUSEOVER") == button.ButtonId then
        BananaBar2:PlayRemove();
        SetRaidTarget("MOUSEOVER", 0);
    else
        if GetRaidTargetIndex("MOUSEOVER") then
            local old = GetRaidTargetIndex("MOUSEOVER")
            if self.TARGETMARKS[old] then
                BananaBar2:ChangeSymbol(old,button.ButtonId)
            else
                SetRaidTarget("MOUSEOVER", button.ButtonId);
                BananaBar2:PlaySet();
            end
        else
            SetRaidTarget("MOUSEOVER", button.ButtonId);
            BananaBar2:PlaySet();
        end

    end
end

function BananaBar2:Debug(value)
    --BananaBar2:Print(dump(value))
end
function BananaBar2:Dump(name, value)
    --BananaBar2:Print(name..": "..dump(value))
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. tostring(k) .. '"' end
            s = s .. '[' .. tostring(k) .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    end

    if type(o) == 'function' then
        return 'F'
    end

    return tostring(o)

end

function BananaBar2:IsActive()
    return true;
end


function BananaBar2:TableCount(list)
    local count = 0
    for key in pairs(list) do 
        count = count + 1 
    end
    return count
end

function BananaBar2:FromCount(list)
    local count = 0
    for key in pairs(list) do 
        if key ~= "MOUSEOVER" then
            count = count + 1 
        end
    end
    return count
end

function BananaBar2:AssistScan(i,target,unit,raidIndex)
	
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
						MT = BananaBar2:GetMt(target);
					elseif fileName == "PALADIN" then
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_PALADIN);
						MT = BananaBar2:GetMt(target);
					elseif fileName == "SHAMAN" then
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_SHAMAN);
						MT = BananaBar2:GetMt(target);
					elseif fileName == "DRUID" then
						BananaBar2.AssistButtons[i]:SetButtonTexture(BANANA_TEXTURE_DRUID);
						MT = BananaBar2:GetMt(target);
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


function BananaBar2:AssistScanning()
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

function BananaBar2:GetUnitsToScan()
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

function BananaBar2:Scan()


    self:ResetScanBlock()

    self:AssistScanning();

    local unitsToScan = self:GetUnitsToScan();

    for unit,unitparent in pairs(unitsToScan) do
        self:ScanUnit(unit,unitparent); 
    end
end

function BananaBar2:ResetScanBlock(block)
    self.TARGETS = { };
    self.TARGETMARKS = { };
end

function BananaBar2:ScanUnit(unit,source)
    
    if source == "" then
        source = nil;
    end

    if UnitExists(unit) then
        --BananaBar2:Print("ScanUnit "..unit);    
        local rti = GetRaidTargetIndex(unit)
        
        self:AddTargetToList(rti,unit,source);
    end
end


function BananaBar2:AddTargetToList(rti,unit,source)
    local guid = UnitGUID(unit)
    
    if rti then
        if self.TARGETMARKS[rti] == nil then
            self.TARGETMARKS[rti] = guid
            self.IGNOREMARKS[rti] = 1;
            self.IGNOREMOBS[guid] = 1;
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

function BananaBar2:UnitHasHuntersMark(unit)
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

function BananaBar2:TestScanThisTarget(unit)
    if UnitCanAttack("player", unit)  and (not UnitIsCivilian(unit)) then
        return true;
    else
        return false;
    end
    --UnitExists
    --UnitIsDead
    --UnitIsCorpse
end

function BananaBar2:CanSetSymbols()
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


function BananaBar2:ChangeSymbol(indexFrom, indexTo)
	local unit1 = BananaBar2:GetUnitBySymbol(indexFrom);
	local unit2 = BananaBar2:GetUnitBySymbol(indexTo);
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
		if unit2 then
			--move
			SetRaidTarget(unit2,indexFrom);
            BananaBar2:PlaySet();
            BananaBar2:PlayRemove();
		else
			BananaBar2:PlayError();
		end
	end
end

function BananaBar2:GetUnitBySymbol(index)
    if self.TARGETMARKS[index] then
        return self.TARGETS[self.TARGETMARKS[index]].info_unit
    end
    return nil;
end

function BananaBar2:SetSymbol(index)
    if GetRaidTargetIndex("target") == index then
        BananaBar2:PlayRemove();
        SetRaidTarget("target", 0);
    else
        SetRaidTarget("target", index);
        BananaBar2:PlaySet();
    end
end

function BananaBar2:SetOrRemoveSymbol()
    if not UnitExists("target") then
        Banana_TargetRaidSymbol(index);
        if not UnitExists("target") then
            self.Addon:Debug("keine target ausgewählt und kein mob gefunden um target zu entfernen");
            return;
        end
    end
    
    local oldindex = (Banana_GetSymbol("TARGET") or 0);
	if oldindex == index then
		SetRaidTarget("TARGET", 0)
		Banana_PlayRemove1();
	else
        SetRaidTarget("TARGET", index)
        BananaBar2:PlaySet();
	end
	Banana_UpdateStatus();
end
