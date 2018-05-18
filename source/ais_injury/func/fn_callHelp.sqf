// by psycho
private ["_unit"];
_unit = _this select 0;

if (!(_unit getVariable "tcb_ais_agony")) exitWith {};
if (!isNull(_unit getVariable "healer") || {!isNull(_unit getVariable "dragger")} || {!isNull(_unit getVariable "helper")}) exitWith {["You are already being assisted.",0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if ((_unit getVariable "callHelpDelay") > time) exitWith {["Stop screaming - you have already called for help!",0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};

_unit setVariable ["callHelpDelay", time + 3];
["Help me! Please!",0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;

[_unit,objNull,true] spawn tcb_fnc_sendaihealer;