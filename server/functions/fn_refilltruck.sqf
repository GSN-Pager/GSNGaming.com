//        @file Version: 1.0
//        @file Name: fn_refilltruck.sqf
//        @file Author: AgentRev
//        @file Created: 30/06/2013 15:28

if (!isServer) exitWith {};

private ["_truck", "_truckItems", "_item", "_qty", "_mag"];
_truck = _this;

// Clear prexisting cargo first
clearMagazineCargoGlobal _truck;
clearWeaponCargoGlobal _truck;
clearItemCargoGlobal _truck;

// Item type, Item, # of items, # of magazines per weapon
_truckItems =
[
	["itm", "FirstAidKit", 5],
	["itm", "Medikit", 3],
	["itm", "Toolkit", 1],
	["itm", ["optic_LRPS", "optic_SOS"], 3],
	["itm", ["optic_Hamr", "optic_Arco"], 3],
	["wep", ["SMG_01_F", "SMG_02_F", "hgun_PDW2000_F"], 3, 4],
	["wep", ["srifle_EBR_F", "srifle_EBR_SOS_F"], 2, 5],
	["wep", ["arifle_Katiba_GL_F", "arifle_MX_GL_F"], 2, 5],
	["mag", "1Rnd_HE_Grenade_shell", 4],
	["wep", ["srifle_GM6_SOS_F", "srifle_LRR_SOS_F"], 1, 5],
	["wep", "launch_Titan_short_F", 2, 4],
	["mag", "HandGrenade", 5],
	["mag", ["APERSTripMine_Wire_Mag", "APERSBoundingMine_Range_Mag"], 5],
	["mag", ["ATMine_Range_Mag", "SLAMDirectionalMine_Wire_Mag"], 5]
];

[_truck, _truckItems] call processItems;