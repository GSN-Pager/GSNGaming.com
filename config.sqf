//	@file Version: 1.0
//	@file Name: config.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:13
//	@file Description: Main config.

// For SERVER CONFIG, values are in server\init.sqf

// Towns and cities array
// Marker Name, Diameter, City Name
cityList = compileFinal str
[
["Town_1", 420, "Zargabad"],
["Town_2", 140, "Pager's Villa"],
["Town_3", 140, "Yarum"],
["Town_4", 200, "Airport North"],
["Town_5", 200, "Airport South"],
["Town_6", 140, "SE Zargabad"],
["Town_7", 120, "NE Zargabad"],
["Town_8", 120, "NW Zargabad"],
["Town_9", 400, "Nango"],
["Town_10", 280, "Azizayt"],
["Town_11", 260, "Hazar Bagh"],
["Town_12", 360, "Military Base"],
["Town_13", 240, "Hilltown"],
["Town_14", 300, "Trout's Bar & Grill"],
["Town_15", 240, "Shahbaz"],
["Town_16", 360, "Firuz Baharv"],
["Town_17", 260, "GSN Village"],
["Town_18", 200, "Camp Gamer"],
["Town_19", 380, "Midway"],
["Town_20", 140, "Lanville"],
["Town_21", 140, "Eastern Tower #5"],
["Town_22", 160, "Southern Base"],
["Town_23", 160, "Northern Base"],
["Town_24", 140, "Western Tower #3"],
["Town_25", 100, "Old Rusty Tower"] //5600 Sq. Meters
];

militarylist = compileFinal str
[
["milSpawn_1"],
["milSpawn_2"],
["milSpawn_3"],
["milSpawn_4"],
["milSpawn_5"]
];

cityLocations = [];

config_items_jerrycans_max = compileFinal "1";
config_items_syphon_hose_max = compileFinal "1";

config_refuel_amount_default = compileFinal "0.25";
config_refuel_amounts = compileFinal str
[
["Quadbike_01_base_F", 0.50],
["Tank", 0.10],
["Air", 0.10]
];

// Is player saving enabled?
config_player_saving_enabled = compileFinal "0";

// Can players get extra in-game cash at spawn by donating?
config_player_donations_enabled = compileFinal "0";

// How much do players spawn with?
config_initial_spawn_money = compileFinal "250";

config_territory_markers = compileFinal str
[
["TERRITORY_PALACE", "Poppy's Palace", 500, "PALACE"],
["TERRITORY_VILLA", "Pager's Villa", 250, "VILLA"],
["TERRITORY_TOWERS", "Twin Cargo Towers", 250, "RESEARCH"],
["TERRITORY_AIRPORT_NORTH", "Airport North", 250, "AIRPORT"],
["TERRITORY_ATC", "Air Traffic Control", 500, "AIRPORT"],
["TERRITORY_AIRPORT_SOUTH", "Airport South", 250, "AIRPORT"],
["TERRITORY_MILITARY_BASE", "Military Base", 500, "MILITARY"],
["TERRITORY_NANGO", "Nango Plant", 250, "CITY"],
["TERRITORY_AZIZAYT", "Camp Azizayt", 300, "CITY"],
["TERRITORY_GAMER", "Camp Gamer", 300, "CITY"],
["TERRITORY_TROUTMAN", "Trout's Bar & Grill", 250, "CITY"] //,
/*["TERRITORY_KILLFARM", "Kill Farm", 250, "RESEARCH"]*/
];