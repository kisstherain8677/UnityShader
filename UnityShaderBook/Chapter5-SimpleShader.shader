// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unity Shaders Book/Chapter 5/Simple Shader"
{

	Properties{
		_Color("Color Tint",Color) = (1.0,1.0,1.0,1.0)
	}

		SubShader
	{
		Pass
	{
		CGPROGRAM
		
		#pragma vertex vert
		#pragma fragment frag

		fixed4 _Color;
		struct a2v {
		   float4 vertex:POSITION;//用模型空间的顶点填充vertex变量
		   float3 normal:NORMAL;//用模型空间的法线填充normal变量
		   float4 texcoord:TEXCOORD0;//用模型空间的第一套纹理坐标填充textcoord变量
		};

		
        //顶点着色器的输出
		struct v2f {
			float4 pos:SV_POSITION;//pos包含了顶点在剪裁空间中的位置信息
			fixed3 color : COLOR0;//存储颜色信息
		};

		v2f vert(a2v v){
			v2f o;
			o.pos= UnityObjectToClipPos(v.vertex);//转换坐标
			o.color = v.normal*0.5 + fixed3(0.5, 0.5, 0.5);//映射到0 1
			return o;
		}

		fixed4 frag(v2f i) : SV_Target{
			fixed3 c = i.color;
			c *= _Color.rgb;
			return fixed4(c,1.0);
		}

		ENDCG
	}
        
    }
    
}
