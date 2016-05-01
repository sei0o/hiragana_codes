# HiraganaCodes (ひらがなコード)

## 概要
- 文字は`あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもらりるれろ`(40文字)を、この順で使います。
  - `やゆよわをん`を除外します。
  - `hiragana_codes.rb`の`CHARACTERS`定数を変更すれば、使う文字をカタカナや漢字、絵文字にもできます。
- 二桁ずつ変換します。
  1. 地球を緯度4.5度ごと、経度9度ごとに区切ります(文字数によって変化)。
  2. 上記の文字を割り当てて、緯度経度の順に並べます。
  3. 繰り返し

## 例
- 国会議事堂前
  - 35.675796, 139.743786
  - すらうにらえさせりねうぬ
- ホワイトハウス
  - 38.89769091235223, -77.03655930429916
  - ししそつこのへのたてめふ
- 新大阪駅
  - 34.7331654, 135.5002144
  - すらしうさけつるけえかけ

## インストール
```
  $ gem install hiragana_codes
```

```ruby
  gem 'hiragana_codes'
```

## 使い方
- Encoding

  ```ruby
    require 'hiragana_codes'
    HiraganaCodes.encode latitude, longitude, area_fineness
  ```
- Decoding

  ```ruby
    require 'hiragana_codes'
    HiraganaCodes.decode code
  ```

### シェルコマンド
- Encoding

  ```bash
    $ hencode latitude, longitude, area_fineness
    すらしうさけつるけえかけ
  ```
- Decoding

  ```bash
    $ hdecode code
    34.7331654, 135.5002144
  ```

## 示す範囲
- 2桁(粒度0)
  - 南北1000km, 東西500km
- 4桁(粒度1)
  - 南北25km, 東西12.5km
- 6桁(粒度2)
  - 南北625m, 東西312.5m
- 8桁(粒度3)
  - 南北15.625m, 東西7.8125m
- 10桁(粒度4)
  - 南北39.0625cm, 東西19.53125cm
- 12桁(粒度5)
  - 南北9.765625mm, 東西4.8828125mm

## ライセンス
[MIT License](http://opensource.org/licenses/MIT).
