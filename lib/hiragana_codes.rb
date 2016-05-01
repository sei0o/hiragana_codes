require "hiragana_codes/version"

module HiraganaCodes
  CHARACTERS = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもらりるれろ".split ""

  def self.encode latitude, longitude, area_fineness = 4, next_area_fineness = 0 # 緯度、経度(N90, W180 を起点として)、変換後の細かさ(0で最大)、次に変換するときの細かさ
    return if area_fineness < next_area_fineness

    latitude_code = CHARACTERS[(latitude / latitude_per_character(next_area_fineness)).floor]
    longitude_code = CHARACTERS[(longitude / longitude_per_character(next_area_fineness)).floor]

    return latitude_code + longitude_code if area_fineness == next_area_fineness # 「変換後の細かさ」に達したら

    relative_latitude = latitude - area_westmost(latitude, next_area_fineness) # 次に変換するときはcodeの示す緯度経度の最西・最北端を起点として変換する
    relative_longitude = longitude - area_northmost(longitude, next_area_fineness)

    latitude_code + longitude_code + encode(relative_latitude, relative_longitude, area_fineness, next_area_fineness + 1)
  end

  def self.decode code
    return if code.size.odd?

    area_westmost = area_eastmost = area_northmost = area_southmost = 0
    areas = code.scan(/.{2}/)

    areas.each_with_index do |area, fineness|
      area_westmost  +=  CHARACTERS.index(area[0])      * latitude_per_character(fineness) # どんどん足していく
      area_eastmost  += (CHARACTERS.index(area[0]) + 1) * latitude_per_character(fineness) # +1 で次の地区の緯度経度がとれる
      area_northmost +=  CHARACTERS.index(area[1])      * longitude_per_character(fineness)
      area_southmost += (CHARACTERS.index(area[1]) + 1) * longitude_per_character(fineness)
    end

    [area_westmost, area_eastmost, area_northmost, area_southmost]
  end

  def self.area_westmost latitude, area_fineness = 0 # 緯度経度の属するareaの最西端
    # latitudeが42度のとき、latitude_per_character(area_fineness)が10とすると、
    # (latitude / latitude_per_character(area_fineness)) は4.2、floorして4になるから、
    # その地点の左に4地区あるということになる。
    # その4に、latitude_per_character(area_fineness)をかけて 40、areaの最西端が分かる
    (latitude / latitude_per_character(area_fineness)).floor * latitude_per_character(area_fineness)
  end

  def self.area_northmost longitude, area_fineness = 0 # 緯度経度の属するareaの最北端
    (longitude / longitude_per_character(area_fineness)).floor * longitude_per_character(area_fineness)
  end

  def self.latitude_per_character area_fineness = 0 # 1文字ごとに割り当てる緯度
    degree = 180
    (area_fineness + 1).times { degree /= CHARACTERS.size.to_f } # area_finenessが0なら一回, 1なら二回, 地区を分割する

    degree
  end

  def self.longitude_per_character area_fineness = 0 # 1文字ごとに割り当てる経度
    degree = 360
    (area_fineness + 1).times { degree /= CHARACTERS.size.to_f }

    degree
  end
end
