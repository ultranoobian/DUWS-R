diag_log format ["------------------ DUWS-R START ----v0------ player: %1", profileName];


if (isDedicated) exitWith {};
waitUntil {!isNull player};

player allowDamage false;

persistent_stat_script_init = [] execVM "persistent\persistent_stats_init.sqf";
waitUntil {scriptDone persistent_stat_script_init};
execvm "dynamic_music\dyn_music_init.sqf";


#include "dialog\supports_init.hpp"
#include "dialog\squad_number_init.hpp"

if (hasInterface) then { execVM "misc\gps_marker.sqf";};
if (!isMultiplayer) then {
	getsize_script = [player] execVM "mapsize.sqf";
};

// IF MP
if (isMultiplayer) then {

	// Get the variables from the parameters lobby
	_revive_activated = ["Revive", 1] call BIS_fnc_getParamValue;
	DUWSMP_CP_death_cost = ["DeathPenalty", 1] call BIS_fnc_getParamValue;
    staminaEnabled = ["Stamina", 0] call BIS_fnc_getParamValue;

    if(staminaEnabled == 0) then {
        staminaEnabled = false;
    } else {
        staminaEnabled = true;
    };

    if (support_armory_available) then {
        hq_blu1 addaction ["<t color='#ff0066'>Armory (VA)</t>","bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
        {
            _x addaction ["<t color='#ff0066'>Armory (VA)</t>","bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
        } forEach (Array_of_FOBS);
    };

	if (_revive_activated == 1) then {execVM "duws_revive\reviveInit.sqf"};
	PlayerKilledEH = player addEventHandler ["killed", {
        commandpointsblu1 = commandpointsblu1 - DUWSMP_CP_death_cost;
        publicVariable "commandpointsblu1";
    }];
	"support_specialized_training_available" addPublicVariableEventHandler {lbSetColor [2103, 11, [0, 1, 0, 1]];};
    "support_armory_available" addPublicVariableEventHandler {
        hq_blu1 addaction ["<t color='#ff0066'>Armory (VA)</t>","bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
        {
            _x addaction ["<t color='#ff0066'>Armory (VA)</t>","bisArsenal.sqf", "", 0, true, true, "", "_this == player"];
        } forEach (Array_of_FOBS);
        lbSetColor [2103, 5, [0, 1, 0, 1]];
    };

    // change the shown CP for request dialog
    "commandpointsblu1" addPublicVariableEventHandler {ctrlSetText [1000, format["%1",commandpointsblu1]]; };

	// each time there is a new FOB
	"Array_of_FOBS" addPublicVariableEventHandler {
        if (!fobSwitch) then {
            [] execVM "support\FOBreceiveaction.sqf";
        };
		fobSwitch = false;
		//Add the FoB to the list of revive locations.
		_fobAmount = count Array_of_FOBS;
		_fobIndex = _fobAmount - 1;
		_createdFOB = Array_of_FOBS select _fobIndex;

		[missionNamespace, _createdFOB] call BIS_fnc_addRespawnPosition;
	};

	if (!isServer) then {
        "savegameNumber" addPublicVariableEventHandler {[] execVM "savegameClient.sqf";};
	};
	if (!isServer) then {
        "capturedZonesNumber" addPublicVariableEventHandler {[] execVM "persistent\persistent_stats_zones_add.sqf";}; // change the shown CP for request dialog
	};
	if (!isServer) then {
        "finishedMissionsNumber" addPublicVariableEventHandler {[] execVM "persistent\persistent_stats_missions_total.sqf";}; // change the shown CP for request dialog
	};

	player globalChat format ["gamemaster: %1", game_master];
	player globalChat format ["HQ_pos_found_generated: %1", HQ_pos_found_generated];

	if (!isDedicated && !HQ_pos_found_generated) then { // SERVER INIT
		if (((vehiclevarname player) in game_master)) then {
			DUWS_host_start = false;
			publicVariable "DUWS_host_start";
			waitUntil {time > 0.1};
			getsize_script = [player] execVM "mapsize.sqf";
			DUWS_host_start = true;
			publicVariable "DUWS_host_start";

			// init High Command
			_handle = [] execVM "dialog\hc_init.sqf";
			waitUntil {scriptDone getsize_script};
		};
	};
};

player globalChat format ["gamemaster: %1", game_master];
player globalChat format ["HQ_pos_found_generated: %1", HQ_pos_found_generated];

if (!isDedicated && !HQ_pos_found_generated) then { // SERVER INIT
    if (((vehiclevarname player) in game_master)) then {
        DUWS_host_start = false;
        publicVariable "DUWS_host_start";
        waitUntil {time > 0.1};
        getsize_script = [player] execVM "mapsize.sqf";
        DUWS_host_start = true;
        publicVariable "DUWS_host_start";

        // init High Command
        _handle = [] execVM "dialog\hc_init.sqf";
        waitUntil {scriptDone getsize_script};
    };
};

if (!isDedicated && !HQ_pos_found_generated) then {
    if (((vehiclevarname player) in game_master)) then {
        _null = [] execVM "dialog\startup\hq_placement\placement.sqf";
        waitUntil {chosen_hq_placement};
        player globalChat format ["hq_manually_placed: %1", hq_manually_placed];
        player globalChat format ["player_is_choosing_hqpos: %1", player_is_choosing_hqpos];
        // create random HQ
        if (!hq_manually_placed && !player_is_choosing_hqpos) then {
            player globalChat "lance recherche position...";
            hq_create = [20, 0.015] execVM "initHQ\locatorHQ.sqf";
            waitUntil {scriptDone hq_create};
        };
    };
};

if (hasInterface) then {
    // WHEN CLIENT CONNECTS INIT (might need sleep)
    waitUntil {isPlayer Player};
    hintsilent "Waiting for the host to find an HQ...";
    waitUntil {HQ_pos_found_generated && time > 0.1};
    player setpos [(getpos hq_blu1 select 0),(getpos hq_blu1 select 1)+10];
    _drawicon = [] execVM "inithq\drawIcon.sqf";
    hintsilent "Waiting for the host to select the campaign parameters...";
    waitUntil {chosen_settings};
    [hq_blu1] execVM "initHQ\HQaddactions.sqf";
    sleep 1;
    player setdamage 0;
    player allowDamage true;
    hintsilent format["Joined game, welcome to %1, %2",worldName,profileName];

    // init High Command
    _handle = [] execVM "dialog\hc_init.sqf";
    [] execVM "dialog\startup\weather_client.sqf";

    if(!staminaEnabled) then {
        player enableStamina false;
    };
};

if (!isMultiplayer) then {
    _handle = [] execVM "dialog\hc_init.sqf";
};

// INIT the operative listexecVM "misc\gameHelp.sqf";
execVM "dialog\operative\operator_init.sqf";

// Create help for DUWS
execVM "misc\gameHelp.sqf";

// create mission victory script //SPAWN BEGIN
[] spawn {

    // CREATE MAIN OBJECTIVE
    capture_island_obj = player createSimpleTask ["taskIsland"];
    capture_island_obj setSimpleTaskDescription ["The ennemy is controlling the island, we must take it back! Capture every zone under enemy control and the mission will succeed.<br />You can let your BLUFOR forces take the island by themselves and help them getting a bigger army by accomplishing side missions. Or you can capture the zones yourself and do all the big work. As the campaign progress, the war will escalate and the armies will get stronger and start to use bigger guns.<br />To capture a zone, you need to have more units inside the zone than the enemy.<br /><br />It's up to you on how you want to play this.<br />Good luck, soldier!","Take the island",""];

    // WAIT UNTIL ALL ZONES ARE CAPTURED
    waitUntil {sleep 1; amount_zones_created > 0};
    waitUntil {sleep 3; (zoneundercontrolblu >= amount_zones_created);}; // Toutes les zones sont capturées
    persistent_stat_script_win = [] execVM "persistent\persistent_stats_win.sqf";
    ["TaskSucceeded",["","Island captured!"]] call bis_fnc_showNotification;
    capture_island_obj setTaskState "Succeeded";
    sleep 3;
    ["island_captured_win",true,true] call BIS_fnc_endMission;
};



if (mission_DUWS_firstlaunch) then {
    waitUntil {chosen_settings};
    sleep 8;
    ["info",["Buying troops","Go talk to your commander to buy troops and vehicles with CP"]] call bis_fnc_showNotification;
    sleep 2.5;
    ["info",["Command points","Acquire more CP by capturing enemy areas or accomplishing side missions"]] call bis_fnc_showNotification;

    sleep 15;
    ["info",["RESTING AND HEALING","Save the game and heal by resting at the base"]] call bis_fnc_showNotification;

    sleep 15;
    // SITREP
    ["sitrepinfo",["SITREP","You can also save the game by giving a SITREP"]] call bis_fnc_showNotification;

    sleep 20;
    ["info",["DUWS Manual","Check the manual in the briefing for more info"]] call bis_fnc_showNotification;

    profileNamespace setVariable ["profile_DUWS_firstlaunch", false];
    saveProfileNamespace;
};

//Cleanup unused players.
for[{_x = 2},{_x <= 20},{_x = _x + 1}] do {
    _thePlayer = missionNamespace getVariable format["player%1", _x];
    if(!isNil("_thePlayer")) then {
        if(!isPlayer _thePlayer) then {
            deleteVehicle _thePlayer;
        };
    };
};

//Loading player position and gear.
//TODO: Add bought supports.
/*
if(isServer) then
{
	execVM "persistent\missionSpecific\saveFuncs.sqf";
	waitUntil {!isNil "saveFuncsLoaded"};

	execVM "persistent\missionSpecific\loadAccount.sqf";
};
*/
