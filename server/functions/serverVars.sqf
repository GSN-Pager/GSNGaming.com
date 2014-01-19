//	@file Version: 1.1
//	@file Name: serverVars.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [404] Pulse, [GoT] JoSchaap, MercyfulFate, AgentRev
//	@file Created: 20/11/2012 05:19
//	@file Args:

if (!isServer) exitWith {};

diag_log "WASTELAND SERVER - Initializing Server Vars";

pvar_teamSwitchList = [];
publicVariable "pvar_teamSwitchList";
pvar_teamKillList = [];
publicVariable "pvar_teamKillList";
pvar_spawn_beacons = [];
publicVariable "pvar_spawn_beacons";
pvar_warchest_funds_east = 0;
publicVariable "pvar_warchest_funds_east";
pvar_warchest_funds_west = 0;
publicVariable "pvar_warchest_funds_west";
clientMissionMarkers = [];
publicVariable "clientMissionMarkers";
clientRadarMarkers = [];
publicVariable "clientRadarMarkers";
currentDate = [];
publicVariable "currentDate";
currentInvites = [];
publicVariable "currentInvites";

"PlayerCDeath" addPublicVariableEventHandler { [_this select 1] spawn server_playerDied };

currentStaticHelis = []; // Storage for the heli marker numbers so that we don't spawn wrecks on top of live helis

//Civilian Vehicle List - Random Spawns
civilianVehicles =
[
	"C_Hatchback_01_sport_F",
	"C_Hatchback_01_F",
	"C_Offroad_01_F",
	"C_Quadbike_01_F",
	"C_SUV_01_F",
	"C_Van_01_transport_F",
	"C_Van_01_box_F",
	"C_Van_01_fuel_F"
];

//Light Military Vehicle List - Random Spawns
lightMilitaryVehicles =
[
	"B_MRAP_01_F",
	"O_MRAP_02_F",
	"I_MRAP_03_F",
	"B_G_Offroad_01_F",
	"B_G_Quadbike_01_F",
	"B_G_Van_01_transport_F",
	"B_MRAP_01_F",
	"O_MRAP_02_F",
	"I_MRAP_03_F",
	"B_Truck_01_medical_F",
	"I_Truck_02_medical_F",
	"O_Truck_02_medical_F"
];

//Medium Military Vehicle List - Random Spawns
mediumMilitaryVehicles =
[
	/*"B_MRAP_01_hmg_F",
	"O_MRAP_02_hmg_F",
	"I_MRAP_03_hmg_F",*/
	"B_G_Offroad_01_armed_F"
];

//Water Vehicles - Random Spawns
/*waterVehicles = No water in Zargabad
[
	"C_Boat_Civil_01_police_F",
	"C_Rubberboat",
	"O_Rubberboat",
	"B_G_Boat_Transport_01_F",
	"I_Boat_Transport_01_F"
];*/

//Object List - Random Spawns.
objectList =
[
	"IG_supplyCrate_F",
	"CamoNet_INDP_open_F",
	"CamoNet_INDP_open_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Large_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Small_F",
	"Land_BagBunker_Tower_F",
	"Land_BagBunker_Tower_F",
	"Box_NATO_Wps_F",
	"Land_Canal_Wall_Stairs_F",
	"Land_Canal_WallSmall_10m_F",
	"Land_Canal_WallSmall_10m_F",
	"Land_CncBarrierMedium4_F",
	"Land_CncShelter_F",
	"Land_CncWall4_F",
	"Land_HBarrier_1_F",
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",
	"Land_HBarrier_5_F",
	"Land_HBarrier_5_F",
	"Box_East_Wps_F",
	"IG_supplyCrate_F",
	"Land_HBarrierBig_F",
	"Land_HBarrierBig_F",
	"Land_HBarrierBig_F",
	"Land_HBarrierBig_F",
	"Land_HBarrierTower_F",
	"Land_HBarrierWall4_F",
	"Land_HBarrierWall4_F",
	"Land_HBarrierWall6_F",
	"Land_HBarrierWall6_F",
	"Land_Mil_ConcreteWall_F",
	"Land_RampConcrete_F",
	"Land_RampConcreteHigh_F",
	"Box_IND_Wps_F",
	"Land_Sacks_goods_F",
	"Land_Shoot_House_Wall_F",
	"Land_WaterBarrel_F"
];

//Object List - Random Spawns.
staticWeaponsList =
[
	"B_Mortar_01_F",
	"O_Mortar_01_F",
	"I_Mortar_01_F",
	"I_G_Mortar_01_F"
];

//Object List - Random Helis.
staticHeliList =
[
	"B_Heli_Light_01_F",
	"B_Heli_Transport_01_camo_F",
	"I_Heli_light_03_unarmed_F",
	"O_Heli_Light_02_unarmed_F"
];

//Random Weapon List - Change this to what you want to spawn in cars.
vehicleWeapons =
[
	"arifle_SDAR_F",
	"SMG_01_F",
	"SMG_02_F",
	"hgun_PDW2000_F",
	"arifle_TRG20_F",
	"arifle_TRG21_F",
	"arifle_TRG21_GL_F",
	"arifle_Mk20C_F",
	"arifle_Mk20_F",
	"arifle_Mk20_GL_F",
	"arifle_Katiba_F",
	"arifle_Katiba_C_F",
	"arifle_Katiba_GL_F",
	"arifle_MXC_F",
	"arifle_MX_F",
	"arifle_MX_GL_F",
	"arifle_MX_SW_F",
	"arifle_MXM_F",
	"srifle_GM6_SOS_F",
	"srifle_DMR_01_F",
	"srifle_LRR_SOS_F",
	"LMG_Mk200_F",
	"LMG_Zafir_F"
];

vehicleAddition =
[
	"muzzle_snds_L", // 9mm
	"muzzle_snds_M", // 5.56mm
	"muzzle_snds_H", // 6.5mm
	"muzzle_snds_H_MG", // 6.5mm LMG
	"muzzle_snds_B", // 7.62mm
	"muzzle_snds_acp", // .45 ACP
	"optic_Arco",
	"optic_SOS",
	"optic_Hamr",
	"optic_Aco",
	"optic_ACO_grn",
	"optic_aco_smg",
	"optic_SOS",
	"optic_LRPS",
	"optic_Holosight",
	"optic_Holosight_smg",
	"optic_Yarris",
	"optic_DMS",
	"optic_SOS"
];

vehicleAddition2 =
[
	"Chemlight_blue",
	"Chemlight_green",
	"Chemlight_yellow",
	"Chemlight_red"
];

MissionSpawnMarkers = [];
{
	if (["Mission_", _x] call fn_findString == 0) then
	{
		MissionSpawnMarkers set [count MissionSpawnMarkers, [_x, false]];
	};
} forEach allMapMarkers;