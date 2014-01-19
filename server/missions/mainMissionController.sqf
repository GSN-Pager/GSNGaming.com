//	@file Version: 1.1
//	@file Name: mainMissionController.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, Sanjo, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitWith {};
#include "mainMissions\mainMissionDefines.sqf";

private ["_MainMissions", "_MainMissionsOdds", "_missionType", "_nextMission", "_missionRunning", "_hint"];

diag_log "WASTELAND SERVER - Started Main Mission State";

_MainMissions =
[	// increase the number (weight) to increase the missions chance to be selected
/* ["mission_Coastal_Convoy", 0], */
["mission_Convoy", 0.5],
["mission_HostileHeliFormation", 0.5],
["mission_APC", 0.25],
/* ["mission_MBT", 0], */
["mission_LightArmVeh", 1],
["mission_ArmedHeli", 0.5],
["mission_CivHeli", 1],
["mission_Outpost", 1]
];

_MainMissionsOdds = [];
{
	_MainMissionsOdds set [_forEachIndex, if (count _x > 1) then { _x select 1 } else { 1 }];

    // Attempt to compile every mission for early bug detection
	compile preprocessFileLineNumbers format ["server\missions\mainMissions\%1.sqf", _x select 0];
} forEach _MainMissions;

while {true} do
{
	_nextMission = [_MainMissions, _MainMissionsOdds] call fn_selectRandomWeighted;
	_missionType = _nextMission select 0;

	_missionRunning = execVM format ["server\missions\mainMissions\%1.sqf", _missionType];

	diag_log format["WASTELAND SERVER - Execute New Main Mission: %1",_missionType];
	_hint = parseText format ["<t align='center' color='%2' shadow='2' size='1.75'>Main Objective</t><br/><t align='center' color='%2'>------------------------------</t><br/><t color='%3' size='1.0'>Starting in %1 Minutes</t>", mainMissionDelayTime / 60, mainMissionColor, subTextColor];
	[_hint] call hintBroadcast;
	waitUntil{sleep 0.1; scriptDone _missionRunning};
	sleep 5;
};