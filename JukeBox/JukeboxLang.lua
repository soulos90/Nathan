lang = "en";
Strings = {};

if (Turbine.Shell.IsCommand("spielen")) then
	lang = "de";
end
if (Turbine.Shell.IsCommand("lire")) then
	lang = "fr";
end

if (lang == "en") then 
	Strings["cmd_music"] = "/music";
	Strings["cmd_play"] = "/play";
	Strings["cmd_ready"] = "/readycheck";
	Strings["cmd_start"] = "/playstart";
	Strings["cmd_sync"] = "sync";
	Strings["cmd_demo1_title"] = "Now playing";
	Strings["cmd_demo1_cmd"] = "/e is now playing %name";
	Strings["cmd_demo2_title"] = "Sync command to /f";
	Strings["cmd_demo2_cmd"] = "/f /play %file sync %part";
	Strings["cmd_demo3_title"] = "Paste filename";
	Strings["cmd_demo3_cmd"] = "/f %file";
	Strings["ui_dirs"] = "Directories";
	Strings["ui_songs"] = "Songs";
	Strings["ui_parts"] = "Parts";
	Strings["ui_cmds"] = "Commands";
	Strings["ui_settings"] = "Settings";
	Strings["ui_search"] = "Search";
	Strings["ui_clear"] = "Clear";
	Strings["ui_general"] = "General settings";
	Strings["ui_custom"] = "Custom commands";
	Strings["ui_save"] = "Save";
	Strings["ui_ok"] = "Ok";
	Strings["ui_cancel"] = "Cancel";
	Strings["ui_icon"] = "Jukebox button settings";
	Strings["ui_instr"] = "Instrument slots settings";		
	Strings["cb_parts"] = "Song part list visible";
	Strings["cb_search"] = "Search enabled";
	Strings["cb_desc"] = "Show description in song list";
	Strings["cb_descfirst"] = "Show description first";
	Strings["cb_windowvis"] = "Window visible on load";
	Strings["cb_iconvis"] = "Jukebox button visible";
	Strings["cb_instrvis"] = "Instrument slots visible";
	Strings["ui_btn_opacity"] = "Jukebox button opacity";
	Strings["ui_clr_slots"]	= "Clear slots";
	Strings["ui_add_slot"]	= "Add";
	Strings["ui_del_slot"]	= "Remove";
	Strings["ui_cus_add"] = "Add";
	Strings["ui_cus_edit"] = "Edit";
	Strings["ui_cus_del"] = "Remove";
	Strings["ui_cus_winadd"] = "Add Command";
	Strings["ui_cus_winedit"] = "Edit Command";
	Strings["ui_cus_title"] = "Title:";
	Strings["ui_cus_command"] = "Command:";	
	Strings["ui_cus_help"] = "Command aliases:\n\n%name - song/part name\n%file - filename\n%part - part number";
	Strings["ui_cus_err"] = "Please enter Title and Command";
	Strings["tt_music"] = "Toggle music mode";
	Strings["tt_play"] = "Play song";
	Strings["tt_ready"] = "Make a ready check";
	Strings["tt_sync"] = "Play with sync";
	Strings["tt_start"] = "Start sync play";
	Strings["tt_parts"] = "Parts display on/off";
	Strings["sh_saved"] = "Jukebox settings saved.";
	Strings["sh_notsaved"] = "Jukebox failed to save settings";
	Strings["sh_show"] = "show";
	Strings["sh_hide"] = "hide";
	Strings["sh_toggle"] = "toggle";
	Strings["sh_help1"] = "Jukebox show: Display Jukebox Window";
	Strings["sh_help2"] = "Jukebox hide: Hide Jukebox Window";
	Strings["sh_help3"] = "Jukebox toggle: Toggle Jukebox Window";	
	Strings["err_nosongs"] = "The song library is empty. Make sure you have abc files in your Music directory and run the Jukebox.hta file to build the library. Then, reload the plugin.\n\nIf you upgraded from a previous version, run first the new Jukebox.hta before loading the plugin.";
