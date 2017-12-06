_group = creategroup [WEST,true]; //Create WEST group, delete when empty true

[[0,0,100], 0, "B_Plane_CAS_01_F", _group] call bis_fnc_spawnvehicle; //spawn cas vehicle for _group
player hcsetgroup [_group, "CAS", "teammain"]; //add _group to player HC control, with name "CAS" and "teamwhite" colouring
diag_log "EXP:CAS SPAWNED";
hint "CAS spawned";