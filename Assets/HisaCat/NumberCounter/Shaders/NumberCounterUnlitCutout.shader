// HisaCat's Number Counter
// https://github.com/hisacat/Unity-NumberCounterShader
// Contacts:
//     HisaCat
//     Twitter: https://twitter.com/ahisacat
//     Discord: https://github.com/hisacat

// MIT License
//
// Copyright (c) 2024 HisaCat
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

Shader "HisaCat/Number Counter Unlit Cutout" {
    Properties {
        [HDR]_Color ("Color", Color) = (1, 1, 1, 1)
        [NoScaleOffset]_SpriteSheet ("Sprite Sheet", 2D) = "white" { }
        [IntRange]_DisplayLength ("Display Length", Range(1, 6)) = 3
        _Value ("Value", Float) = 1
        [Enum(Fill Zeros, 0, Left, 1, Right, 2)]_Align ("Align", Float) = 0
        [Enum(UnityEngine.Rendering.CullMode)]_Culling ("Culling", Float) = 2
    }

    SubShader {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" "PreviewType" = "Plane" }
        LOD 100

        Cull [_Culling]
        ZWrite Off
        Lighting Off
        Blend SrcAlpha OneMinusSrcAlpha
        
        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "NumberCounter.cginc"

            fixed4 frag(v2f i) : SV_Target {
                DigitArray digitArray = FloatToDigitArray(_Value, _DisplayLength, _Align);
                fixed4 digitColor = CalculateDigitColor(edgePadding, i.uv, _DisplayLength, digitArray.digits);
                
                clip(digitColor.a - 0.5); // Apply alpha cutout (threshold set to 0.5)
                fixed4 color = digitColor * _Color * i.color;
                color.a = _Color.a * i.color.a;

                return color;
            }
            ENDCG
        }
    }

    FallBack "Diffuse"
}