local IMPORTS = require("imports")

local game_utils = {}

-- create camera rotations
local quaternionX = IMPORTS.QUATERNION_F:RotationX(IMPORTS.MATH:toRadians(-90))
local quaternionY = IMPORTS.QUATERNION_F:RotationY(IMPORTS.MATH:toRadians(180))
local quaternionZ = IMPORTS.QUATERNION_F:RotationZ(IMPORTS.MATH:toRadians(90))
game_utils.camera_rotation = quaternionZ:multiply(quaternionY):multiply(quaternionX)

game_utils.create_basic_material = function(sceneLayer)
    local materialObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.MaterialObject",
            sceneLayer:getRegistry(),
            "Material",
            luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 1, 1, 1),
            1,
            1,
            luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 1, 1, 1)
    )

    local textureObjectVisual = luajava.newInstance("com.boc_dev.lge_model.generated.components.TextureObject",
            sceneLayer:getRegistry(),
            "VisualTextureOne",
            "/textures/brickwall.jpg"
    )

    local normalMapObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.NormalMapObject",
            sceneLayer:getRegistry(),
            "NormalTextureOne",
            "/normalMaps/brickwall_normal.jpg"
    )

    textureObjectVisual:getUpdater():setParent(materialObject):sendUpdate()
    normalMapObject:getUpdater():setParent(materialObject):sendUpdate()

    return materialObject:getUuid()
end

game_utils.create_material = function(sceneLayer, name, texture, normal_texture)
    local materialObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.MaterialObject",
            sceneLayer:getRegistry(),
            name,
            luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 1, 1, 1),
            1,
            1,
            luajava.newInstance( "com.boc_dev.maths.objects.vector.Vec3f", 1, 1, 1)
    )

    local textureObjectVisual = luajava.newInstance("com.boc_dev.lge_model.generated.components.TextureObject",
            sceneLayer:getRegistry(),
            texture,
            texture
    )

    local normalMapObject = luajava.newInstance("com.boc_dev.lge_model.generated.components.NormalMapObject",
            sceneLayer:getRegistry(),
            normal_texture,
            normal_texture
    )

    textureObjectVisual:getUpdater():setParent(materialObject):sendUpdate()
    normalMapObject:getUpdater():setParent(materialObject):sendUpdate()

    return materialObject:getUuid()
end

return game_utils