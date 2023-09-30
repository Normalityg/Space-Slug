function animTracker(_length) constructor{ // Timer for tracking the progress of an animation. Length is in seconds
  
  trackerStart = current_time; // Time the anim started
  length = _length * 1000; // How long the anim lasts in ms
  
  progress = function(){ // Function to check how far along an anim is
    return(clamp((current_time - trackerStart) / length, 0, 1));
  }
}