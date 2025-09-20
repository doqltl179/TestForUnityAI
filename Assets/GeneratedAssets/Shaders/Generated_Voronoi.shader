
Shader "Custom/VoronoiShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _VoronoiScale ("Voronoi Scale", Float) = 5.0
        _VoronoiSpeed ("Voronoi Speed", Float) = 1.0
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
            float3 fractionalPart = frac(float3(uv, time)); // Renamed variable to avoid conflict
            float3 dist = fractionalPart - 0.5;
            float voronoi = min(min(dot(dist, dist), dot(dist + float3(1, 0, 0), dist + float3(1, 0, 0))), dot(dist + float3(0, 1, 0), dist + float3(0, 1, 0)));
            o.Albedo = voronoi;
            o.Metallic = 0.0;
            o.Smoothness = 0.5;
        }
        ENDCG
    }
    FallBack "Diffuse"
}