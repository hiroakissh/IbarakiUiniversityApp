# IbarakiUiniversityApp

# コンセプト
自分が通っている大学はなぜかわからないが2つのWebを使用して授業管理している．いちいちそれぞれを開いたりするのが面倒だったリするので，スマホアプリで開きたいなと思った．
提出物のリストと研究室やることリストみたいなのを追加でつけてみた．

# DBはRealSwiftを使用に移行中です。

## First version
### 画面説明
<img src="https://user-images.githubusercontent.com/48234687/136721374-ca8c684d-b2d3-47e2-80c8-fba90021d617.jpeg" width="320px">
<img src="https://user-images.githubusercontent.com/48234687/136721377-dd9a9030-25ec-4286-a051-4ba4f549bba9.jpeg" width="320px">
<img src="https://user-images.githubusercontent.com/48234687/136721381-ccfaa472-aac9-490c-8ab6-099eef0d8f19.jpeg" width="320px">
<img src="https://user-images.githubusercontent.com/48234687/136721384-c0fadbc4-58d7-41a1-a36b-813099646899.jpeg" width="320px">. 

#### ここまでの実装はとても簡単でした。

## Second version

## DBをRealmSwiftに移行中、提出に締め切り日を設定中です。
### 画面紹介
<img src="https://user-images.githubusercontent.com/48234687/162731532-ac2aa797-72db-41fa-9580-078ca259cef9.png" width="320px">
<img src="https://user-images.githubusercontent.com/48234687/162731698-9921a9e9-543b-49ed-9ed0-f1dda15a957c.png" width="320px">

### 変更点

- セルに締め切り日時を指定を行いました。
- DBをUserDefalutからRealmSwiftに変更しました。


### 現状

実際にリリースできました！
WebView部分に関しては、コロナ関連の情報が載っているだけだったのと、2段階認証のログインが足枷となってリジェクトされませんでした。
そのため、簡易的な実装になってしまいましたが、無事リリースできました！
https://apps.apple.com/jp/app/ibadai/id1625642379
