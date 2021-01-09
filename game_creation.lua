local game_creation = {}

game_creation.scene_runtime_iterators = {}

game_creation.set_scene_iterator_function = function(layer_name, iterator_func)
	game_creation.scene_runtime_iterators[layer_name] = iterator_func
end

-- create game with window init params and table of scenes in order
game_creation.create = function(wip, scenes) 

	local sceneLayers = luajava.newInstance("java.util.ArrayList")

	for index, scene in ipairs(scenes) do

		-- init a default lua iterator function for this scene if not already set
		-- if not game_creation.scene_runtime_iterators[scene:getLayerName()] then
		-- 	game_creation.scene_runtime_iterators[scene:getLayerName()] = {}
		-- 	game_creation.scene_runtime_iterators[scene:getLayerName()].iterate = function(time, registry) end
		-- end

		sceneLayers:add(scene);

		-- create lua gcs system
		local lua_system = {}

		function lua_system.update(time, components, registry)
			-- have lua gcs system run lua iterator function so users have an iteration function easy to use
		    --game_creation.scene_runtime_iterators[scene:getLayerName()].iterate(time, registry)
		    game_creation.scene_runtime_iterators[scene:getLayerName()](time, registry)
		end

		local luaGcsSystem = luajava.createProxy("com.boc_dev.lge_model.systems.GcsSystem",  lua_system)

		-- add system to game engine
		scene:getGcsSystems():add(luaGcsSystem)

	end

	-- create game loop
	local gameLoop = luajava.newInstance("com.boc_dev.lge_core.GameLoop",
	        sceneLayers,
	        wip:build()
	)

	gameLoop:start();
	
end

return game_creation