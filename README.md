## Unity Number Counter Shader

This document is also available in other languages:  
[[English]](./README.md) [[한국어]](./README.ko.md) [[日本語]](README.ja.md)

[![GitHub Release][shields-release]][github-release]

[shields-release]: https://img.shields.io/github/v/release/hisacat/Unity-NumberCounterShader
[github-release]: https://github.com/hisacat/Unity-NumberCounterShader/releases/latest

This is a simple shader for displaying numbers in Unity.  
![Preview](./Images/Preview.png)

- Displays up to 6 digits
- Lightweight shader with optimized performance
- Fully compatible with `Particle System`
- Comes with 7 default font textures

There’s no requirement to credit this project, though it is appreciated!  
If you enjoy my project, please consider **supporting me** through the button below <3

<a href="https://www.buymeacoffee.com/HisaCat"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me Milk&emoji=🥛&slug=HisaCat&button_colour=bd5fff&font_colour=ffffff&font_family=Bree&outline_colour=000000&coffee_colour=ffffff" /></a>

## Font Texture Example

Below is an example of a font texture. (The actual background should be transparent.)  
![Font example](./Images/Font.png)  
You can create and use custom font textures as well. A [Font Template.psd](./Assets/HisaCat/NumberCounter/FontTemplate.psd) file is provided to help you get started.

## Usage

- Refer to the `Assets/HisaCat/Number Counter/Sample Scene` for examples.  
  To use, simply apply materials with shaders like `HisaCat/Number Counter Unlit Cutout` or `HisaCat/Number Counter Unlit Alpha Blended` to a Quad mesh.
- Properties:  
  ![Properties](./Images/Inspector-Properties.png)
  - `Color`: The final color to be multiplied.
  - `Sprite Sheet`: A texture containing digits 0–9 (5 Columns 2 Rows).
  - `Display Length`: Number of digits to display.
  - `Value`: The value to display.
  - `Align`: Alignment of the displayed value.
    - `Fill Zeros`: Right-align with empty spaces filled with `0`.
    - `Left`: Left-aligns the number.
    - `Right`: Right-aligns the number.

## Additional Information

This shader is manually coded and optimized for performance.  
The core logic is located in [NumberCounter.cginc](./Assets/HisaCat/NumberCounter/Shaders/NumberCounter.cginc) if you’re interested in exploring the code.

Since this shader excludes certain padding areas around the edges, enabling the texture’s `Mipmaps` option won’t cause visual artifacts, which makes it compatible with games like VRChat.  
If you encounter any issues, please let me know through the [Issue](https://github.com/hisacat/Unity-NumberCounterShader/issues) tab!

## LICENSE

This project is completely open-source, allowing anyone to freely use, modify, and distribute it under the condition that the copyright information is included in all copies. The software is provided “as is,” with no liability held by the author for any issues or damages resulting from its use.

For details, please refer to the [License](./LICENSE).
