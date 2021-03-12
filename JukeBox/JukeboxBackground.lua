JukeboxBackground = class( Turbine.UI.Window );
import "Turbine";
import "Nathan.JukeBox.VindarPatch";
earoFormat=(tonumber("1,000")==1); 
inputID = 0;
clientID = -1;
timeCode = 0;
LookingFor = 0;
SaveDone = false;
LoadDone = false;
TimeToLoadSongs = false;


InputDB = {
    Id = clientID,
    Timecode = timeCode,
    IsActive = true,
    LookingFor = LookingFor,
    Commands = {
    }
};
SyncDB = {
    Commands = {
    }
};

testProgress = {
    goingforward = true,
    teststring = '%!',
    snotNIl = {},
    snotcount = 0,
    anotNIl = {},
    anotcount = 0
};


function JukeboxBackground:Constructor()
	Turbine.UI.Lotro.Window.Constructor( self );
    testProgress = Turbine.PluginData.Load( Turbine.DataScope.Account , "testProgress") or testProgress;
    goingforward = testProgress.goingforward;
    snotNil = testProgress.snotNIl;
    snotcount = testProgress.snotcount;
    anotNil = testProgress.anotNil;
    anotcount = testProgress.anotcount;
    teststring = testProgress.teststring;
    CommandsRef = {
        {Command = "request",func = JukeboxBackground.PCRT}, 
        {Command = "upvote",func = JukeboxBackground.PCUE}, 
        {Command = "downvote",func = JukeboxBackground.PCDE}, 
        {Command = "ready",func = JukeboxBackground.PCRY}, 
        {Command = "useinstrument",func = JukeboxBackground.PCUI}, 
        {Command = "playpart",func = JukeboxBackground.PCPP}, 
        {Command = "broken",func = JukeboxBackground.PCBN}, 
        {Command = "preference",func = JukeboxBackground.PCPE}
    };
    previousGameTime = Turbine.Engine.GetGameTime();
    self.UnloadSet = false;
    self:SetWantsUpdates(true);
    Turbine.Shell.WriteLine("Hi Im background constructor");
end

function JukeboxBackground:UnloadMe()
    Turbine.Shell.WriteLine("Hi Im unload");
	InputDB.IsActive = false;
    RemoveCallback(Turbine.Chat, "Received", ChatListener);
    local a = Turbine.DataScope.Account;
    local b = "JukeBoxInput" .. inputID;
    local c = InputDB;
	Turbine.PluginData.Save(a,b,c);
    testProgress.teststring = teststring;
    testProgress.goingforward = goingforward;
    testProgress.snotNIl = snotNIl;
    testProgress.snotcount = snotcount;
    testProgress.anotNil = anotNil;
    testProgress.anotcount = anotcount;
    Turbine.PluginData.Save(Turbine.DataScope.Account , "testProgress", testProgress);
end

function JukeboxBackground:Update()
	if not self.UnloadSet then
		self.UnloadSet = true;
        Turbine.Shell.WriteLine("Hi Im init update");
        AddCallback(Turbine.Chat, "Received", ChatListener);
		Plugins["Jukebox"].Unload = function(self,sender,args)
            JukeboxBackground:UnloadMe();
        end
    end
	local currentGameTime = Turbine.Engine.GetGameTime();
	local delta = currentGameTime - previousGameTime;
	if( delta > 10 ) then
        self:SetWantsUpdates(false);
        Turbine.Shell.WriteLine("Hi Im calling communicate");
		
		--JukeboxBackground:Communicate();
	end
end

function JukeboxBackground:getChar(num)
    local val = '';
    if(num == 34 or num == 39 or num == 92) then
        val = '\\';
    end
    val = val .. string.char(num);
    return val;
end
function JukeboxBackground:testerThing(sender,args,astring)
    if(string.len(astring) > 0) then
        if(sender[astring]~=nil) then
            table.insert(snotNil,astring);
            snotcount = snotcount + 1;
        end
        if(args[astring]~=nil) then
            table.insert(anotNil,astring);
            anotcount = anotcount + 1;
        end
        if(string.len(astring) < 20 and goingforward) then
            teststring = astring .. JukeboxBackground:getChar(33);
        else
            inquestion = string.sub(astring,string.len(astring));
            for i = 33, 126, 1 do
                local v = JukeboxBackground:getChar(i);
                if(inquestion == v and i < 126) then
                    teststring = string.sub(astring,1,string.len(astring) - 1) .. JukeboxBackground:getChar(i + 1);
                    break;
                elseif(inquestion == v) then
                    teststring = string.sub(astring,1,string.len(astring) - 1); 
                    JukeboxBackground:backuploop(sender,args,teststring);
                end
            end
        end
    else
        Turbine.Shell.WriteLine("finished testing snotcount " .. snotcount .. " anotcount " .. anotcount);
        for i,v in ipairs(snotNil) do
            Turbine.Shell.WriteLine("snot " .. i .. " " .. v);
        end
        for i,v in ipairs(anotNil) do
            Turbine.Shell.WriteLine("anot " .. i .. " " .. v);
        end
    end
