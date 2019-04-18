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
|deadline|date|締切日|
|priority|integer|優先順位|
|status|string|未着手、着手、完了|

|Labels|データ型|名称|
|:--|:--|:--|
|task_id|||
|title|string|ラベル名|
