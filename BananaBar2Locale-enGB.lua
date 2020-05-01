local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("BananaBar2", "enGB", true);

if not L then return end


-- all the lines starting with - should not be translated, 
-- these lines are just descriptions for translators

-- all texts where the textid ends with "desc" are 
-- long descriptions for the menu entry shown in the help and in the tooltip

L.showunmarkeddesc             = "Anzeigen und ausblenden von Buttons";	

L.unmarked                     = "Unmarkiert";

-- Short name of the Addon, should normally not be translated
L.addonname                       = "BananaBar"; 

-- Long name of the Addon, the word BananaBar2 should normally not be translated, 
-- the appendix "Raid Symbols" can be translated
L.addonnamelong                   = "BananaBar Raid Symbols";


L.showdebugmessages = "Show debug messages";

L.showdebugmessagesdesc = "Show debug messages, usefur for development only";

-- Texts in the WOW Key binding Dialog
-- Text should not exceed one line to be correctly displayed in the dialog

-- A key to hold down, then moving over a group of mobs to set raid symbols on them 
L.binding_mouseover               = "Key to hold down for mouse over targeting";

-- When this key is pressed, raid symbols are set to all mobs that 
-- are targeted by any player in the raid. Which symbols on which mobs (*) can be configured 
-- in the mobsettings menu ( * Symbol to mob assignment can be configured. )
L.binding_key                     = "Key to set symbols to all accessible mobs";

-- when this key is held down, the mouse cursor changes it's icon to the icon of the 
-- mob you are hoovering. This can be used to find a specific mob in a group or check the 
-- symbol of the mob you are searching for 
L.binding_search                  = "Search for a symbol with mouse over";


L.autosetcombat                  = "Auto set symbols on mobs when coming in fight with player";
L.autosetcombatdesc              = "Auto set symbols on mobs when coming in fight with player";


-- the submenu where you can find all the settings corresponding to all visual effects
-- of bananabar. For example "Hide buttons"; "button size"; "show button frames" etc.
L.design                          = "Visibility settings";
L.designdesc                      = "Visibility settings";

-- hide buttons that are currently not used (no mob has this target)
-- buttons will also be hidden if no party member has targeted the mob 
-- with the specific symbol
L.hideunused                      = "Hide unused buttons";
L.hideunuseddesc                  = "Hide buttons if they are not used at the moment";

-- hide the black frame around the button
L.hidebuttonframes                = "Hide button frames";
L.hidebuttonframesdesc            = "Changes the visibility of the button frames";


-- mark dead targets with an overlay image over the button        
L.markdead                        = "Mark dead targets";
L.markdeaddesc                    = "Marks dead targets with an overlayed symbol";


-- submenu where you can enable/disable single buttons
L.showbutton                      = "Show button for..."; 

-- description used for normal buttons and also for the parent menu "Show buttons for"
L.showbuttondesc                  = "Show/Hide single buttons"; 

-- used for huntersmark buttons
L.showhuntersmarkdesc             = "Show Hunter's Mark button"; 

-- Translations for the button names
-- use RAID_TARGET_1 and so on for the original blizzard names
-- in our guild we use the name "Condom" for the orange circle
L.symbolname1                     = RAID_TARGET_1;
L.symbolname2                     = "Condom";
L.symbolname3                     = RAID_TARGET_3;
L.symbolname4                     = RAID_TARGET_4;
L.symbolname5                     = RAID_TARGET_5;
L.symbolname6                     = RAID_TARGET_6;
L.symbolname7                     = RAID_TARGET_7;
L.symbolname8                     = RAID_TARGET_8;
-- Symbol name for the huntersmark
L.huntersmark                     = "Hunter's Mark";

-- menu entry to activate the layout mode
-- in the layoutmode you can move, seperate and concatenate buttons        
L.layoutmode                      = "Activate layoutmode";
L.layoutmodedesc                  = "Activetes the layoutmode.Use it to move and group buttons.";



-- scale the normal BananaBar2 button size
L.scale                           = "Scale"; 
L.scaledesc                       = "Scale the buttons from 10% to 200%"; 

-- scale the 40 buttons of the raid overview panel
L.scaleassist                     = "Scale assist buttons"; 
L.scaleassistdesc                 = "Scale assist buttons the buttons from 10% to 200%"; 

-- reset everything to the defaults, except the settings in the submenu "mobsettings"        
L.reset                           = "Reset"; 
L.resetdesc                       = "reset all settings of the current profile"; 

-- this message comes up if BananaBar2 has detected that you have installed a newer version 
-- of BananaBar which is not compatible with the old one and the profile is resetted to defaults
L.oldprofilemessage               = "The settings of the loaded profile are from an older BananaBar2 "..
			  "version, settings are resetted to their defaults.";

