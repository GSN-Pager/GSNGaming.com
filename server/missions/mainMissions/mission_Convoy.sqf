//	@file Version: 2
//	@file Name: mission_Convoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo)
//	@file Created: 31/08/2013 18:19
//	@file Args: none

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_missionMarkerName","_missionType","_picture","_vehicleName","_hint","_waypoint","_routes","_convoyVeh","_veh1","_veh2","_veh3","_rn","_waypoints","_starts","_startdirs","_group","_vehicles","_marker","_failed","_startTime","_numWaypoints","_ammobox","_ammobox2","_createVehicle","_leader"];

_missionMarkerName = "Convoy_Marker";
_missionType = "Convoy";
diag_log format["WASTELAND SERVER - Main Mission Started: %1", _missionType];
diag_log format["WASTELAND SERVER - Main Mission Waiting to run: %1", _missionType];
[mainMissionDelayTime] call createWaitCondition;
diag_log format["WASTELAND SERVER - Main Mission Resumed: %1", _missionType];

//pick the vehicles for the convoy (veh2 is the 'convoyed' vehicle
_convoyVeh =
[
["B_MRAP_01_hmg_F", "B_Truck_01_covered_F", "B_MRAP_01_gmg_F"],
["O_MRAP_02_hmg_F", "O_Truck_02_covered_F", "O_MRAP_02_gmg_F"],
["I_MRAP_03_hmg_F", "I_Truck_02_covered_F", "I_MRAP_03_gmg_F"]
]
call BIS_fnc_selectRandom;

_veh1 = _convoyVeh select 0;
_veh2 = _convoyVeh select 1;
_veh3 = _convoyVeh select 2;

// available routes to add a route. If you add more routes append ,4 to the array and so on
_routes = [1];

// pick one of the routes
_rn = _routes call BIS_fnc_selectRandom;

// set starts and waypoints depending on above (random) choice
switch (_rn) do
{
	case 1: {
// route 1
// starting positions for this route
		_starts =
		[
			[2962.23, 18.0703],
			[2943.67, 47.2583],
			[2992.07, 2.0542]
		];
// starting directions in which the vehicles are spawned on this route
		_startdirs =
		[
			0,
			0,
			0
		];
// the routes
		_waypoints =
		[
			[2773.82, 3231.53],
			[3414.35, 4617.79],
			[3855.78, 4221.19],
			[4187.24, 4221.72],
			[4244.73, 3973.30],
			[4437.15, 3842.73],
			[4653.68, 4265.84],
			[4450.23, 4839.01],
			[4951.43, 5749.38]
		];
	};
// end of route one
	case 2: {
// route 2
// starting positions for this route
		_starts =
		[
			[2671.03, 6260.52],
			[2780.25, 6218.57],
			[2864.50, 6166.90]
		];
// starting directions in which the vehicles are spawned on this route
		_startdirs =
		[
			188.5,
			186.4,
			188.5
		];
// the routes
		_waypoints =
		[
			[3944.53, 5801.65],
			[4070.10, 5125.18],
			[4175.72, 4671.95],
			[4035.48, 4571.31],
			[4059.24, 4080.20],
			[3453.19, 4084.81],
			[3514.45, 3026.59],
			[3035.04, 2568.65]
		];
// end of route two
	};
	default {
// this shouldnt happen but just to be sure..
	diag_log format["WASTELAND SERVER - WARNING! %1 encountered an error selecting routes - defaulting to route 1", _missionType];
// route 1
// starting positions for this route
		_starts =
		[
			[2962.23, 18.0703],
			[2943.67, 47.2583],
			[2992.07, 2.0542]
		];
// starting directions in which the vehicles are spawned on this route
		_startdirs =
		[
			0,
			0,
			0
		];
// the routes
		_waypoints =
		[
			[2773.82, 3231.53],
			[3414.35, 4617.79],
			[3855.78, 4221.19],
			[4187.24, 4221.72],
			[4244.73, 3973.30],
			[4437.15, 3842.73],
			[4653.68, 4265.84],
			[4450.23, 4839.01],
			[4951.43, 5749.38]
		];
	};
};

_group = createGroup civilian;

_createVehicle = {
	private ["_type","_position","_direction","_group","_vehicle","_soldier"];

	_type = _this select 0;
	_position = _this select 1;
	_direction = _this select 2;
	_group = _this select 3;

	_vehicle = _type createVehicle _position;
	[_vehicle] call vehicleSetup;
	_vehicle setDir _direction;
	_group addVehicle _vehicle;

	_soldier = [_group, _position] call createRandomSoldier;
	_soldier moveInDriver _vehicle;
	_soldier = [_group, _position] call createRandomSoldier;
	_soldier moveInCargo [_vehicle, 0];
	_soldier = [_group, _position] call createRandomSoldier;
	_soldier moveInCargo [_vehicle, 1];
	_soldier = [_group, _position] call createRandomSoldier;
// get a unit inside gunner seat on the armed vehicles
	if (_vehicle isKindOf _veh2) then {
	_soldier moveInCargo [_vehicle, 2];
    } else {
	_soldier moveInTurret [_vehicle, [0]];
    };
	_vehicle setVehicleLock "LOCKED";  // prevents players from getting into the vehicle while the AI are still owning it
	_vehicle spawn cleanVehicleWreck;  // courtesy of AgentREV sets cleanup on the mission vehicles once wrecked :)
	_vehicle
};

