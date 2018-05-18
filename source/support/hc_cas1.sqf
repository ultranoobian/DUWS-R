if (commandpointsblu1<20) exitWith  
{
  ["info",["Not enough command points","Not enough Command Points (20CP required)"]] call bis_fnc_showNotification;
};
commandpointsblu1 = commandpointsblu1 - 20;
publicVariable "commandpointsblu1";

_group = creategroup [West,true]; //Create WEST group, delete when empty true

[[0,0,100], 0, "B_Plane_CAS_01_dynamicLoadout_F", _group] call bis_fnc_spawnvehicle; //spawn cas vehicle for _group
player hcsetgroup [_group, "CAS", "teammain"]; //add _group to player HC control, with name "CAS" and "teamwhite" colouring
_group setGroupId [format["Wipeout Bomber %1"]];
diag_log "EXP:CAS SPAWNED";
hint "Wipeout Spawned";
 
sleep 300;

_hcCAS = [player,"hc_CAS1"] call BIS_fnc_addCommMenuItem;