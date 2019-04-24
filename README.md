# README

# Table 
#### 下記内容でテーブル作成

|Users|データ型|名称|
|:--|:--|:--|
|id|||
|name|string|ユーザー名|
|email|string|メール|
|passwprd_digest|srting|パスワード|
 

|Tasks|データ型|名称|
|:--|:--|:--|
|user_id,label_id|||
|title|string|タスク名|
|content|text|内容|
|deadline|date|締切日|
|priority|integer|優先順位|
|status|string|未着手、着手、完了|


|Labels|データ型|名称|
|:--|:--|:--|
|task_id|||
|title|string|ラベル名|

|Attentions|
|:--|
|task_id,label_id|

#### herokuデプロイ手順
・$ heroku create コマンドでherokuに新しいアプリケーションを作成する。<br>
・$ git push heroku master コマンドでherokuにデプロイができる<br>
・DBは自動で作成されるがマイグレーションファイルは$heroku run rails db:migrateコマンドで手動で実行する。<br>
・$ rails assets:precompile RAILS_ENV=production コマンドにより事前にapp/assets以下をコンパイルしておく必要があ　  る。<br>
#### heroku git hub連携手順
・herokuのappページからdeployを選択。<br>
・ページ下のgit hubアイコンをクリック。<br>
・Connect to GitHubを押下しオーソライズする。<br>
・リポジトリ名を入力する欄があるので記入してコネクト完了
#### バージョン
Rails 5.2.3<br>
Rspec 3.8

