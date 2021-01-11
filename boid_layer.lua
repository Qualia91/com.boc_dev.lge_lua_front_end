local IMPORTS = require("imports")
local GAME_UTILS = require("game_utils")

local boid_layer = {}

boid_layer.create = function(layer_name)

    local transformBuilder = luajava.newInstance( "com.boc_dev.maths.objects.srt.TransformBuilder")
    local ambientLight = luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 0.1, 0.1, 0.1)
    local fog = luajava.newInstance( "com.boc_dev.graphics_library.objects.lighting.Fog", true, ambientLight, 0.0001)
    local mainSceneLayer = luajava.newInstance( "com.boc_dev.lge_core.SceneLayer", layer_name, ambientLight, fog)

    local lightObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.LightObject",
            mainSceneLayer:getRegistry(),
            "MyFirstLight",
            0.25,
            0.5,
            1,
            IMPORTS.VEC3F.X,
            0.1,
            IMPORTS.VEC3F.Z:neg(),
            1000,
            IMPORTS.LIGHTING_TYPE.SPOT
    )

    local directLightObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.LightObject",
            mainSceneLayer:getRegistry(),
            "MySecondLight",
            0.25,
            0.5,
            1,
            luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 0.529, 0.808, 0.922),
            0.2,
            IMPORTS.VEC3F.Z:neg():add(IMPORTS.VEC3F.X),
            1,
            IMPORTS.LIGHTING_TYPE.DIRECTIONAL
    )

    local skyBoxObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.SkyBoxObject",
            mainSceneLayer:getRegistry(),
            "SKY_BOX",
            1000,
            IMPORTS.SKYBOX_TYPE.SPHERE,
            "/textures/bw_gradient_skybox.png"
    )

    local cameraTransform = transformBuilder
            :setPosition(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", -10, 0, 0))
            :setScale(IMPORTS.VEC3F.ONE)
            :setRotation(GAME_UTILS.camera_rotation):build()

    local cameraObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.CameraObject",
            mainSceneLayer:getRegistry(),
            "Camera",
            IMPORTS.CAMERA_PROJECTION_TYPE.PERSPECTIVE,
            IMPORTS.CAMERA_OBJECT_TYPE.PRIMARY,
            10000,
            1.22,
            800,
            1,
            1000
    )

    local controllableObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.ControllableObject",
            mainSceneLayer:getRegistry(),
            "Camera controller",
            true,
            true,
            0.01,
            1)

    local cameraTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
            mainSceneLayer:getRegistry(),
            "CameraTransform",
            cameraTransform:getPosition(),
            cameraTransform:getRotation(),
            cameraTransform:getScale());

    controllableObject:getUpdater():setParent(cameraTransformObject):sendUpdate()

    lightObject:getUpdater():setParent(cameraTransformObject):sendUpdate()
    cameraObject:getUpdater():setParent(cameraTransformObject):sendUpdate()

    local basicMaterial = GAME_UTILS.create_basic_material(mainSceneLayer)

    mainSceneLayer:getGcsSystems():add(luajava.newInstance("com.boc_dev.lge_systems.boids.BoidSystem"))

    local random = luajava.newInstance("java.util.Random")

    for i = 1, 10 do

        for j = 1, 10 do

            for k = 1, 10 do


                local build = transformBuilder:reset():setPosition(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", i * 4, j * 4, k * 4)):build();


                local newTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
                        mainSceneLayer:getRegistry(),
                        "TransformObject" .. i,
                        build:getPosition(),
                        build:getRotation(),
                        build:getScale());

                local newGeometryObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.GeometryObject",
                        mainSceneLayer:getRegistry(),
                        "Geometry" .. i,
                        IMPORTS.MATRIX_4F.Identity,
                        basicMaterial,
                        "DEFAULT_SPHERE"
                );

                local boidObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.BoidObject",
                        mainSceneLayer:getRegistry(),
                        "Boid" .. i,
                        0.001,
                        0.1,
                        luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", random:nextInt(10) - 5, random:nextInt(10) - 5, random:nextInt(10) - 5),
                        400,
                        10,
                        10,
                        0.001,
                        2,
                        50,
                        IMPORTS.VEC3F.ZERO,
                        0.001
                );
                newGeometryObject:getUpdater():setParent(newTransformObject):sendUpdate();
                boidObject:getUpdater():setParent(newTransformObject):sendUpdate();

            end
        end
    end

    lightObject:getUpdater():setParent(cameraTransformObject):sendUpdate();
    cameraObject:getUpdater():setParent(cameraTransformObject):sendUpdate();
    controllableObject:getUpdater():setParent(cameraTransformObject):sendUpdate();

    return mainSceneLayer

end

return boid_layer
