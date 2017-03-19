diag_log "dialog\gameHelp.sqf: Started";

_index = player createDiarySubject ["help","DUWS-R Manual"];
player createDiaryRecord ["help", ["Feedback/bug report", "Internal team members: Use the ""issues"" section to report items."]];
player createDiaryRecord ["help", ["Export to another island", "<font color='#FF0000'>How to export to another island:</font color><br />You just need to take the .pbo file and rename it with the name of the island you want to export the mission to. You don't have anything else to do<br /><br />Example:<br />SP_DUWS-R.stratis.pbo >>> SP_DUWS-R.chernarus.pbo"]];
player createDiaryRecord ["help", ["Credits", "Many thanks goes out to everyone that worked on the original DUWS by kibot!"]];
player createDiaryRecord ["help", ["Command Points (CP)", "Command points are used to purchase vehicles, units and ask for support (like artillery or save the game outside the base). To obtain Command points, you must capture the enemy controlled zones (red zones on the map) or execute side missions. You also receive 3 command points for each zone you have under your control every 30 minutes."]];
player createDiaryRecord ["help", ["Army Power (AP)", "Army power represent the strenght of the BLUFOR forces present on the island. By capturing enemy positions and accomplishing side missions, you will add Army Power to your army. The attack waves of the BLUFOR army will become stronger."]];
player createDiaryRecord ["help", ["Experience", "By accomplishing side missions, capturing zones and islands, you will increase your experience. With experience, you will automatically unlock new abilties. Once you have an ability, a description of this ability will be available in the 'ability' tab in the briefing.<br />Capturing an island gives you <font color='#FF0000'>5 XP</font color><br />Achieving a side mission: <font color='#FF0000'>2 XP</font color><br />Capturing a zone: <font color='#FF0000'>1 XP</font color>"]];
player createDiaryRecord ["help", ["Saving the game", "You can save the game by resting at the base. Just go near the officer and select the action ""Rest"". Note that 6 hours will ellapse during that time. You can also save at any time by giving a SITREP in the support menu (0-8-1). Giving a SITREP does not make you wait, but it will cost you 1 CP for each save."]];
player createDiaryRecord ["help", ["Repairing/Rearming", "To repair, refuel or rearm a vehicle you need to unlock the ""vehicle refit"" support. Once you have it, you can call the support and your vehicle will be rearmed, repaired and refueled. Note that you must be close to the base to be able to use the vehicle refit."]];
player createDiaryRecord ["help", ["Support", "During the campaign you may unlock several support options at you HQ. You can access the available support in the radio menu (0-8). Note that calling for support cost CP."]];
player createDiaryRecord ["help", ["Making a FOB", "After you have captured your first zone, you'll get the ability to establish a FOB for 10 CP. A FOB allows you to rest(save) at remote locations outside the base. Establishing a FOB will also spawn some BLUFOR patrols around it and if there are enemies around it, you will be notified. To establish a FOB, you must make sure the zone around you is clear in a radius of 500 meters. Just go to the support menu and select 'Establish FOB'. A FOB will be deployed to your location."]];
player createDiaryRecord ["help", ["Side Missions", "You can request a side mission at the officer in the base. Successful side missions will not give any army power to the enemy, but will give you CP and increase your army power."]];
player createDiaryRecord ["help", ["Requesting units", "To request units, go to the officer at the base and select the action ""Request units""."]];
player createDiaryRecord ["help", ["Taking the Island", "At the beginning of the game, you are alone with your officer and only a few command points available, but as the war escalates, the BLUFOR HQ will start to launch attacks on enemy zone and will try to retake the island. You can help the main forces by assisting them in capturing the island, or you can also achieve side missions to boost the available assets of your army. It's up to you on how you want to play this campaign."]];

// Operatives
_index = player createDiarySubject ["operativehelp","Special operatives"];
player createDiaryRecord ["operativehelp", ["Skills", "<font color='#FF0000'>Aiming:</font color><br />Pretty self explanatory, how well the operative can aim, lead a target, compensante for bullet drop and manage recoil.<br /><br /><font color='#FF0000'>Reflexes:</font color><br />How fast the operator can react to a new threat and stabilize its aim.<br /><br /><font color='#FF0000'>Spotting:</font color><br />The operative ability to spot targets within it's visual or audible range, and how accurately he can spot targets.<br /><br /><font color='#FF0000'>Courage:</font color><br />Affects the morale of subordinates units of the operative, how likely they will flee, depending on what is in front of them and the squad status.<br /><br /><font color='#FF0000'>Communications:</font color><br />How quickly recognized targets are shared with the squad.<br /><br /><font color='#FF0000'>Reload speed:</font color><br />The operator's ability to switch weapon or reload quickly."]];
player createDiaryRecord ["operativehelp", ["Recruiting operatives", "Operatives can be recruited at the HQ, inside the ""request unit"" menu. When you recruit someone for the first time, you'll have to spend 5 CP. However, once an operative has been already recruited, has been ""injured""(killed) in battle, you can recruit it again for only 2 CP after a delay between 20 and 80 minutes."]];
player createDiaryRecord ["operativehelp", ["Overview", "You can recruit special operatives that will stay and progress with you for all the duration of the campaign. Some of these mens have special equipment, specialities and skills. Their skills will increase each time a zone is captured or a mission is accomplished, whether they're in your squad or not. However, when an operative is actually in the game, he will gain 10 spendable points wich can be assigned freely in any skill at the operative menu."]];

if (isMultiplayer) then {
    player createDiaryRecord ["help", ["MP notes", "The CP pool is common for everyone.<br /><br />While most support unlocks are indivdual, the Armory and the Specialized infantry training are common, and need to be unlocked only once by a single player.<br /><br />While everybody can rest to heal, only the host can save and skip the time.<br /><br />Only the host can request side mission and finish them. However, everyone receive the persistent stats and xp bonuses."]];
};

// MP notification
if (isMultiplayer) then {
	[] spawn {
		waitUntil {time > 5};
		["info",["MP Mechanics","Check the manual for the specifics of the DUWS-R in MP"]] call bis_fnc_showNotification;
	};
};

diag_log "dialog\gameHelp.sqf: Finished";