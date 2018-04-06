{
	 _loadout = getUnitLoadout typeOf _x ;
	_x setUnitLoadout _loadout;
} forEach units group player;