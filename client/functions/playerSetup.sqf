//	@file Name: playerSetup.sqf
//	@file Author: [GoT] JoSchaap
//	@file Modified: [GSN] Pager

_player = _this;
_player setskill 0;
{_player disableAI _x} foreach ["move","anim","target","autotarget"];
_player setVariable ["BIS_noCoreConversations", true];
_player allowDamage false;

enableSentences false;

removeAllWeapons _player;
removeUniform _player;
removeVest _player;
removeBackpack _player;
removeHeadgear _player;
removeGoggles _player;
removeAllAssignedItems _player;

switch (playerSide) do
{
	case BLUFOR:
	{
		if (typeof _player == "B_sniper_F") then {
			_player addUniform "U_B_Ghilliesuit";
			_player addVest "V_PlateCarrierGL_rgr";
		};
		if (typeof _player == "B_recon_F") then {
			_player addUniform "U_B_CombatUniform_mcam";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_MilCap_rucamo";
		};
		if (typeof _player == "B_medic_F") then {
			_player addUniform "U_B_CombatUniform_mcam";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_MilCap_rucamo";
		};
		if (typeof _player == "B_soldier_repair_F") then {
			_player addUniform "U_B_CombatUniform_mcam";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_MilCap_rucamo";
		};
	};

	case OPFOR:
	{
		if (typeof _player == "O_sniper_F") then {
			_player addUniform "U_O_Ghilliesuit";
			_player addVest "V_PlateCarrierGL_rgr";
		};
		if (typeof _player == "O_recon_F") then {
			_player addUniform "U_O_CombatUniform_ocamo";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_Watchcap_camo";
		};
		if (typeof _player == "O_medic_F") then {
			_player addUniform "U_O_CombatUniform_ocamo";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_Watchcap_camo";
		};
		if (typeof _player == "O_soldier_repair_F") then {
			_player addUniform "U_O_CombatUniform_ocamo";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_Watchcap_camo";
		};
	};

	default
	{
		if (typeof _player == "I_sniper_F") then {
			_player addUniform "U_I_Ghilliesuit";
			_player addVest "V_PlateCarrierGL_rgr";
		};
		if (typeof _player == "I_Spotter_F") then {
			_player addUniform "U_I_CombatUniform";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_Shemag_khk";
		};
		if (typeof _player == "I_medic_F") then {
			_player addUniform "U_I_CombatUniform";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_Shemag_khk";
		};
		if (typeof _player == "I_soldier_repair_F") then {
			_player addUniform "U_I_CombatUniform";
			_player addVest "V_PlateCarrierGL_rgr";
			_player addHeadgear "H_Shemag_khk";
		};
	};
};

// remove GPS (GPS is found as loot in buildings)
sleep 0.1;
_player unAssignItem "ItemRadio";
_player removeItem "ItemRadio";
_player unassignItem "ItemGPS";
_player removeItem "ItemGPS";

private "_nvgClass";
switch (side _player) do
{
	case OPFOR: { _nvgClass = "NVGoggles_OPFOR" };
	case INDEPENDENT: { _nvgClass = "NVGoggles_INDEP" };
	default { _nvgClass = "NVGoggles" };
};

// # Remove NVGs #########
{
	if (["NVGoggles", _x] call fn_findString != -1) then
	{
		_player unassignItem _x;
		_player removeItem _x;
	};
} forEach assignedItems _player;

// #######################

// # Add NVGs ############
// _player linkItem _nvgClass;
// #######################

_player addItem "ItemMap";
_player assignItem "ItemMap";
_player addItem "ItemCompass";
_player assignItem "ItemCompass";
_player addItem "ItemWatch";
_player assignItem "ItemWatch";

_player addBackpack "B_Carryall_oucamo";
_player addMagazine "20Rnd_762x51_Mag";
_player addMagazine "20Rnd_762x51_Mag";
_player addMagazine "20Rnd_762x51_Mag";
_player addMagazine "20Rnd_762x51_Mag";
_player addMagazine "20Rnd_762x51_Mag";
_player addWeapon "srifle_EBR_DMS_F";
_player addWeapon "hgun_Pistol_heavy_01_F";
_player addMagazine "11Rnd_45ACP_Mag";
_player addMagazine "11Rnd_45ACP_Mag";
_player addMagazine "11Rnd_45ACP_Mag";
_player addMagazine "11Rnd_45ACP_Mag";
_player addMagazine "11Rnd_45ACP_Mag";
_player addItem "FirstAidKit";
_player addItem "FirstAidKit";
_player selectWeapon "hgun_Pistol_heavy_01_F";

_player addrating 9999999;

thirstLevel = 100;
hungerLevel = 100;

[objNull, _player] call mf_player_actions_refresh;
[] execVM "client\functions\playerActions.sqf";

_player groupChat format["GSNGaming.com A3WL Zargabad - Initialization Complete"];
playerSetupComplete = true;