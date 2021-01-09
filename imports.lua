local imports = {

    VEC3F = luajava.bindClass("com.boc_dev.maths.objects.vector.Vec3f"),
    QUATERNION_F = luajava.bindClass("com.boc_dev.maths.objects.QuaternionF"),
    MATRIX_4F = luajava.bindClass("com.boc_dev.maths.objects.matrix.Matrix4f"),
    LIGHTING_TYPE = luajava.bindClass("com.boc_dev.lge_model.generated.enums.LightingType"),
    SKYBOX_TYPE = luajava.bindClass("com.boc_dev.lge_model.generated.enums.SkyboxType"),
    CAMERA_PROJECTION_TYPE = luajava.bindClass("com.boc_dev.lge_model.generated.enums.CameraProjectionType"),
    CAMERA_OBJECT_TYPE = luajava.bindClass("com.boc_dev.lge_model.generated.enums.CameraObjectType"),
    MATH = luajava.bindClass("java.lang.Math")

}

return imports