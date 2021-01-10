local IMPORTS = require("imports")
local GAME_UTILS = require("game_utils")

local gui_layer = {}

gui_layer.create = function(layer_name)

    local transformBuilder = luajava.newInstance( "com.boc_dev.maths.objects.srt.TransformBuilder")
    local ambientLight = luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 1, 1, 1)
    local mainSceneLayer = luajava.newInstance( "com.boc_dev.lge_core.SceneLayer", layer_name, ambientLight, IMPORTS.FOG.NOFOG)

    local cameraTransform = transformBuilder
            :setPosition(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", -100, 0, 0))
            :setScale(IMPORTS.VEC3F.ONE)
            :setRotation(GAME_UTILS.camera_rotation):build()

    local cameraObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.CameraObject",
            mainSceneLayer:getRegistry(),
            "Camera",
            IMPORTS.CAMERA_PROJECTION_TYPE.ORTHOGRAPHIC,
            IMPORTS.CAMERA_OBJECT_TYPE.PRIMARY,
            1000,
            0,
            100,
            -1000,
            100
    )

    local cameraTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
            mainSceneLayer:getRegistry(),
            "CameraTransform",
            cameraTransform:getPosition(),
            cameraTransform:getRotation(),
            cameraTransform:getScale());

    cameraObject:getUpdater():setParent(cameraTransformObject):sendUpdate()

    local basicMaterial = GAME_UTILS.create_basic_material(mainSceneLayer)

    local selectedMaterial = GAME_UTILS.create_material(mainSceneLayer, "material1", "/textures/black.png", "/normalMaps/waterNormalMap.jpg")

    local guiSceneTransform = transformBuilder:reset()
                                              :setPosition(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 1000, 1000, -100))
                                              :build()

    local guiSceneTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
        mainSceneLayer:getRegistry(),
        "TransformObject",
        guiSceneTransform:getPosition(),
        guiSceneTransform:getRotation(),
        guiSceneTransform:getScale());

    local listObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.ListObject",
        mainSceneLayer:getRegistry(),
        "ListObject",
        0,
        -100,
        0,
        205
    );

    listObject:getUpdater():setParent(guiSceneTransformObject):sendUpdate();


    for i = 1, 3 do

        local listTransform = transformBuilder:reset():build();

            local listTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
                    mainSceneLayer:getRegistry(),
                    "ListTransformObject",
                    listTransform:getPosition(),
                    listTransform:getRotation(),
                    listTransform:getScale());

            local subListObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.ListObject",
                    mainSceneLayer:getRegistry(),
                    "SubListObject",
                    0,
                    -100,
                    0,
                    205
            );

            subListObject:getUpdater():setParent(listTransformObject):sendUpdate();
            listTransformObject:getUpdater():setParent(listObject):sendUpdate();

        for j = 1, 3 do

            local build = transformBuilder:reset():build();

            local newTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
                    mainSceneLayer:getRegistry(),
                    "TransformObject" .. i .. j,
                    build:getPosition(),
                    IMPORTS.QUATERNION_F.Identity,
                    build:getScale());

            local newGeometryObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.GeometryObject",
                    mainSceneLayer:getRegistry(),
                    "Geometry" .. i .. j,
                    IMPORTS.MATRIX_4F:Scale(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 200, 200, 200)),
                    basicMaterial,
                    "DEFAULT_SQUARE"
            );

            local selectableObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.SelectableObject",
                    mainSceneLayer:getRegistry(),
                    "Selectable " .. i .. j,
                    false,
                    selectedMaterial,
                    basicMaterial
            );

            local pickableObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.PickableObject",
                    mainSceneLayer:getRegistry(),
                    "Pickable " .. i .. j,
                    true
            );

            local buttonObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.ButtonObject",
                    mainSceneLayer:getRegistry(),
                    "buttonObj " .. i .. j,
                    true,
                    "Button Pressed " .. i .. j
            );

            local textTransform = transformBuilder:reset()
                    :setPosition(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 1, 0.5, 0.8))
                    :build();

            local textTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
                    mainSceneLayer:getRegistry(),
                    "TransformObject" .. i .. j,
                    textTransform:getPosition(),
                    IMPORTS.QUATERNION_F:RotationZ(IMPORTS.MATH.PI),
                    textTransform:getScale());

            local guiTextObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TextObject",
                    mainSceneLayer:getRegistry(),
                    "ButtonText" .. i .. j,
                    IMPORTS.FONT_ALIGNMENT.CENTER,
                    "montserrat_light",
                    20,
                    "Button " .. i .. j
            );

            textTransformObject:getUpdater():setParent(newTransformObject):sendUpdate();
            guiTextObject:getUpdater():setParent(textTransformObject):sendUpdate();
            newGeometryObject:getUpdater():setParent(newTransformObject):sendUpdate();
            newTransformObject:getUpdater():setParent(subListObject):sendUpdate();

            pickableObject:getUpdater():setParent(newGeometryObject):sendUpdate();
            selectableObject:getUpdater():setParent(newGeometryObject):sendUpdate();
            buttonObject:getUpdater():setParent(newGeometryObject):sendUpdate();

        end

    end

    local textTransform = transformBuilder:reset()
            :setRotation(IMPORTS.QUATERNION_F.Identity)
            :setPosition(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 0, 970, -700))
            :build();

    local textTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
            mainSceneLayer:getRegistry(),
            "TextTransformObject",
            textTransform:getPosition(),
            textTransform:getRotation(),
            textTransform:getScale());

    local guiTextObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TextObject",
            mainSceneLayer:getRegistry(),
            "GameEngineTimeText",
            IMPORTS.FONT_ALIGNMENT.BEGIN,
            "montserrat_light",
            30,
            "Hello, World!@!"
    );

    guiTextObject:getUpdater():setParent(textTransformObject):sendUpdate();

    local buttonResultTransform = transformBuilder:reset()
            :setRotation(IMPORTS.QUATERNION_F.Identity)
            :setPosition(luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 0, 970, -790))
            :build();

    local buttonResultTransformObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TransformObject",
            mainSceneLayer:getRegistry(),
            "buttonResultTransformObject",
            buttonResultTransform:getPosition(),
            buttonResultTransform:getRotation(),
            buttonResultTransform:getScale());

    local buttonResultTextObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.TextObject",
            mainSceneLayer:getRegistry(),
            "buttonResult",
            IMPORTS.FONT_ALIGNMENT.BEGIN,
            "montserrat_light",
            40,
            "Button Result"
    );

    buttonResultTextObject:getUpdater():setParent(buttonResultTransformObject):sendUpdate()

    mainSceneLayer:getGcsSystems():add(luajava.newInstance("com.boc_dev.lge_systems.control.SelectionSystem"))
    mainSceneLayer:getGcsSystems():add(luajava.newInstance("com.boc_dev.lge_systems.gui.ButtonSystem"))
    mainSceneLayer:getGcsSystems():add(luajava.newInstance("com.boc_dev.lge_systems.gui.TextChangeSystem"))
    mainSceneLayer:getGcsSystems():add(luajava.newInstance("com.boc_dev.lge_systems.gui.ListSystem"))

    return mainSceneLayer

end

return gui_layer
