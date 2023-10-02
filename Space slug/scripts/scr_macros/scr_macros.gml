#macro collision obj_collision
#macro dropoff (-power(clamp(point_distance(x,y,camera.camX,camera.camY) / 500,0,1),2) + 1)

global.settings = true;