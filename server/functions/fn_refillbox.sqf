//	@file Version: 1.0
//	@file Name: fn_refillbox.sqf  "fn_refillbox"
//	@file Author: [404] Pulse , [404] Costlyy , [404] Deadbeat, AgentRev
//	@file Created: 22/1/2012 00:00
//	@file Args: [OBJECT (Weapons box that needs filling), STRING (Name of the fill to give to object)]

if (!isServer) exitWith {};

private ["_box", "_boxType", "_boxItems", "_item", "_qty", "_mag"];
_box = _this select 0;
_boxType = _this select 1;

_box allowDamage false; // No more fucking busted crates

// Clear pre-existing cargo first
clearMagazineCargoGlobal _box;
clearWeaponCargoGlobal _box;
clearItemCargoGlobal _box;

switch (_boxType) do
{
    case "mission_USLaunchers":
	{
	_boxItems =
		[
			// Item type, Item class, # of items, # of magazines per weapon
			["wep", "launch_RPG32_F", 2, 4],
			["wep", "launch_NLAW_F", 2, 4],
			["wep", "launch_Titan_F", 2, 4],
			["wep", "launch_Titan_Short_F", 2, 4],
			["mag", "ClaymoreDirectionalMine_Remote_Mag", 3],
			["mag", "DemoCharge_Remote_Mag", 3]
		];
	};
    case "mission_USSpecial":
	{
	_boxItems =
		[
			// Item type, Item class, # of items, # of magazines per weapon
			//["itm", "NVGoggles", 5],
			["wep", "Rangefinder", 2],
			["itm", "Medikit", 3],
			["itm", "Toolkit", 1],
			["wep", "srifle_LRR_SOS_F", 1, 5],
			["wep", "srifle_GM6_SOS_F", 1, 5],
			["wep", "srifle_DMR_01_SOS_F", 1, 5],
			["wep", "srifle_EBR_SOS_F", 1, 5],
			["itm", "optic_SOS", 2]
			["itm", "optic_LRPS", 2]
			//["wep", "LMG_Mk200_F", 1, 4],
			//["wep", "LMG_Zafir_F", 1, 4],
			//["mag", "150Rnd_762x51_Box", 1],
			["mag", "10Rnd_762x51_Mag", 5],
			["mag", "7Rnd_408_Mag", 5]
			["mag", "5Rnd_127x108_Mag", 5]
		];
	};
    case "mission_USSpecial2":
	{
	_boxItems =
		[
			// Item type, Item class, # of items, # of magazines per weapon
			["wep", "Rangefinder", 2],
			//["wep", "hgun_Pistol_heavy_02_Yorris_F", 1, 5],
			["mag", "150Rnd_762x51_Box", 3],
			["mag", "10Rnd_762x51_Mag", 5],
			["wep", "LMG_Zafir_F", 2, 5],
			["wep", "LMG_Mk200_F", 1, 4],
			["mag", "ClaymoreDirectionalMine_Remote_Mag", 3],
		];
	};
	case "mission_Main_A3snipers":
	{
	_boxItems =
		[
			// Item type, Item class, # of items, # of magazines per weapon
			["wep", "srifle_LRR_SOS_F", 1, 7],
			["wep", "srifle_GM6_SOS_F", 1, 7],
			["wep", "srifle_EBR_F", 1, 7],
			["wep", "srifle_DMR_01_F", 1, 7],
			["wep", "Rangefinder", 2],
			["itm", "optic_DMS", 1]
		];
	};
};

[_box, _boxItems] call processItems;