-- name for the /bb2config console command
L.config                          = "Config"; 
L.configdesc                      = "Opens the config popup menu"; 


-- name for the config menu entry in the mouse button settings menu
L.action_config                   = "Open config popup";
L.action_configdesc               = "Opens the config menu popup";

-- name for the "Target mob by symbol" menu entry in the mouse button settings menu
-- this still exists in the menu, but is no longer supported in WoW 2.0
L.action_target                   = "Target mob by symbol";
L.action_targetdesc               = "Target mob of the corresponding symbol or hunter's mark";

-- name for the config menu entry in the mouse button settings menu
L.action_setsymbol                = "Set Raid Symbol or Hunter's Mark";
L.action_setsymboldesc            = "Set Raid Symbol or Hunter's Mark on the mob you actually targeted";

-- setting in the mobsettings menu, if activated this mob will get a symbol
-- if you press the autosymbols key (binding_key)
L.autosymbolsbyhotkey             = "Enable autosymbols by hotkey";
L.autosymbolsbyhotkeydesc         = "If enabled you can set symbols automatic on mobs by pressing the specific hotkey";

-- setting in the mobsettings menu, if activated for a mob, this mob gets a symbol 
-- whenever it enters combat with your group and anyone of the group has targeted it
L.autosymbolsoncombat             = "Enable autosymbols when mob enters combat";
L.autosymbolsoncombatdesc         = "If enabled symbols are set on this mob when it enters combat with your raid";

-- if activated this mob will be SKIPPED for mouse over targeting        
L.autosymbolsonmouseover          = "Disable autosymbols on mouseover";
L.autosymbolsonmouseoverdesc      = "If checked, setting symbols on mouseover is disabled";

-- description for the menu entrys for the specific mobs in the mobsettings menu          
L.autosymboldesc                  = "If checked this symbol is used for autosymbols and autosymbols in combat, "..
			 "mouseover targeting always uses all symbols";


-- shift key on the keyboard, used in mouse button settings        
L.shift                           = "Shift";
L.shiftdesc                       = "Shift key";
-- control key (ctrl) on the keyboard, used in mouse button settings        
L.control                         = "Control";
L.controldesc                     = "Control key";
-- alt key on the keyboard, used in mouse button settings        
L.alt                             = "Alt";
L.altdesc                         = "Alt key";

-- Left mousebutton        
L.leftmouse                       = "Left Mousebutton";
L.leftmousedesc                   = "Left Mousebutton";
-- Right mousebutton        
L.rightmouse                      = "Right Mousebutton";
L.rightmousedesc                  = "Right Mousebutton";
-- Middle mousebutton        
L.middlemouse                     = "Middle Mousebutton";
L.middlemousedesc                 = "Middle Mousebutton";
-- mousebutton 4
L.mouse4                          = "Mousebutton 4";
L.mouse4desc                      = "Mousebutton 4";
-- mousebutton 5
L.mouse5                          = "Mousebutton 5";
L.mouse5desc                      = "Mousebutton 5";

-- the update rate how often your raid will be scanned 
L.updaterate                      = "Change update speed";
L.updateratedesc                  = "Change the update time in seconds, lower value "..
			  "means more updates but may cause lag on very slow computers";

-- menu entry for the mob settings menu
L.mobsettings                     = "Change mob specific settings";
L.mobsettingsdesc                 = "Change settings for specific mobs for automatic symbol setting";

-- menu entry for the mouse button settings menu
L.mousebutton                     = "Change mousebutton settings";
L.mousebuttondesc                 = "Change what happens when clicking on a BananaBar button";

-- The tooltip text that occurs over the buttons when in layout mode         
L.layoutmodetooltip               = "Layoutmode is active.\n"..
			  "Use left mousebutton to move a button or a group of buttons.\n"..
			  "Right mousebutton to disconnect linked buttons.\n"..
			  "Mouse5 to disconnect all links.\n"..
			  "Mouse4 or escape.";
											
-- shows the BananaBar buttons when you are in a raid group
L.showinraid                      = "Show buttons in raid";
L.showinraiddesc                  = "Show buttons when in raid group";
-- shows bananabar buttons when you are in a normal party 
L.showinparty                     = "Show buttons in party";
L.showinpartydesc                 = "Show buttons when in a normal party";
-- shows bananabar buttons when you are in a normal party 
L.showoutofgroup                  = "Show buttons out of group";
L.showoutofgroupdesc              = "Show buttons when you are not in group";

-- shows or hides the raid info panel (this panel is only shown when you are in a raid
L.showraidinfo                    = "Show raid info panel";
L.showraidinfodesc                = "Show raid info panel when in raid, out of raid it is always hidden";

-- Shows mob name and health bar next to the raid symbol buttons
L.showextrainfo             		= "Show mob name and health bar";
L.showextrainfodesc               = "Shows mob name and health bar next to the raid symbol buttons";

