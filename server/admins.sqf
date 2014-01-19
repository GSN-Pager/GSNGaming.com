if (!isServer) exitWith {};

if (loadFile (externalConfigFolder + "\admins.sqf") != "") then
{
    call compile preprocessFileLineNumbers (externalConfigFolder + "\admins.sqf");
} else {

	// Low Administrators: manage & spectate players, remove hacked vehicles
	lowAdmins =
	[
	"76561198039468603", //8603 = JackDee
	"76561197974325742", //5742 = Poppy
	//"76561198018964268", //4268 = Pager
	"76561198016350169", //0169 = Troutman
	"76561198041728491"  //8491 = SilentOperator6
	];

	// High Administrators: manage & spectate players, remove hacked vehicles, show player tags
	highAdmins =
	[
	// Put player UIDs here
	];

	// Server Owners: access to everything
	serverOwners =
	[
	"76561197963035830", //5830 = Headword
	"76561197962768890", //8890 = LightEightSix
	"76561198023400574", //0574 = Paronity
	"76561197994685469", //5469 = PaladinZero
	"76561198018964268", //4268 = Pager
	"76561197978927617"  //7617 = BadBadRobot
	];
};

if (typeName lowAdmins == "ARRAY") then { lowAdmins = compileFinal str lowAdmins };
if (typeName highAdmins == "ARRAY") then { highAdmins = compileFinal str highAdmins };
if (typeName serverOwners == "ARRAY") then { serverOwners = compileFinal str serverOwners };

publicVariable "lowAdmins";
publicVariable "highAdmins";
publicVariable "serverOwners";