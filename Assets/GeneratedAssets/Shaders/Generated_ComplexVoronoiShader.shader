Shader "Custom/ComplexVoronoiShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _VoronoiScale ("Voronoi Scale", Float) = 5.0
        _VoronoiSpeed ("Voronoi Speed", Float) = 1.0
        _Color1 ("Color 1", Color) = (1, 0, 0, 1)
        _Color2 ("Color 2", Color) = (0, 0, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;
        float _VoronoiScale;
        float _VoronoiSpeed;
        fixed4 _Color1;
        fixed4 _Color2;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float time = _Time.y * _VoronoiSpeed;
            float2 uv = IN.uv_MainTex * _VoronoiScale;
            float3 cell = floor(float3(uv, time));
            float3 fractionalPart = frac(float3(uv, time));
            float3 dist = fractionalPart - 0.5;

            // Calculate Voronoi pattern
            float voronoi = min(min(dot(dist, dist), dot(dist + float3(1, 0, 0), dist + float3(1, 0, 0))), dot(dist + float3(0, 1, 0), dist + float3(0, 1, 0)));

            // Add complexity with sine waves
            float pattern = sin(voronoi * 10.0) * 0.5 + 0.5;

            // Sample the _MainTex texture
            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex);

            // Blend colors based on the pattern and texture
            o.Albedo = lerp(_Color1.rgb, _Color2.rgb, pattern) * texColor.rgb;
            o.Metallic = 0.0;
            o.Smoothness = 0.5;
        }
        ENDCG
    }
    FallBack "Diffuse"
}