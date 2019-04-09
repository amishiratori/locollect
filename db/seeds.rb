if Station.count == 0
    Station.create([
        {name: '東京', address:'東京都新宿区西新宿１丁目１−３'},
        {name: '大阪', address:'大阪市北区芝田一丁目1番2号' },
        {name: '名古屋', address:'愛知県名古屋市中村区名駅１丁目１−４' },
        {name: '横浜', address:'神奈川県横浜市 西区南幸１丁目９'},
        {name: '広島', address:'広島県広島市南区松原町４'},
        {name: '福岡', address:'福岡県福岡市博多区博多駅中央街１−１'},
        {name: '仙台', address:'宮城県仙台市青葉区中央１丁目１０−１０'},
        {name: '札幌', address:'北海道札幌市北区北6条西4丁目'},
        {name: '高松', address:'香川県高松市浜ノ町'},
        {name: '京都', address:'京都府京都市下京区東塩小路釜殿町'}
        ])
end