function shake_camera(_shakeFrequency,_shakeDirection = irandom_range(0,360)){
		// Dont shake the screen when the game is paused
	//if (global.gameSpeed = 0)exit;
		// Add variance to the frequecy
	_shakeFrequency += (random_range(-_shakeFrequency,_shakeFrequency) / 10); // 10% variance
		// Damp frequency based on current frequency
	_shakeFrequency = _shakeFrequency * (1 - camera.shakeFrequency / 45);
		// Stop frequecy from getting lowered if damped too hard
	if (_shakeFrequency < 0)_shakeFrequency = 0;
		// Add final frequecy to the camera frequency
	camera.shakeFrequency += _shakeFrequency;
	
	camera.shakeDirection = _shakeDirection + irandom_range(-camera.shakeVariance,camera.shakeVariance);
	camera.shakeTimer = 0.8;
	if (_shakeDirection > 90 && _shakeDirection <= 270)camera.shakeRollDirection = 1;
	else camera.shakeRollDirection = -1;
}