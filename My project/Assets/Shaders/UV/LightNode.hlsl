#ifndef CUSTOM_LIGHTING_INCLUDED
#define CUSTOM_LIGHTING_INCLUDED
#ifndef SHADERGRAPH_PREVIEW
#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
#if (SHADERPASS != SHADERPASS_FORWARD)
#undef REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
#endif
#endif

struct CustomLightingData
{
	float3 positionWS;
};


float3 CalculateCustomLighting(CustomLightingData data)
{
	float3 color = 0;
#ifndef SHADERGRAPH_PREVIEW

	uint lightsCount = GetAdditionalLightsCount();
	for (uint i = 0; i < lightsCount; i++)
	{
		Light light = GetAdditionalLight(i,data.positionWS);
		color += light.distanceAttenuation * light.shadowAttenuation;
	}
#endif
	return color;

}

void CalculateCustomLighting_float(in float3 Position, out float GrayScale)
{
	CustomLightingData data;
	data.positionWS = Position;

#ifdef SHADERGRAPH_PREVIEW

#else

	float2 lightmapUV;
	float2 LightmapUV;
	OUTPUT_LIGHTMAP_UV(LightmapUV, unity_LightmapST, lightmapUV);

#endif
	GrayScale = CalculateCustomLighting(data).x;
}

float3 WorldToScreenPos(float3 pos) {
	pos = normalize(pos - _WorldSpaceCameraPos) * (_ProjectionParams.y + (_ProjectionParams.z - _ProjectionParams.y)) + _WorldSpaceCameraPos;
	float3 uv = 0;
	float3 toCam = mul(unity_WorldToCamera, pos);
	float camPosZ = toCam.z;
	float height = 2 * camPosZ / unity_CameraProjection._m11;
	float width = _ScreenParams.x / _ScreenParams.y * height;
	uv.x = (toCam.x + width / 2) / width;
	uv.y = (toCam.y + height / 2) / height;
	uv.z = toCam.x;
	return uv;
}

float3 ObjectScale() {
	return float3(
		length(unity_ObjectToWorld._m00_m10_m20),
		length(unity_ObjectToWorld._m01_m11_m21),
		length(unity_ObjectToWorld._m02_m12_m22)
		);
}
void CalculateCustomVolumetricLighting_float(in float3 camPos, in float depth,in float3 origin, in float3 direction, in float step, out float grayScale)
{
	step *= length(ObjectScale()) * 0.25f;
	float3 cameraDir = mul(float3(0, 0, -1), (float3x3)UNITY_MATRIX_V);
	grayScale = 0;
	for (int i = 0; i < 50; i++)
	{
		float3 p = origin - direction * i * step;
		float r;
		CalculateCustomLighting_float(p,r);
		grayScale = max(grayScale,r);
		float pointDepth = dot(normalize(p - camPos), cameraDir) * distance(camPos, p);
		if (pointDepth > depth)
		{
			grayScale = 0;
		}
	}
}
#endif