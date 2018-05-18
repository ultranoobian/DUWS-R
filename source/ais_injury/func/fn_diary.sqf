// by psycho
if (isDedicated) exitWith {};
if (!isDedicated) exitWith {};

_subject = player createDiarySubject ["ais", "First Aid System"];
_log_briefing = player createDiaryRecord ["ais", ["About and Credits", "
<font face='PuristaMedium' size=18 color='#ffffff'>Made by: </font><font face='PuristaMedium' size=25 color='#8E8E8E'>Psychobastard</font><br/>
<font face='PuristaMedium' size=18 color='#ffffff'>Version: </font><font face='PuristaMedium' size=20 color='#ffffff'>05042014</font><br/><br/>

<font face='PuristaMedium' size=30 color='#014EE3'>Credits</font><br/>
- <font face='PuristaMedium' size=18 color='#8E8E8E'>BonInf*</font> for the first multiplayer compatible version (Arma 2)<br/>
- <font face='PuristaMedium' size=18 color='#8E8E8E'>EightSix</font> for his PatrolOps and the included status bar<br/>
- <font face='PuristaMedium' size=18 color='#8E8E8E'>BI</font> for the design idea (Wounding module Arma 2)
"]];
_log_briefing = player createDiaryRecord ["ais", ["How to use?", "
<font face='PuristaMedium' size=25 color='#014EE3'>If you are unconscious...</font><br/>
- <font face='PuristaMedium' size=15 color='#8E8E8E'>press 'forward'</font> to roll on your belly and fire again<br/>
- you can <font face='PuristaMedium' size=15 color='#8E8E8E'>croush</font> into a safe position<br/>
- <font face='PuristaMedium' size=15 color='#8E8E8E'>press 'H'</font> button to call AI for help<br/>
- <font face='PuristaMedium' size=15 color='#8E8E8E'>you cant</font> reload, trhow grenades, change weapon, board vehicles, ...<br/><br/><br/>

<font face='PuristaMedium' size=25 color='#014EE3'>If you want to help...</font><br/>
- go close to a unconscious body and select <font face='PuristaMedium' size=15 color='#8E8E8E'>'First Aid'</font> to help (Mousewheel)<br/>
- go close to a unconscious body and select <font face='PuristaMedium' size=15 color='#8E8E8E'>'Drag'</font> to drag the body out of the fireline (Mousewheel)<br/>
- if you have start to drag you can select <font face='PuristaMedium' size=15 color='#8E8E8E'>'Carry'</font> to get the body on your shoulders (better way for longer distances)<br/>
- go close to a unconscious body and select <font face='PuristaMedium' size=15 color='#8E8E8E'>'press on wound'</font> to stop bleeding until a medic is present (Mousewheel)<br/>
- in some cases you need medical equipment (first aid kit or bandages) or must be a medic to start the 'first aid' action<br/><br/>
"]];
_log_briefing = player createDiaryRecord ["ais", ["How it work?", "
If a unit recive to much damage the unit go in unconscious-mode. That means the unit start to bleed and need help from other units.
If someone come to help he can stop the bleeding and heal the unit. The rest damage after the first aid process depends on some things. (healer was a medic? medical equipment used?)<br/><br/>
If nobody come to help the unit bleed out after some time. The time depends on the strength of the units damage. If you cant start the first aid process of some reason you have the option to press on the wound. That means the unit stop to bleed until you release the press: (save lifetime)
"]];
_log_briefing = player createDiaryRecord ["ais", ["Description", "
<font face='PuristaMedium' size=30 color='#014EE3'>Psycho's Wounding System</font><br/><br/>
This First Aid System (AIS = Alternative Injury System) is a alternative system to all the existitng normal revive scripts.<br/><br/>
The main difference to a standard revive system is that you arent be dead before you go in the agony state. If a critical damage level is reached the unit go unconscious without dieing before like in most other systems. The advantage: You can use it in missions without a revive option too!<br/><br/>
Another advantage of the system is that if you are heavy wounded and wait for others help you arent completely defenseless. You can roll on your belly and use your weapon again until the magazine is empty.
The ais also supports AI. That mean AI soldiers can be unconscious or can help you too.
"]];

true