local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("BananaBar2", "deDE", false);

if not L then return end



-- all the lines starting with – should not be translated, 
-- these lines are just descriptions for translators

-- all texts where the textid ends with "desc” are 
-- long descriptions for the menu entry shown in the help and in the tooltip



-- Short name of the Addon, should normally not be translated
L.addonname                       = "BananaBar2";

-- Long name of the Addon, the word BananaBarClassic should normally not be translated, 
-- the appendix "Raid Symbols” can be translated
L.addonnamelong                   = "BananaBar2 Raid Symbole";

        
-- Texts in the WOW Key binding Dialog
-- Text should not exceed one line to be correctly displayed in the dialog

-- A key to hold down, then moving over a group of mobs to set raid symbols on them 
L.binding_mouseover               = "Taste zum vergeben von Symbolen durch Mouseover";

-- When this key is pressed, raid symbols are set to all mobs that 
-- are targeted by any player in the raid. Which symbols on which mobs (*) can be configured 
-- in the mobsettings menu ( * Symbol to mob assignment can be configured… )
L.binding_key                     = "Taste zum setzen von Symbolen auf alle erreichbaren Gegner";

-- when this key is held down, the mouse cursor changes it’s icon to the icon of the 
-- mob you are hoovering. This can be used to find a specific mob in a group or check the 
-- symbol of the mob you are searching for 
L.binding_search                  = "Taste zum suchen von Symbolen durch Mouseover";


L.autosetcombat                  = "Symbole automatisch auf Mobs bei Kampfeintritt";
L.autosetcombatdesc              = "Setze Symbole automatisch auf Mobs die in den Kampf eintreten";


-- the submenu where you can find all the settings corresponding to all visual effects
-- of bananabar. For example "Hide buttons”, "button size”, "show button frames” etc.
L.design                          = "Visuelle Einstellungen";
L.designdesc                      = "Einstellungen zur Sichtbarkeit, Größe und Aussehen der Buttons";

-- hide buttons that are currently not used (no mob has this target)
-- buttons will also be hidden if no party member has targeted the mob 
-- with the specific symbol
L.hideunused                      = "Nicht benutzte Symbole ausblenden";
L.hideunuseddesc                  = "Blendet automatisch alle Symbole aus die zur Zeit nicht benutzt werden oder die nicht erreichbar sind";
        
-- hide the black frame around the button
L.hidebuttonframes                = "Rahmen der Symbol Buttons ausblenden";
L.hidebuttonframesdesc            = "Blendet die schwarten rahmen rund um die Symbol Buttons aus";


-- mark dead targets with an overlay image over the button        
L.markdead                        = "Tote Ziele markieren";
L.markdeaddesc                    = "Markiert die buttons deren Ziele Tot sind mit einem speziellen Symbol.";
        

-- submenu where you can enable/disable single buttons
L.showbutton                      = "Einzelne buttons Anzeigen/Ausblenden";

-- description used for normal buttons and also for the parent menu "Show buttons for”
L.showbuttondesc                  = "Anzeigen und ausblenden von Buttons";

L.showunmarkeddesc             = "Anzeigen und ausblenden von Buttons";	
-- Symbol name for mob buttons without any mark
L.unmarked                     = "Unmarkiert";
        
-- Translations for the button names
-- use RAID_TARGET_1 and so on for the original blizzard names
-- in our guild we use the name "Condom" for the orange circle
L.symbolname1                     = RAID_TARGET_1;
L.symbolname2                     = RAID_TARGET_2;
L.symbolname3                     = RAID_TARGET_3;
L.symbolname4                     = RAID_TARGET_4;
L.symbolname5                     = RAID_TARGET_5;
L.symbolname6                     = RAID_TARGET_6;
L.symbolname7                     = RAID_TARGET_7;
L.symbolname8                     = RAID_TARGET_8;

-- menu entry to activate the layout mode
-- in the layoutmode you can move, seperate and concatenate buttons        
L.layoutmode                      = "Layoutmode aktivieren";
L.layoutmodedesc                  = "Aktiviert den Modus in dem BananaBar Buttons verschoben und gruppiert werden können.";
        
        
        
-- scale the normal BananaBarClassic button size
L.scale                           = "Skalierung";	
L.scaledesc                       = "Button Skalierung zwischen 10% und 200% einstellen";	
        
-- scale the 40 buttons of the raid overview panel
L.scaleassist                     = "Skalierung der RaidInfo Buttons"; 
L.scaleassistdesc                 = "Skalierung der RaidInfo Buttons zwischen 10% und 200% einstellen"; 

-- reset everything to the defaults, except the settings in the submenu "mobsettings”        
L.reset                           = "Einstellungen zurücksetzen";	
L.resetdesc                       = "Setzt alle Einstellungen auf die Defaultwerte zurück mit Ausnahme der MobSettings";	
        
-- this message comes up if BananaBarClassic has detected that you have installed a newer version 
-- of BananaBar which is not compatible with the old one and the profile is resetted to defaults
L.oldprofilemessage               = "BananaBarClassic hat erkannt das die vorhandenen einstellungen zu einer älteren version von BananaBar gehören die zu der aktuellen inkompatibel ist. Alle Einstellungen wurden auf die Defaultwerte zurückgesetzt.";


-- name for the /bb2config console command
L.config                          = "Konfigurationsmenu";	
L.configdesc                      = "Konfigurationsmenu aufrufen";	
        

-- name for the config menu entry in the mouse button settings menu
L.action_config                   = "Konfigurationsmenu";
L.action_configdesc               = "Konfigurationsmenu aufrufen";
        
