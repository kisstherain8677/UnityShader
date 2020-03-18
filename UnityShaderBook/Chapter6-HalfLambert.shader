// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unity Shaders Book/Chapter 6/HalfLambert"
{
   Properties{
		_Diffuse("Diffuse",Color)=(1,1,1,1)
	}

	SubShader{
		pass{
			Tags{"LightMode"="ForwardBase"}//光照模式 用于得到unity的一些内置变量

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag 
			#include "Lighting.cginc"

			fixed4 _Diffuse;//材质的漫反射属性

			struct a2v{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
			};

			struct v2f{
				float4 pos:SV_POSITION;
				fixed3 worldNormal:TEXCOORD0;
			};

			v2f vert(a2v v){
				v2f o;

				o.pos=UnityObjectToClipPos(v.vertex);

				o.worldNormal=mul(v.normal,(float3x3)unity_WorldToObject);

				
				
				return o;
			}

			fixed4 frag(v2f i):SV_Target{
				
				//得到环境光
				fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.xyz;

				
				fixed3 worldnormal=normalize(i.worldNormal);

				//得到光源方向
				fixed3 worldLight=normalize(_WorldSpaceLightPos0.xyz);

				//计算反射光
				fixed3 diffuse=_LightColor0.rgb*_Diffuse.rgb*(dot(worldnormal,worldLight)*0.5+0.5);
				fixed3 color=ambient+diffuse;

				return fixed4(color,1.0);
			}

			ENDCG
		}
	}
}
