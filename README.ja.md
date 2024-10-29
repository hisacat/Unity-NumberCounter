## Unity Number Counter Shader

このドキュメントは以下の言語でもご覧いただけます。  
[[English]](./README.md) [[한국어]](./README.ko.md) [[日本語]](README.ja.md)

[![GitHub Release][shields-release]][github-release]

[shields-release]: https://img.shields.io/github/v/release/hisacat/Unity-NumberCounterShader
[github-release]: https://github.com/hisacat/Unity-NumberCounterShader/releases/latest

これはUnityで数字を表示するためのシンプルなシェーダーです。

- 最大6桁の数字を表示可能
- パフォーマンスを最適化した軽量シェーダー
- `Particle System`と完全互換
- 7種類のデフォルトフォントテクスチャを提供

このプロジェクトにクレジットを付ける義務はありませんが、付けていただけると嬉しいです！  
もしこのプロジェクトがお気に召しましたら、以下のボタンから**サポート**をしてください <3

<a href="https://www.buymeacoffee.com/HisaCat"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me Milk&emoji=🥛&slug=HisaCat&button_colour=bd5fff&font_colour=ffffff&font_family=Bree&outline_colour=000000&coffee_colour=ffffff" /></a>

## フォントテクスチャ例

以下はフォントテクスチャの例です。（実際には背景が透明である必要があります）  
![Font example](./Images/Font.png)  
カスタムフォントテクスチャを作成して使用することもできます。サポート用に [Font Template.psd](./Assets/HisaCat/Number%20Counter/FontTemplate.psd) ファイルを提供しています。

## 使用方法

- `HisaCat/Number Counter/Sample Scene` をご参照ください。  
  使用するには、`HisaCat/Number Counter Unlit Cutout` や `HisaCat/Number Counter Unlit Alpha Blended` シェーダーをQuadやMeshに適用します。
- プロパティ:  
  ![Properties](./Images/Inspector-Properties.png)
  - `Color`: 最終的に掛け合わせる色です。
  - `Sprite Sheet`: 数字0〜9が含まれたテクスチャです。（5列2行）
  - `Display Length`: 表示する桁数です。
  - `Value`: 表示する値です。
  - `Align`: 数値の配置方法。
    - `Fill Zeros`: 数字を右揃えし、空いた左の桁を`0`で埋めます。
    - `Left`: 数字を左揃えします。
    - `Right`: 数字を右揃えします。

## その他

このシェーダーは手動でコーディングされており、パフォーマンス面で非常に軽量です。  
メインロジックは [Number Counter.cginc](./Assets/HisaCat/Number%20Counter/Shaders/Number%20Counter.cginc) に記載されていますので、興味のある方はご確認ください。

このシェーダーは、テクスチャの周辺の一部のパディング領域をレンダリングから除外するため、テクスチャの`Mipmaps`オプションを有効にしても視覚的なアーティファクトが発生しません。これにより、VRChatなどのゲームとの互換性も高くなっています。  
問題が発生した場合は、[Issue](https://github.com/hisacat/Unity-NumberCounterShader/issues) タブからお知らせください！

## ライセンス

このプロジェクトは完全なオープンソースであり、著作権情報を含める条件の下、誰でも自由に使用、改変、配布することができます。このソフトウェアは「現状のまま」提供されており、使用に伴う問題や損害について著作権者は一切責任を負いません。

詳細については、[ライセンス](./LICENSE) をご参照ください。
