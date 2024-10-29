## Unity Number Counter Shader

이 문서는 아래 언어로도 읽을 수 있습니다.  
[[English]](./README.md) [[한국어]](./README.ko.md) [[日本語]](README.ja.md)

[![GitHub Release][shields-release]][github-release]

[shields-release]: https://img.shields.io/github/v/release/hisacat/Unity-NumberCounterShader
[github-release]: https://github.com/hisacat/Unity-NumberCounterShader/releases/latest

이것은 숫자를 표시하기 위한 간단한 Unity용 Shader 입니다.  
![Preview](./Images/Preview.png)

- 최대 6자리의 숫자를 표시 가능
- 직접 작성된 쉐이더로 매우 가벼움
- `Particle System`과 완벽 호환
- 7여종의 텍스처 폰트가 기본적으로 제공

이 프로젝트를 사용함에 따른 라이센스 표기는 당신의 자유입니다!  
제 프로젝트가 마음에 드신다면 아래 버튼으로 제게 **후원**을 해 주세요 <3

<a href="https://www.buymeacoffee.com/HisaCat"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me Milk&emoji=🥛&slug=HisaCat&button_colour=bd5fff&font_colour=ffffff&font_family=Bree&outline_colour=000000&coffee_colour=ffffff" /></a>

## 텍스처 폰트 예제

아래는 텍스처 폰트의 예제입니다. (실제로는 배경이 투명이어야 함)  
![Font example](./Images/Font.png)  
커스텀 폰트 텍스처를 직접 만들어 사용하실 수도 있습니다. 이를 돕기 위한 [Font Template.psd](./Assets/HisaCat/NumberCounter/FontTemplate.psd)가 함께 제공됩니다.

## Usage

- `HisaCat/Number Counter/Sample Scene` 을 참고하세요.  
  기본적으로 Quad에 Mesh에 `HisaCat/Number Counter Unlit Cutout`, `HisaCat/Number Counter Unlit Alpha Blended`등의 Shader를 적용한 Material을 할당하면 됩니다.
- Properties:  
  ![Properties](./Images/Inspector-Properties.png)
  - `Color`: 최종적으로 곱해질 색상입니다.
  - `Sprite Sheet`: 0~9까지의 숫자가 포함된 텍스처입니다. (5 Columns 2 Rows)
  - `Display Length`: 표시될 숫자의 자릿수입니다.
  - `Value`: 표시될 값입니다.
  - `Align`: 값의 표시 방법입니다.
    - `Fill Zeros`: 숫자를 오른쪽으로 정렬하고 빈 왼쪽 자리를 `0`으로 채웁니다.
    - `Left`: 숫자를 왼쪽으로 정렬합니다.
    - `Right`: 숫자를 오른쪽으로 정렬합니다.

## 기타

이 쉐이더는 코드를 통해 직접 작성되으며, 퍼포먼스 측면에서 매우 가볍습니다.
메인 로직은 [NumberCounter.cginc](./Assets/HisaCat/NumberCounter/Shaders/NumberCounter.cginc)에 작성되어 있으니 궁금하시다면 확인해보세요!

기본적으로 가장자리의 일부 padding 영역을 렌더링에서 제외하기 때문에 텍스처의 `Mipmaps`옵션을 활성화해도 시각적 아티펙트가 발생하지 않습니다. 이로 인해 VRChat등의 게임과의 호환성이 좋습니다.  
문제가 발생할 경우 [Issue](https://github.com/hisacat/Unity-NumberCounterShader/issues) 탭 등을 통해 제게 알려주세요!

## LICENSE

이 프로젝트는 완전한 오픈 소스로, 저작권 표기를 포함하는 조건 하에 누구나 자유롭게 사용, 수정, 배포할 수 있습니다. 이 소프트웨어는 "있는 그대로" 제공되며, 저작권자는 사용에 따른 문제나 손해에 대해 책임을 지지 않습니다.

자세한 내용은 [라이센스](./LICENSE) 문서를 참조하세요.
