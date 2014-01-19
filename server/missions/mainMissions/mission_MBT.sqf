//	@file Version: 1.0
//	@file Name: mission_MBT.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy
//	@file Created: 08/12/2012 15:19
//	@file Args:

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_result","_missionMarkerName","_missionType","_startTime","_returnData","_randomPos","_randomIndex","_vehicleClass","_vehicle","_picture","_vehicleName","_hint","_currTime","_playerPresent","_unitsAlive"];

//Mission Initialization.
_result = 0;
_missionMarkerName = "MBT_Marker";
_missionType = "Main Battle Tank";
_startTime = floor(time);

diag_log format["WASTELAND SERVER - Main Mission Started: %1",_missionType];

//Get Mission Location
_returnData = call createMissionLocation;
_randomPos = _returnData select 0;
_randomIndex = _returnData select 1;

diag_log format["WASTELAND SERVER - Main Mission Waiting to run: %1",_missionType];
[mainMissionDelayTime] call createWaitCondition;
diag_log format["WASTELAND SERVER - Main Mission Resumed: %1",_missionType];

[_missionMarkerName,_randomPos,_missionType] call createClientMarker;

_vehicleClass = ["B_MBT_01_cannon_F", "O_MBT_02_cannon_F"] call BIS_fnc_selectRandom;

//Vehicle Class, Posistion, Fuel, Ammo, Damage, State
_vehicle = [_vehicleClass,_randomPos,1,0.5,0,"NONE"] call createMissionVehicle;

switch (_vehicleClass) do
{
	case "B_MBT_01_cannon_F":
	{
		_vehicle removeMagazinesTurret ["16Rnd_120mm_HE_shells_Tracer_Red", [0]];
		_vehicle removeMagazinesTurret ["2000Rnd_65x39_belt", [0]];
		_vehicle addMagazineTurret ["2000Rnd_65x39_belt", [0]];
		_vehicle setVehicleAmmo 0.5;
		_vehicle addMagazineTurret ["16Rnd_120mm_HE_shells_Tracer_Red", [0]];
		reload _vehicle;
	};
	case "O_MBT_02_cannon_F":
	{
		_vehicle removeMagazinesTurret ["16Rnd_120mm_HE_shells_Tracer_Green", [0]];
		_vehicle removeMagazinesTurret ["450Rnd_127x108_Ball", [0,0]];
		_vehicle removeMagazinesTurret ["SmokeLauncherMag", [0,0]];
		_vehicle setVehicleAmmo 0.5;
		_vehicle addMagazineTurret ["16Rnd_120mm_HE_shells_Tracer_Red", [0]];
		_vehicle addMagazineTurret ["450Rnd_127x108_Ball", [0,0]];
		_vehicle addMagazineTurret ["SmokeLauncherMag", [0,0]];
		reload _vehicle;
	};
};

_picture = getText (configFile >> "cfgVehicles" >> typeOf _vehicle >> "picture");
_vehicleName = getText (configFile >> "cfgVehicles" >> typeOf _vehicle >> "displayName");
_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Main Objective</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>A <t color='%4'>%3</t> has been immobilized, go get it for your team.</t>", _missionType, _picture, _vehicleName, mainMissionColor, subTextColor];
[_hint] call hintBroadcast;

_CivGrpM = createGroup civilian;
[_CivGrpM,_randomPos] spawn createLargeGroup;

diag_log format["WASTELAND SERVER - Main Mission Waiting to be Finished: %1",_missionType];
_startTime = floor(time);

waitUntil
{
	sleep 1;
	_playerPresent = false;
	_currTime = floor(time);
	if(_currTime - _startTime >= mainMissionTimeout) then {_result = 1;};
	{if((isPlayer _x) AND (_x distance _vehicle <= missionRadiusTrigger)) then {_playerPresent = true};}forEach playableUnits;
	_unitsAlive = ({alive _x} count units _CivGrpM);
	(_result == 1) OR ((_playerPresent) AND (_unitsAlive < 1)) OR ((damage _vehicle) == 1)
};

_vehicle setVehicleLock "UNLOCKED";
_vehicle setVariable ["R3F_LOG_disabled", false, true];

if(_result == 1) then
{
	//Mission Failed.
	if (!isNil "_vehicle") then { deleteVehicle _vehicle };
	{ deleteVehicle _x } forEach units _CivGrpM;
	deleteGroup _CivGrpM;
	_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>Objective failed, better luck next time.</t>", _missionType, _picture, _vehicleName, failMissionColor, subTextColor];
	[_hint] call hintBroadcast;
	//Reset the mission spawn bool
	diag_log format["WASTELAND SERVER - Main Mission Failed: %1",_missionType];
} else {
	//Mission Complete.
	deleteGroup _CivGrpM;
	_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Complete</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>The tank has been captured, brace yourselves.</t>", _missionType, _picture, _vehicleName, successMissionColor, subTextColor];
	[_hint] call hintBroadcast;
	//Reset the mission spawn bool
	diag_log format["WASTELAND SERVER - Main Mission Success: %1",_missionType];
};

//Reset Mission Spot.
MissionSpawnMarkers select _randomIndex set[1, false];
[_missionMarkerName] call deleteClientMarker;