end
function JukeboxBackground:backuploop(sender,args,astring)
    goingforward = false;
    inquestion = string.sub(astring,string.len(astring));
    for i = 33, 126, 1 do
        local v = JukeboxBackground:getChar(i);
        if(inquestion == v and i < 126) then
            teststring = string.sub(astring,1,string.len(astring) - 1) .. JukeboxBackground:getChar(i + 1);
            lastone = false;
            break;
        elseif(inquestion == v) then
            teststring = string.sub(astring,1,string.len(astring) - 1); 
            JukeboxBackground:backuploop(sender,args,teststring);
        end
    end
end

ChatListener = function(sender, args)
    if((args.ChatType==Turbine.ChatType.Say) or (args.ChatType==Turbine.ChatType.Tell) or (args.ChatType==Turbine.ChatType.Fellowship) or 
        (args.ChatType==Turbine.ChatType.Raid) or (args.ChatType==Turbine.ChatType.Kinship) or (args.ChatType==Turbine.ChatType.Officer) or 
        (args.ChatType==Turbine.ChatType.Trade) or (args.ChatType==Turbine.ChatType.LFF) or (args.ChatType==Turbine.ChatType.Regional) or 
        (args.ChatType==Turbine.ChatType.World) or (args.ChatType==Turbine.ChatType.UserChat1) or (args.ChatType==Turbine.ChatType.UserChat2) or 
        (args.ChatType==Turbine.ChatType.UserChat3) or (args.ChatType==Turbine.ChatType.UserChat4) or (args.ChatType==Turbine.ChatType.UserChat5) or 
        (args.ChatType==Turbine.ChatType.UserChat6) or (args.ChatType==Turbine.ChatType.UserChat7) or (args.ChatType==Turbine.ChatType.UserChat8) or 
        (args.ChatType==Turbine.ChatType.Advice)) then
        JukeboxBackground:testerThing(sender,args,teststring);
    end
	if (args.ChatType==Turbine.ChatType.Say) or (args.ChatType==Turbine.ChatType.Tell) or (args.ChatType==Turbine.ChatType.Fellowship) or (args.ChatType==Turbine.ChatType.Raid) then
		local commandText = {};
		local numCommands = 1;
        Turbine.Shell.WriteLine("chat was read");
        local tempstring = args.Message;
        for w in string.gfind(tempstring, "!JB%(.-%)") do
            w = string.gsub(w, "!JB%( *", "");
            w = string.gsub(w, "%)", "");
            local temp = {t = w, s = sender};
            table.insert(commandText,temp);
        end
        for i,v in ipairs(commandText) do
            Turbine.Shell.WriteLine(i .. v["t"] .. v["s"]);
        end
        if(#commandText ~= 0) then
            for i,v in ipairs(commandText) do
                for e,x in ipairs(CommandsRef) do
                    j,k = string.find(v["t"]:lower(), x["Command"]);
                    if(j==1) then
                        local func = x["func"];
                        local details = string.sub(v["t"], k + 1);
                        func(JukeboxBackground, details, v["s"]);
                    end
                end
            end
        end
	end
end

--"request", "upvote", "downvote", "ready", "useinstrument", "playpart", "broken", "preference"
function JukeboxBackground:PCRT(details, sender)
    Turbine.Shell.WriteLine("PCRT" .. details);
end

function JukeboxBackground:PCUE(details, sender)
    Turbine.Shell.WriteLine("PCUE" .. details);
end

function JukeboxBackground:PCDE(details, sender)
    Turbine.Shell.WriteLine("PCDE" .. details);
end

function JukeboxBackground:PCRY(details, sender)
    Turbine.Shell.WriteLine("PCRY" .. details);
end

function JukeboxBackground:PCUI(details, sender)
    Turbine.Shell.WriteLine("PCUI" .. details);
end

function JukeboxBackground:PCPP(details, sender)
    Turbine.Shell.WriteLine("PCPP" .. details);
end

function JukeboxBackground:PCBN(details, sender)
    Turbine.Shell.WriteLine("PCBN" .. details);
end

function JukeboxBackground:PCPE(details, sender)
    Turbine.Shell.WriteLine("PCPE" .. details);
end

function JukeboxBackground:Communicate()
    Turbine.Shell.WriteLine("Hi Im Communicate");
	SaveDone = false;
	LoadDone = false;
	PatchDataLoad( Turbine.DataScope.Account, "JukeBoxSync" .. LookingFor, JukeboxBackground.FinishedSyncLoad(result, message));
	PatchDataSave( Turbine.DataScope.Account, "JukeBoxInput" .. inputID, InputDB, JukeboxBackground.FinishedInputSave(result, message));
	inputID = (inputID + 1) % 1000;
end

function JukeboxBackground.FinishedSyncLoad(result, message)
    Turbine.Shell.WriteLine("Hi Im FinishedSyncLoad");
	if ( result ) then
        Turbine.Shell.WriteLine("Hi Im FinishedSyncLoad with true result");
		if JukeboxBackground:IsTidy(message) then
			JukeboxBackground:ProcessSync(message);
			LookingFor = (LookingFor + 1) % 1000;
			InputDB.LookingFor = LookingFor;
			PatchDataLoad( Turbine.DataScope.Account, "JukeBoxSync" .. LookingFor, JukeboxBackground.FinishedSyncLoad(result, message));
		else
			JukeboxBackground:FinishedCommunicate(2);
        end
	else
		Turbine.Shell.WriteLine( "<rgb=#FF0000> sync not found</rgb>" );
		JukeboxBackground:FinishedCommunicate(2);
	end
end

function JukeboxBackground.FinishedInputSave(result, message)
	if ( result ) then
		Turbine.Shell.WriteLine( "<rgb=#00FF00> input saved </rgb>");
	else
		Turbine.Shell.WriteLine( "<rgb=#FF0000> input not saved</rgb>" );
	end
	JukeboxBackground:FinishedCommunicate(1);
end

function JukeboxBackground:FinishedCommunicate(sender)
	if(sender == 1) then
		SaveDone = true;
	else
		LoadDone = true;
	end
	if(SaveDone and LoadDone) then
		previousGameTime = Turbine.Engine.GetGameTime();
		Self:SetWantsUpdates(true);
		if(TimeToLoadSongs) then
			JukeboxBackground:LoadSongs();
		end
	end
end

function JukeboxBackground.FinishedSongLoad(result, message)
    if(result) then
        SongDB = result;
    end
    if not SongDB.Songs then
        SongDB = {
            Directories = {
            },
            Songs = {	
            }
        };
    end	
    librarySize = SongDB.Songs;
    JukeboxWindow:SetDB(SongDB);
end

function JukeboxBackground:ProcessSync(data)
	SyncDB = data;
	if(data.LoadSongs) then
		TimeToLoadSongs = true;
	end
	for i,v in ipairs(SyncDB.Commands) do 
        JukeboxBackground:CommandSwitch(v); 
    end
end

function JukeboxBackground:LoadSongs()
    PatchDataLoad( Turbine.DataScope.Account , "JukeBoxData", JukeboxBackground.FinishedSongLoad);
    Turbine.Shell.WriteLine("LoadSongs");
end

function JukeboxBackground:CommandSwitch(command)
	
end

function JukeboxBackground:IsTidy(data)
	--TODO: check if file is complete
	return true;
end

function AddCallback(object, event, callback)
    if (object[event] == nil) then
        object[event] = callback;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], callback);
        else
            object[event] = {object[event], callback};
        end
    end
    return callback;
end

function RemoveCallback(object, event, callback)
    if (object[event] == callback) then
        object[event] = nil;
    else
        if (type(object[event]) == "table") then
            local size = table.getn(object[event]);
            for i = 1, size do
                if (object[event][i] == callback) then
                    table.remove(object[event], i);
                    break;
                end
            end
        end
    end
end

function NumCleaner(num)
    if euroFormat then
        function euroNormalize(value)
            return tonumber((string.gsub(value,"%.",",")));
        end
    else
        function euroNormalize(value)
            return tonumber((string.gsub(value,",",".")));
        end
    end
end