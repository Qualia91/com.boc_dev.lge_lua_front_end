
-- require objects
local IMPORTS = require("imports")
local GAME_CREATION = require("game_creation")
local GAME_UTILS = require("game_utils")

-- require scenes
local boid_scene = require("boid_layer")

-- create scenes as layers, with a layer name
local boid_layer = boid_scene.create("MAIN")

-- create iterator functions for each of the layers
-- inputs are layer name and a function to run
GAME_CREATION.set_scene_iterator_function(
    "MAIN",
    function(time, registry)
        -- this function will run every iteration 
        -- time is current time step
        -- registry is the layer registry where you can get layer objects and affect them
        if (time == 100) then
            print("Timestep is 100, welcome to lua land")
        end
    end)

-- add layers to scene in order of rendering
local scenes = {boid_layer}

-- create window init params
local wip = luajava.newInstance("com.boc_dev.graphics_library.WindowInitialisationParametersBuilder")
wip:setLockCursor(true):setWindowWidth(1000):setWindowHeight(800):setDebug(true)

-- create game
GAME_CREATION.create(wip, scenes)