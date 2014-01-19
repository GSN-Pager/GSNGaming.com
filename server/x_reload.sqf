_playerMoney = player getVariable "cmoney";
_vehicle = _this;
if(player == driver _vehicle) then {
	if (_playerMoney < 30) then {hint format["You don't have enough money to repair you vehicle"];
	_vehicle vehicleChat format ["You don't have enough money to repair your vehicle"];
    } else {
	//_vehicle = _this;
	//disableUserinput true;
	player setVariable["cmoney",(player getVariable "cmoney")-25,true];
	_vehicle setVelocity [0,0,0];
	_vehicle setFuel 0;
	_type = typeOf _vehicle;

	x_reload_time_factor = 2.5;

	_vehicle setVehicleAmmo 1;

	_vehicle vehicleChat format ["Servicing %1... Please stand by...", _type];

	_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

		if (count _magazines > 0) then {
			_removed = [];
				{
					if (!(_x in _removed)) then {
					_vehicle removeMagazines _x;
					_removed = _removed + [_x];
					};
				} forEach _magazines;
			{
				_vehicle vehicleChat format ["Reloading %1", _x];
				sleep x_reload_time_factor;
				_vehicle addMagazine _x;
			} forEach _magazines;
        	};

		_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

		if (_count > 0) then {
			for "_i" from 0 to (_count - 1) do {
				scopeName "xx_reload2_xx";
				_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
				_magazines = getArray(_config >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
					_vehicle removeMagazines _x;
					_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_vehicle vehicleChat format ["Reloading %1", _x];
					sleep x_reload_time_factor;
					_vehicle addMagazine _x;
					sleep x_reload_time_factor;
				} forEach _magazines;
				_count_other = count (_config >> "Turrets");
				if (_count_other > 0) then {
					for "_i" from 0 to (_count_other - 1) do {
						_config2 = (_config >> "Turrets") select _i;
						_magazines = getArray(_config2 >> "magazines");
						_removed = [];
						{
							if (!(_x in _removed)) then {
							_vehicle removeMagazines _x;
							_removed = _removed + [_x];
							};
						} forEach _magazines;
					{
						_vehicle vehicleChat format ["Reloading %1", _x];
						sleep x_reload_time_factor;
						_vehicle addMagazine _x;
						sleep x_reload_time_factor;
					} forEach _magazines;
					};
				};
			};
		};
		_vehicle setVehicleAmmo 1;	// Reload turrets / drivers magazine

		sleep x_reload_time_factor;
		_vehicle vehicleChat "Repairing...";
		_vehicle setDamage 0;
		sleep x_reload_time_factor;
		_vehicle vehicleChat "Refueling...";
		while {fuel _vehicle < 0.99} do {
			//_vehicle setFuel ((fuel _vehicle + 0.1) min 1);
			_vehicle setFuel 1;
			sleep 0.01;
		};
		sleep x_reload_time_factor;
		_vehicle vehicleChat format ["%1 is ready...", _type];
		//disableUserinput false;
		if (true) exitWith {};
    };
};