elseif (lang == "de") then
	Strings["cmd_music"] = "/musik";
	Strings["cmd_play"]  = "/spielen";
	Strings["cmd_ready"] = "/bereitschaftspr\195\188fung";
	Strings["cmd_start"] = "/spielstart";
	Strings["cmd_sync"] = "sync";	
	Strings["cmd_e"] = "/e";
	Strings["cmd_f"] = "/g";
	Strings["cmd_demo1_title"] = "Emote mit dem Liedtitel";
	Strings["cmd_demo1_cmd"] = "/e spielt %name";
	Strings["cmd_demo2_title"] = "Sync-Befehl an Gruppe senden";
	Strings["cmd_demo2_cmd"] = "/g /spielen %file sync %part";
	Strings["cmd_demo3_title"] = "Dateiname an Gruppe senden";
	Strings["cmd_demo3_cmd"] = "/g %file";	
	Strings["ui_dirs"] = "Verzeichnisse";
	Strings["ui_songs"] = "Lieder";
	Strings["ui_parts"] = "Teile";
	Strings["ui_cmds"] = "Befehle";	
	Strings["ui_settings"] = "Einstellungen";
	Strings["ui_search"] = "Suchen";
	Strings["ui_clear"] = "Leeren";
	Strings["ui_general"] = "Allgemeine Einstellungen";
	Strings["ui_custom"] = "Benutzerdefinierte Befehle";
	Strings["ui_save"] = "Speichern";
	Strings["ui_ok"] = "Ok";
	Strings["ui_cancel"] = "Abbrechen";		
	Strings["ui_icon"] = "Jukeboxknopf Einstellungen";
	Strings["ui_instr"] = "Instrumentenleiste Einstellungen";
	Strings["cb_parts"] = "Liste mit Liedteilen anzeigen";
	Strings["cb_search"] = "Suche erlauben";
	Strings["cb_desc"] = "Beschreibung in Liedliste anzeigen";
	Strings["cb_descfirst"] = "Show description first";
	Strings["cb_windowvis"] = "Fenster beim Start anzeigen";
	Strings["cb_iconvis"] = "Jukeboxknopf anzeigen";
	Strings["cb_instrvis"] = "Instrumentenleiste anzeigen";
	Strings["ui_btn_opacity"] = "Jukebox button opacity";	
	Strings["ui_clr_slots"]	= "Leiste leeren";
	Strings["ui_add_slot"]	= "Hinzuf\195\188gen";
	Strings["ui_del_slot"]	= "Entfernen";	
	Strings["ui_cus_add"] = "Hinzuf\195\188gen";
	Strings["ui_cus_edit"] = "Editieren";
	Strings["ui_cus_del"] = "Entfernen";
	Strings["ui_cus_winadd"] = "Befehl einf\195\188gen";
	Strings["ui_cus_winedit"] = "Befehl editieren";	
	Strings["ui_cus_title"] = "Titel:";
	Strings["ui_cus_command"] = "Befehl:";
	Strings["ui_cus_help"] = "Befehl aliase:\n\n%name - Lied/Liedteilname\n%file - Dateiname\n%part - Liedteilnummer";
	Strings["ui_cus_err"] = "Bitte Titel und Befehl eingeben";
	Strings["tt_music"] = "Musikmodusschalter";
	Strings["tt_play"] = "Lied abspielen";
	Strings["tt_ready"] = "Bereitschaftskontrolle";
	Strings["tt_sync"] = "Spielen mit sync";
	Strings["tt_start"] = "Spielstart";
	Strings["tt_parts"] = "Teile anzeigen an/aus";
	Strings["sh_saved"] = "Jukeboxeinstellungen gesichert.";
	Strings["sh_notsaved"] = "Jukebox konnte die Einstellungen nicht sichern";	
	Strings["sh_show"] = "anzeigen";
	Strings["sh_hide"] = "verstecken";
	Strings["sh_toggle"] = "umschalten";
	Strings["sh_help1"] = "Jukebox anzeigen: Jukeboxfenster anzeigen";
	Strings["sh_help2"] = "Jukebox verstecken: Jukeboxfenster verstecken";
	Strings["sh_help3"] = "Jukebox umschalten: Jukeboxfenster ein/aus";
	Strings["err_nosongs"] = "Keine Lieder gefunden. Du musst im '/music'-Ordner ABC-Dateien haben und mindestens einmal die Jukebox.hta ausf\195\188hren. Danach bitte Plugin neu laden.\n\nBei neuer Version des Plugins, starte die neue Jukebox.hta um die Datenbank neu zu erstellen.";