_vehicles = [];
_vehicles set [0, [_veh1, (_starts select 0), (_startdirs select 0), _group] call _createVehicle];
_vehicles set [1, [_veh2, (_starts select 1), (_startdirs select 1), _group] call _createVehicle];
_vehicles set [2, [_veh3, (_starts select 2), (_startdirs select 2), _group] call _createVehicle];

_leader = driver (_vehicles select 0);
_group selectLeader _leader;
_leader setRank "LIEUTENANT";

_group setCombatMode "GREEN"; // units will defend themselves
_group setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
_group setFormation "STAG COLUMN";
_group setSpeedMode "LIMITED";

{
	_waypoint = _group addWaypoint [_x, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 50;
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
	_waypoint setWaypointFormation "STAG COLUMN";
	_waypoint setWaypointSpeed "LIMITED";
} forEach _waypoints;

_marker = createMarker [_missionMarkerName, position leader _group];
_marker setMarkerType "mil_destroy";
_marker setMarkerSize [1.25, 1.25];
_marker setMarkerColor "ColorRed";
_marker setMarkerText "Armed Convoy";

_picture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
_vehicleName = getText (configFile >> "cfgVehicles" >> _veh2 >> "displayName");

// Remove " (Covered)" from vehicle name when applicable
if ([_vehicleName, (count toArray _vehicleName) - 10] call BIS_fnc_trimString == " (Covered)") then
{
	_vehicleName = [_vehicleName, 0, (count toArray _vehicleName) - 11] call BIS_fnc_trimString;
};

_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Main Objective</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>A <t color='%4'>%3</t> transporting 2 weapon crates, is convoyed by two armored vehicles. Stop them!</t>", _missionType, _picture, _vehicleName, mainMissionColor, subTextColor];
[_hint] call hintBroadcast;

diag_log format["WASTELAND SERVER - Main Mission Waiting to be Finished: %1", _missionType];

_failed = false;
_startTime = floor(time);
_numWaypoints = count waypoints _group;
waitUntil
{
	private ["_unitsAlive"];

	sleep 10;

	_marker setMarkerPos (position leader _group);

	if ((floor time) - _startTime >= mainMissionTimeout) then { _failed = true };
	if (currentWaypoint _group >= _numWaypoints) then { _failed = true }; // Convoy got successfully to the target location
	_unitsAlive = { alive _x } count units _group;

	_unitsAlive == 0 || _failed
};

if(_failed) then
{
// Mission failed
	if not(isNil "_vehicle") then {deleteVehicle _vehicle;};
	{if (vehicle _x != _x) then { deleteVehicle vehicle _x; }; deleteVehicle _x;}forEach units _group;
	{deleteVehicle _x;}forEach units _group;
	deleteGroup _group;
	_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Failed</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>Objective failed, better luck next time</t>", _missionType, _picture, _vehicleName, failMissionColor, subTextColor];
	[_hint] call hintBroadcast;
	diag_log format["WASTELAND SERVER - Main Mission Failed: %1",_missionType];
} else {
// Mission completed
// unlock the vehicles incase the player cleared the mission without destroying them
	if (!isNil "_vehicles") then {
	{
		_x setVehicleLock "UNLOCKED";
		_x setVariable ["R3F_LOG_disabled", false, true];
	}forEach _vehicles;
	};
// give the rewards
	_ammobox = "Box_NATO_Wps_F" createVehicle getMarkerPos _marker;
	[_ammobox,"mission_USSpecial2"] call fn_refillbox;
	_ammobox allowDamage false;

	_ammobox2 = "Box_East_WpsSpecial_F" createVehicle getMarkerPos _marker;
	[_ammobox2,"mission_USLaunchers"] call fn_refillbox;
	_ammobox2 allowDamage false;

	deleteGroup _group;
	_hint = parseText format ["<t align='center' color='%4' shadow='2' size='1.75'>Objective Complete</t><br/><t align='center' color='%4'>------------------------------</t><br/><t align='center' color='%5' size='1.25'>%1</t><br/><t align='center'><img size='5' image='%2'/></t><br/><t align='center' color='%5'>The convoy has been stopped. The weapon crates and vehicles are yours to take.</t>", _missionType, _picture, _vehicleName, successMissionColor, subTextColor];
	[_hint] call hintBroadcast;
	diag_log format["WASTELAND SERVER - Main Mission Success: %1",_missionType];
};

deleteMarker _marker;