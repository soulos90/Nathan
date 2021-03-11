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


function JukeboxBackground:Constructor()
	Turbine.UI.Lotro.Window.Constructor( self );
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
    local d = FinishedInputSave(result, message);
	PatchDataSave( a,b,c,d );
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
		
		JukeboxBackground:Communicate();
	end
end

ChatListener = function(sender, args)
	if (args.ChatType==Turbine.ChatType.Say) or (args.ChatType==Turbine.ChatType.Tell) or (args.ChatType==Turbine.ChatType.Fellowship) or (args.ChatType==Turbine.ChatType.Raid) then
		local commandText = {};
		local numCommands = 1;
        Turbine.Shell.WriteLine("chat was read");
        local tempstring = args.Message;
        for w in string.gfind(tempstring, "!JB%(.-%)") do
            w = string.gsub(w, "!JB%( *", "");
            w = string.gsub(w, "%)", "");
            table.insert(commandText,w);
        end
        for i,v in ipairs(commandText) do
            Turbine.Shell.WriteLine(i .. v);
        end
        if(#commandText ~= 0) then
            for i,v in ipairs(commandText) do
                for e,x in ipairs(CommandsRef) do
                    j,k = string.find(v:lower(), x["Command"]);
                    if(j==1) then
                        local func = x["func"];
                        local details = string.sub(v, k + 1);
                        func(JukeboxBackground,details);
                    end
                end
            end
        end
	end
end

--"request", "upvote", "downvote", "ready", "useinstrument", "playpart", "broken", "preference"
function JukeboxBackground:PCRT(details)
    Turbine.Shell.WriteLine("PCRT" .. details);
end

function JukeboxBackground:PCUE(details)
    Turbine.Shell.WriteLine("PCUE" .. details);
end

function JukeboxBackground:PCDE(details)
    Turbine.Shell.WriteLine("PCDE" .. details);
end

function JukeboxBackground:PCRY(details)
    Turbine.Shell.WriteLine("PCRY" .. details);
end

function JukeboxBackground:PCUI(details)
    Turbine.Shell.WriteLine("PCUI" .. details);
end

function JukeboxBackground:PCPP(details)
    Turbine.Shell.WriteLine("PCPP" .. details);
end

function JukeboxBackground:PCBN(details)
    Turbine.Shell.WriteLine("PCBN" .. details);
end

function JukeboxBackground:PCPE(details)
    Turbine.Shell.WriteLine("PCPE" .. details);
end

function JukeboxBackground:Communicate()
    Turbine.Shell.WriteLine("Hi Im Communicate");
	SaveDone = false;
	LoadDone = false;
	self:PatchDataLoad( Turbine.DataScope.Account, "JukeBoxSync" .. LookingFor, FinishedSyncLoad(result, message));
	self:PatchDataSave( Turbine.DataScope.Account, "JukeBoxInput" .. inputID, InputDB, FinishedInputSave(result, message));
	inputID = (inputID + 1) % 1000;
end

function FinishedSyncLoad(result, message)
    Turbine.Shell.WriteLine("Hi Im FinishedSyncLoad");
	if ( result ) then
        Turbine.Shell.WriteLine("Hi Im FinishedSyncLoad with true result");
		if IsTidy(message) then
			ProcessSync(message);
			LookingFor = (LookingFor + 1) % 1000;
			InputDB.LookingFor = LookingFor;
			PatchDataLoad( Turbine.DataScope.Account, "JukeBoxSync" .. LookingFor, FinishedSyncLoad(result, message));
		else
			FinishedCommunicate(2);
        end
	else
		Turbine.Shell.WriteLine( "<rgb=#FF0000> sync not found</rgb>" );
		FinishedCommunicate(2);
	end
end

function FinishedInputSave(result, message)
	if ( result ) then
		Turbine.Shell.WriteLine( "<rgb=#00FF00> input saved </rgb>");
	else
		Turbine.Shell.WriteLine( "<rgb=#FF0000> input not saved</rgb>" );
	end
	FinishedCommunicate(1);
end

function FinishedCommunicate(sender)
	if(sender == 1) then
		SaveDone = true;
	else
		LoadDone = true;
	end
	if(SaveDone and LoadDone) then
		previousGameTime = Turbine.Engine.GetGameTime();
		Self:SetWantsUpdates(true);
		if(TimeToLoadSongs) then
			LoadSongs();
		end
	end
end

function FinishedSongLoad(result, message)
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

function ProcessSync(data)
	SyncDB = data;
	if(data.LoadSongs) then
		TimeToLoadSongs = true;
	end
	for i,v in ipairs(SyncDB.Commands) do 
        CommandSwitch(v); 
    end
end

function LoadSongs()
    PatchDataLoad( Turbine.DataScope.Account , "JukeBoxData", FinishedSongLoad);
    Turbine.Shell.WriteLine("LoadSongs");
end

function CommandSwitch(command)
	
end

function IsTidy(data)
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