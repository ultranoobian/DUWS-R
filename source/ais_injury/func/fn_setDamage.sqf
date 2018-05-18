//  by psycho
private ["_unit","_return","_fac"];
_unit = _this select 0;

_fac = 0.35;
_return = ((_unit getVariable "tcb_ais_headhit") * 0.25) + 
	((_unit getVariable "tcb_ais_handshit") * _fac) + 
	((_unit getVariable "tcb_ais_overall") * 0.25) + 
	((_unit getVariable "tcb_ais_legshit") * _fac) + 
	((_unit getVariable "tcb_ais_bodyhit") * _fac);
		
//diag_log format ["return: %1", _return];
if (tcb_ais_revive_guaranty) then {
	if (_return >= 0.9) then {_return = 0.89; _unit setDamage _return;} else {_unit setDamage _return};
} else {
	_unit setDamage _return;
};

true