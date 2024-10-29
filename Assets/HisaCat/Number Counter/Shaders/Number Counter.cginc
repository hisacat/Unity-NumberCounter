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

// Properties.
sampler2D _SpriteSheet;
float4 _SpriteSheet_ST;
float _Value;
float4 _Color;
uint _DisplayLength;
float _Align;

// Column and row count of sprite sheet.
static const uint column_count = 5;
static const uint row_count = 2;

// Digit size.
static const float digitWidth = 1.0 / column_count;
static const float digitHeight = 1.0 / row_count;

static const uint maxDigitCount = 6;

// Padding for prevent flickering on edges.
static const float edgePadding = (5.0 / 100) / 2; // use 5%.

#define USE_UV_PADDING

struct DigitArray {
    fixed digits[maxDigitCount];
};

struct appdata_t {
    float4 vertex : POSITION;
    float2 uv : TEXCOORD0;
    float4 color : COLOR;  // Particle color input

};

struct v2f {
    float2 uv : TEXCOORD0;
    float4 vertex : SV_POSITION;
    float4 color : COLOR;  // Passing the color to fragment shader

};

v2f vert(appdata_t v) {
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.uv = v.uv;
    o.color = v.color;  // Pass the vertex color to the fragment stage
    return o;
}

DigitArray FloatToDigitArray(float value, int displayLength, int aligin) {
    DigitArray result;
    int intValue = (int)value;
    
    // Initialize digits array for each digits and padding.
    for (uint j = 0; j < maxDigitCount; j++) result.digits[j] = -1; // Default value is -1 (means empty)

    // Take each digit and put it into an array.
    {
        //for (int k = displayLength - 1; k >= 0; k--) {
        //    if (intValue <= 0) break;
        //    result.digits[k] = intValue % 10u;
        //    intValue /= 10u;
        //}
        // hard-coding for avoid "unrolling failed" issue.
        {
            // Remember "maxDigitCount" is fixed to 6.
            #define SET_DIGIT(index) if (intValue > 0) { result.digits[index] = intValue % 10u; intValue /= 10u; }
            
            if (displayLength >= 6) {
                SET_DIGIT(5)
                SET_DIGIT(4)
                SET_DIGIT(3)
                SET_DIGIT(2)
                SET_DIGIT(1)
                SET_DIGIT(0)
            } else if (displayLength >= 5) {
                SET_DIGIT(4)
                SET_DIGIT(3)
                SET_DIGIT(2)
                SET_DIGIT(1)
                SET_DIGIT(0)
            } else if (displayLength >= 4) {
                SET_DIGIT(3)
                SET_DIGIT(2)
                SET_DIGIT(1)
                SET_DIGIT(0)
            } else if (displayLength >= 3) {
                SET_DIGIT(2)
                SET_DIGIT(1)
                SET_DIGIT(0)
            } else if (displayLength >= 2) {
                SET_DIGIT(1)
                SET_DIGIT(0)
            } else if (displayLength >= 1) {
                SET_DIGIT(0)
            }
        }
    }

    // Applying alignment.
    {
        if (aligin == 0) {
            // Align: Fill Zeros.
            //for (int j = 0; j < displayLength; j++) {
            //    if (result.digits[j] == -1) result.digits[j] = 0;
            //}
            // hard-coding for avoid "unrolling failed" issue.
            {
                // Remember "maxDigitCount" is fixed to 6.
                #define FILL_DIGIT_ZERO(index) if (result.digits[index] == -1) result.digits[index] = 0;
                
                FILL_DIGIT_ZERO(0)
                FILL_DIGIT_ZERO(1)
                FILL_DIGIT_ZERO(2)
                FILL_DIGIT_ZERO(3)
                FILL_DIGIT_ZERO(4)
                FILL_DIGIT_ZERO(5)
            }
        } else if (aligin == 1) {
            // Align: Left.
            //int shiftIndex = 0;
            //for (int j = 0; j < displayLength; j++) {
            //    if (result.digits[j] != -1) {
            //        result.digits[shiftIndex++] = result.digits[j];
            //    }
            //}
            
            //for (int k = shiftIndex; k < displayLength; k++) {
            //    result.digits[k] = -1;
            //}
            
            // hard-coding for avoid "unrolling failed" issue and "array reference cannot be used as an l-value" issue.
            {
                // Remember "maxDigitCount" is fixed to 6.
                #define SHIFT_DIGITS_TO_LEFT() \
                    if (result.digits[0] == -1) { \
                        result.digits[0] = result.digits[1]; \
                        result.digits[1] = result.digits[2]; \
                        result.digits[2] = result.digits[3]; \
                        result.digits[3] = result.digits[4]; \
                        result.digits[4] = result.digits[5]; \
                        result.digits[5] = -1; \
                    }

                SHIFT_DIGITS_TO_LEFT() // 0
                SHIFT_DIGITS_TO_LEFT() // 1
                SHIFT_DIGITS_TO_LEFT() // 2
                SHIFT_DIGITS_TO_LEFT() // 3
                SHIFT_DIGITS_TO_LEFT() // 4
                //SHIFT_DIGITS_TO_LEFT() // 5
                // Do nothing when 5 index.
                // because at least one digit is always displayed.
                // (5 equals maxDigitCount: 6 - 1)

            }

            // hard-coding for avoid unroll issue.
            {
                // Remember "maxDigitCount" is fixed to 6.
                // Do here

            }
        } else if (aligin == 2) {
            // Align: Right.
            // Do nothing because digits are already right-aligned by default.

        }
    }

    return result;
}

