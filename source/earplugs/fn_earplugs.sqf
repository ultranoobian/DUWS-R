private['_handled'];
_handled = false;
switch (_this select 1) do
{
	//End key
	case 207:
	{
        if (soundVolume < 0.21) then { 0 fadeSound 1; }
		else { 0 fadeSound 0.2; };
		systemChat format["Sound volume changed to %1%2.", soundVolume * 100, "%"];
		_handled = true;
	};
};
_handled;