elseif (lang == "fr") then
	Strings["cmd_music"] = "/musique";
	Strings["cmd_play"]  = "/lire";
	Strings["cmd_ready"] = "/voirpr??t";
	Strings["cmd_start"] = "/d??butmusique";
	Strings["cmd_sync"] = "synchro";	
	Strings["cmd_e"] = "/e";
	Strings["cmd_f"] = "/f";
	Strings["cmd_demo1_title"] = "Jou\195\169 actuellement";
	Strings["cmd_demo1_cmd"] = "/e joue actuellement %name";
	Strings["cmd_demo2_title"] = "Commande synchro vers /comm";
	Strings["cmd_demo2_cmd"] = "/comm /lire %file sync %part";
	Strings["cmd_demo3_title"] = "Coller nom du fichier";
	Strings["cmd_demo3_cmd"] = "/comm %file";	
	Strings["ui_dirs"] = "R\195\169pertoires";
	Strings["ui_songs"] = "Chansons";
	Strings["ui_parts"] = "Partitions";
	Strings["ui_cmds"] = "Commandes";	
	Strings["ui_settings"] = "Param\195\168tres";
	Strings["ui_search"] = "Recherche";	
	Strings["ui_clear"] = "Vider";
	Strings["ui_general"] = "Param\195\168tres G\195\169n\195\169raux";
	Strings["ui_custom"] = "Commandes Perso";
	Strings["ui_save"] = "Sauver";
	Strings["ui_ok"] = "Ok";
	Strings["ui_cancel"] = "Annuler";		
	Strings["ui_icon"] = "Param\195\168tres Bouton Jukebox";
	Strings["ui_instr"] = "Instrument slots settings";		
	Strings["cb_parts"] = "Liste Partitions Visible";
	Strings["cb_search"] = "Recherche activ\195\169e";
	Strings["cb_desc"] = "Show description in song list";
	Strings["cb_descfirst"] = "Show description first";
	Strings["cb_windowvis"] = "Fen\195\170tre visible au chargement";
	Strings["cb_iconvis"] = "Bouton Jukebox visible";
	Strings["cb_instrvis"] = "Instrument slots visible";	
	Strings["ui_btn_opacity"] = "Jukebox button opacity";	
	Strings["ui_clr_slots"]	= "Clear slots";
	Strings["ui_add_slot"]	= "Ajouter";
	Strings["ui_del_slot"]	= "Retirer";	
	Strings["ui_cus_add"] = "Ajouter";
	Strings["ui_cus_edit"] = "Editer";
	Strings["ui_cus_del"] = "Retirer";
	Strings["ui_cus_winadd"] = "Ajouter Commande";
	Strings["ui_cus_winedit"] = "Editer Commande";	
	Strings["ui_cus_title"] = "Nom:";
	Strings["ui_cus_command"] = "Commande:";
	Strings["ui_cus_help"] = "Variables de commande:\n\n%name - Nom du morceau\n%file - Fichier\n%part - Num\195\169ro de la partition";
	Strings["ui_cus_err"] = "Veuillez entrer un Nom et une Commande";
	Strings["tt_music"] = "Passe en mode Musique";
	Strings["tt_play"] = "Jouer la chanson";
	Strings["tt_ready"] = "Faire un appel";
	Strings["tt_sync"] = "Jouer en mode Synchro";
	Strings["tt_start"] = "D\195\169buter le jeu synchro";
	Strings["tt_parts"] = "Montrer/Cacher les partitions";
	Strings["sh_saved"] = "Param\195\168tres Jukebox sauvegard\195\169s";
	Strings["sh_notsaved"] = "Echec de la sauvegarde des param\195\168tres de Jukebox";	
	Strings["sh_show"] = "afficher";
	Strings["sh_hide"] = "cacher";
	Strings["sh_toggle"] = "basculer";
	Strings["sh_help1"] = "Jukebox afficher: Afficher l'interface de Jukebox";
	Strings["sh_help2"] = "Jukebox cacher: Cacher l'interface de Jukebox";
	Strings["sh_help3"] = "Jukebox basculer: Basculer entre visible et cach\195\169";
	Strings["err_nosongs"] = "Le livre de chansons est vide. V\195\169rifiez que vous avez des fichiers pr\195\169sents dans le r\195\169pertoire \music et executer le fichier Jukebox.hta (pr\195\169sent dans le r\195\169pertoire du plugin) pour g\195\169n\195\169rer la liste des chansons. Ensuite, recharger le plugin. \n\n Si vous avez mis \195\160 jour depuis une version pr\195\169c\195\169dente, ex\195\169cuter en premier le Jukebox.hta avant de charger le plugin.";
end