float4 CalculateDigitColor(float edgePadding, float2 uv, uint displayLength, fixed digits[maxDigitCount]) {
    // Determine which digit to display based on the quad's horizontal position.
    int uvIndex = (int) (uv.x * displayLength); // 0 ~ (_DisplayLength-1) range
    uvIndex = clamp(uvIndex, 0, displayLength - 1);

    // Return transparent for -1 (empty) digit.
    int digit = digits[uvIndex];
    if (digit == -1) return fixed4(0, 0, 0, 0); // Empty digits are transparent.

    // Calculate column and row of the current digit in the sprite sheet.
    int column = digit % column_count;
    int row = digit / column_count;

    float segmentWidth = 1.0 / displayLength;  // Each digit's screen space width

    // Calculate uv of sprite sheet.
    float2 digitUV;
    float localUVx = (uv.x - uvIndex * segmentWidth) / segmentWidth; // Local uv of current digit
    float localUVy = uv.y;

    // Return transparent when UV falls within the padding region to prevent flickering on edges.
    if (localUVx < edgePadding || localUVx > (1.0 - edgePadding) || localUVy < edgePadding || localUVy > (1.0 - edgePadding)) {
        //return fixed4(1, 0, 0, 1); // Display red for debugging.
        return fixed4(0, 0, 0, 0);
    }
    
    
    // Calculate the exact UV coordinates of the sprite sheet with adjusted UVs.
    {
        #ifdef USE_UV_PADDING
            // Adjust the local UV to exclude padding and use the adjusted area. (Make sprite smaller)

            // Adjust local UV to expand the reference area
            float expandedLocalUVx = (localUVx - edgePadding) / (1.0 - 2.0 * edgePadding);
            float expandedLocalUVy = (localUVy - edgePadding) / (1.0 - 2.0 * edgePadding);

            digitUV.x = (column * digitWidth) + (expandedLocalUVx * digitWidth); // Normalize x-coordinate based on the column
            digitUV.y = (1.0 - ((row + 1) * digitHeight)) + (expandedLocalUVy * digitHeight); // Calculate y-coordinate (flipped vertically)
        #else
            // Cut digit sprite based on the original UV without padding adjustment.
            
            digitUV.x = (column * digitWidth) + (localUVx * digitWidth); // Normalize x-coordinate based on the column
            digitUV.y = (1.0 - ((row + 1) * digitHeight)) + (localUVy * digitHeight); // Calculate y-coordinate (flipped vertically)
        #endif
    }
    
    fixed4 color = tex2D(_SpriteSheet, digitUV);
    
    return color;
}