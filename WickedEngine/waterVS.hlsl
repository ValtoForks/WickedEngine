#include "objectHF.hlsli"

PixelInputType main(Input_Object_POS_TEX input)
{
	PixelInputType Out;
	
	float4x4 WORLD = MakeWorldMatrixFromInstance(input.inst);
	VertexSurface surface = MakeVertexSurfaceFromInput(input);
		
	surface.position = mul(surface.position, WORLD);
	surface.normal = normalize(mul(surface.normal, (float3x3)WORLD));

	Out.clip = 0;
		
	Out.pos = Out.pos2D = mul(surface.position, g_xCamera_VP);
	Out.pos2DPrev = Out.pos2D; // no need for water
	Out.pos3D = surface.position.xyz;
	Out.color = surface.color;
	Out.uvsets = surface.uvsets;
	Out.atl = 0;
	Out.nor = surface.normal;
	Out.nor2D = mul(Out.nor.xyz, (float3x3)g_xCamera_View).xy;

	Out.ReflectionMapSamplingPos = mul(surface.position, g_xFrame_MainCamera_ReflVP);

	return Out;
}