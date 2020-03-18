
Shader "Unlit/NewUnlitShader"//名称路径，可修改 前加Hidden可隐藏路径选项
{
	//属性
    Properties
    {
		_Color("Color",Color) = (1,1,1,1)//四个分量 红绿蓝透明 RGBA
		
    }
   
	//【shader核心算法实现的地方。可以有多个subshader，但是只能加载一个】
	SubShader
    {

        Pass
        {
           CGPROGRAM
		   #pragma vertex vert//声明顶点着色器
		   #pragma fragment frag//声明片段着色器

		   fixed4 _Color;//属性中的变量要再次声明floathalffixed都是浮点数
	       
	    struct appdata {//应用程序阶段的结构体
		     float4 vertex:POSITION;
			 float2 uv:TEXCOORD;
		   };
		 
		struct v2f//顶点着色器传递给片元着色器的结构体
		{
			float4 pos:SV_POSITION;
			float2 uv:TEXCOORD;
		};

		v2f vert(appdata v)//几何阶段中 顶点着色器 
		{
			v2f o;
			o.pos = UnityObjectToClipPos(v.vertex);
			o.uv = v.uv;
			return o;
		}

		fixed checker(float2 uv)
		{
			float2 repeatUV = uv * 10;
			float2 c = floor(repeatUV) / 2;
			float checker = frac(c.x + c.y) * 2;
			return checker;
		}

		fixed4 frag(v2f i):SV_Target//光栅化阶段 片元着色器
		{
			fixed col = checker(i.uv);
			return col;
		}
		   


		   ENDCG
        }
    }
	
}