-- name for the "Target mob by symbol" menu entry in the mouse button settings menu
-- this still exists in the menu, but is no longer supported in WoW 2.0
L.action_target                   = "Ziel anhand des Symbols anwählen";
L.action_targetdesc               = "Ziel durch Klick auf den Button des entsprechenden Symbols automatisch auswählen.";

-- name for the config menu entry in the mouse button settings menu
L.action_setsymbol                = "Symbol setzen";
L.action_setsymboldesc            = "Setzt das Symbol des entsprechenden Buttons auf des gerade anvisierte Ziel.";

-- setting in the mobsettings menu, if activated this mob will get a symbol
-- if you press the autosymbols key (binding_key)
L.autosymbolsbyhotkey             = "Automatische setzen von Symbolen durch Hotkey";
L.autosymbolsbyhotkeydesc         = "Aktiviert das automatische setzen von Symbolen durch Hotkey für diesen Gegner.";
        
-- setting in the mobsettings menu, if activated for a mob, this mob gets a symbol 
-- whenever it enters combat with your group and anyone of the group has targeted it
L.autosymbolsoncombat             = "Automatisches setzen von Symbolen bei Kampfeintritt";
L.autosymbolsoncombatdesc         = "Aktiviert das automatische setzen von Symbolen auf Gegner wenn die in den Kampf eintreten für diesen Gegner.";

-- if activated this mob will be SKIPPED for mouse over targeting        
L.autosymbolsonmouseover          = "Gegner beim setzen Symbolen durch MouseOver ausschließen";
L.autosymbolsonmouseoverdesc      = "Diesen Gegner beim vergeben von Symbolen durch MouseOver ausschließen";

-- description for the menu entrys for the specific mobs in the mobsettings menu          
L.autosymboldesc                  = "Dieses Symbol auswählen wenn es beim automatischen setzen von Symbolen im Kampf oder nach Hotkey, für MouseOver werden imme alle Symbole benutzt";


-- shift key on the keyboard, used in mouse button settings        
L.shift                           = "Shift";
L.shiftdesc                       = "Shift Taste";
-- control key (ctrl) on the keyboard, used in mouse button settings        
L.control                         = "Strg";
L.controldesc                     = "Strg Taste";
-- alt key on the keyboard, used in mouse button settings        
L.alt                             = "Alt";
L.altdesc                         = "Alt Taste";

-- Left mousebutton        
L.leftmouse                       = "Linke Maustaste";
L.leftmousedesc                   = "Linke Maustaste";
-- Right mousebutton        
L.rightmouse                      = "Rechte Maustaste";
L.rightmousedesc                  = "Rechte Maustaste";
-- Middle mousebutton        
L.middlemouse                     = "Mittlere Maustaste";
L.middlemousedesc                 = "Mittlere Maustaste";
-- mousebutton 4
L.mouse4                          = "Maustaste 4";
L.mouse4desc                      = "Maustaste 4";
-- mousebutton 5
L.mouse5                          = "Maustaste 5";
L.mouse5desc                      = "Maustaste 5";
        
-- the update < > rate how often your raid will be scanned 
L.updaterate                      = "Update Rate";
L.updateratedesc                  = "Update Rate einstellen, kleinere Werte bedeuten schnellere veränderung der Anzeige aber auf langsamen rechnern möglicher weise Lag";

-- menu entry for the mob settings menu
L.mobsettings                     = "Mob Einstellungen";
L.mobsettingsdesc                 = "Einstellungen zum automatischen vergeben von Symbolen je nach Mob";

-- menu entry for the mouse button settings menu
L.mousebutton                     = "Mousebutton Einstellungen";
L.mousebuttondesc                 = "Mousebutton Einstellungen für die Symbol Buttons";

-- The tooltip text that occurs over the buttons when in layout mode         
L.layoutmodetooltip               = "Layoutmode ist Aktiv.\n"..
                                  "Linke Maustaste zum Verschieben von Buttons als Gruppe,\n"..
                                  "Rechte Maustaste zum lösen der Verankerung zwischen den Buttons.\n"..
                                  "Zum verankern von Buttons, diese an der betreffenden seite leicht übereinander schieben.\n"..
                                  "Maustaste5 zum entfernen aller verankerungen.\n"..
                                  "Maustaste4 oder Escape zum beenden des Layoutmode.";
                                                                
-- shows the BananaBar buttons when you are in a raid group
L.showinraid                      = "Symbol buttons anzeigen im Raid";
L.showinraiddesc                  = "Symbol buttons anzeigen im Raid";
-- shows bananabar buttons when you are in a normal party 
L.showinparty                     = "Symbol Buttons anzeigen in Gruppe";
L.showinpartydesc                 = "Symbol Buttons anzeigen in Gruppe";
-- shows bananabar buttons when you are in a normal party 
L.showoutofgroup                  = "Symbol button anzeigen wenn alleine unterwegs";
L.showoutofgroupdesc              = "Symbol button anzeigen wenn alleine unterwegs";

-- shows or hides the raid info panel (this panel is only shown when you are in a raid
L.showraidinfo                    = "RaidInfoPanel anzeigen im Raid";
L.showraidinfodesc                = "RaidInfoPanel anzeigen im Raid. Ausserhalb einer Raid Gruppe ist das RaidInfo Panel niemals sichtbar";

-- Shows mob name and health bar next to the raid symbol buttons
L.showextrainfo             	  = "Zeige Mobnamen und Lebensbalken neben den Buttons";
L.showextrainfodesc               = "Zeigt den Mobnamen und einen Lebensbalken rechts neben den Buttons";

