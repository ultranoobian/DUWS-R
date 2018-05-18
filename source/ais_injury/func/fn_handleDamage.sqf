// by BonInf*
// changed by psycho
private ['_agony','_unit','_bodypart','_damage','_return','_revive_factor','_source'];
_unit 		= _this select 0;
_bodypart	= _this select 1;
_damage		= _this select 2;
_source 	= _this select 3;

if (isNull _source && {_unit getVariable "tcb_ais_agony"}) exitWith {_unit getVariable "tcb_ais_damageStore"};	//<-- exclude NullSource break down some other game features!!!

if (tcb_ais_impactEffects) then {
	[_unit,_damage] call tcb_fnc_impactEffect;
};

if (!(_unit getVariable "tcb_ais_agony") && {alive _unit}) then {
	_return = _damage / (tcb_ais_rambofactor max 1);
	//diag_log format [".............................................part: %1 --- damage: %2 --- return: %3",_bodypart,_damage,_return];
	_revive_factor = (tcb_ais_rambofactor max 1) * 1.5;
	_agony = false;

	switch _bodypart do {
		case "body" : {
			_damage = (_unit getVariable "tcb_ais_bodyhit") + (_return * 0.5);	// scale down for 1.14
			_unit setVariable ["tcb_ais_bodyhit", _damage];
			if (_damage >= 0.9) then {
				_agony = true;
				if (!tcb_ais_revive_guaranty && {!tcb_ais_realistic_mode}) then {
					if (_damage > _revive_factor) then {_unit setVariable ["tcb_ais_unit_died", true]};
				};
				if (!(_unit getVariable "tcb_ais_unit_died") && {!tcb_ais_revive_guaranty}) then {	// determine 0-damage in agony
					_unit setDamage _return;
					_unit setVariable ["tcb_ais_damageStore", _return];
				} else {
					if (tcb_ais_revive_guaranty) then {
						_unit setHit ["body", 0.89];
						_unit setDamage 0.89;
						_unit setVariable ["tcb_ais_damageStore", 0.89];
					};
				};
			} else {
				_unit setHit ["body", _damage];
			};
		};
		
		case "head" : {
			if (_damage > 20) exitWith {};	// ghost-dead-bug
			if (tcb_ais_realistic_mode) then {
				_damage = (_unit getVariable "tcb_ais_headhit") + (_return * 2.5);	// scale up for 1.14
			} else {
				_damage = (_unit getVariable "tcb_ais_headhit") + (_return * 1.0);
			};
			_unit setVariable ["tcb_ais_headhit", _damage];
			if (_damage >= 0.9) then {
				_agony = true;
				if (!tcb_ais_revive_guaranty && {!tcb_ais_realistic_mode}) then {
					if (_damage > _revive_factor) then {_unit setVariable ["tcb_ais_unit_died", true]};
				};
				if (!(_unit getVariable "tcb_ais_unit_died") && {!tcb_ais_revive_guaranty}) then {	// determine 0-damage in agony
					_unit setDamage _return;
					_unit setVariable ["tcb_ais_damageStore", _return];
				} else {
					if (tcb_ais_revive_guaranty) then {
						_unit setHit ["head", 0.89];
						_unit setDamage 0.89;
						_unit setVariable ["tcb_ais_damageStore", 0.89];
					};
				};
				//diag_log format ["head damage: %1", _damage];
			} else {
				_unit setHit ["head", _damage];
			};
		};
		
		case "legs" : {
			_damage = (_unit getVariable "tcb_ais_legshit") + _return;
			_unit setVariable ["tcb_ais_legshit", _damage];
			if (_damage >= 1.8) then {
				_agony = true;
			} else {
				_unit setHit ["legs",_damage];
			};
		};
		case "legs_l" : {
			_damage = (_unit getVariable "tcb_ais_legshit") + _return;
			_unit setVariable ["tcb_ais_legshit", _damage];
			if (_damage >= 1.8) then {
				_agony = true;
			} else {
				_unit setHit ["legs",_damage];
			};
		};
		case "legs_r" : {
			_damage = (_unit getVariable "tcb_ais_legshit") + _return;
			_unit setVariable ["tcb_ais_legshit", _damage];
			if (_damage >= 1.8) then {
				_agony = true;
			} else {
				_unit setHit ["legs",_damage];
			};
		};
		case "hands" : {
			_damage = (_unit getVariable "tcb_ais_handshit") + _return;
			_unit setVariable ["tcb_ais_handshit", _damage];
			if (_damage >= 2.3) then {
				_agony = true;
			} else {
				_unit setHit ["hands",_damage];
			};
		};
		case "hands_l" : {
			_damage = (_unit getVariable "tcb_ais_handshit") + _return;
			_unit setVariable ["tcb_ais_handshit", _damage];
			if (_damage >= 2.3) then {
				_agony = true;
			} else {
				_unit setHit ["hands",_damage];
			};
		};
		case "hands_r" : {
			_damage = (_unit getVariable "tcb_ais_handshit") + _return;
			_unit setVariable ["tcb_ais_handshit", _damage];
			if (_damage >= 2.3) then {
				_agony = true;
			} else {
				_unit setHit ["hands",_damage];
			};
		};
		
		case "" : {
			_damage = damage vehicle _unit + _return; //(_unit getVariable "tcb_ais_overall") + _return;
			_unit setVariable ["tcb_ais_overall", _damage];
			if (_damage >= 0.9) then {
				_agony = true;
				if (!tcb_ais_revive_guaranty || {tcb_ais_realistic_mode}) then {
					if (_damage > _revive_factor) then {_unit setVariable ["tcb_ais_unit_died", true]};
				};
				if (!(_unit getVariable "tcb_ais_unit_died") && {!tcb_ais_revive_guaranty}) then {	// determine 0-damage in agony
					_unit setDamage _return;
					_unit setVariable ["tcb_ais_damageStore", _return];
				} else {
					if (tcb_ais_revive_guaranty && {_damage > 6}) then {
						_unit setHit ["body",0.8];
						_unit setDamage 0.85;
						_unit setVariable ["tcb_ais_damageStore", 0.89];
					};
				};
			};
		};
		default {};
	};

	if (!_agony) then {[_unit] call tcb_fnc_setDamage};
	_unit setVariable ["tcb_ais_damageStore", damage _unit];
	
	if (_agony && {!(_unit getVariable "tcb_ais_agony")}) then {
		_unit setVariable ["tcb_ais_agony", true, true];
		_delay = time + 5;
		_unit setVariable ["tcb_ais_fall_in_agony_time_delay", _delay];
	};
	_return = _unit getVariable "tcb_ais_damageStore";

} else {

	if (!alive _unit) exitWith {_unit setVariable ["tcb_ais_unit_died", true]; _damage};
	if (time > (_unit getVariable "tcb_ais_fall_in_agony_time_delay")) then {
		_unit setVariable ["tcb_ais_unit_died", true];
	};
	_return = _unit getVariable "tcb_ais_damageStore";
};

BIS_hitArray = _this; BIS_wasHit = true; // For BIS stuff to work
_return