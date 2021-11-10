# 株式会社ゆめみ iOS エンジニアコードチェック課題

<details>
<summary>課題内容</summary>

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 13.0）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.5）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 15.0）
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 課題取り組み方法

Issues を確認した上、本プロジェクトを [**Duplicate** してください](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository)（Fork しないようにしてください。必要ならプライベートリポジトリーにしても大丈夫です）。今後のコミットは全てご自身のリポジトリーで行ってください。

コードチェックの課題 Issue は全て [`課題`](https://github.com/yumemi/ios-engineer-codecheck/milestone/1) Milestone がついており、難易度に応じて Label が [`初級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A初級+milestone%3A課題)、[`中級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A中級+milestone%3A課題+) と [`ボーナス`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3Aボーナス+milestone%3A課題+) に分けられています。課題の必須／選択は下記の表とします：

|   | 初級 | 中級 | ボーナス
|--:|:--:|:--:|:--:|
| 新卒／未経験者 | 必須 | 選択 | 選択 |
| 中途／経験者 | 必須 | 必須 | 選択 |


## 参考記事

提出された課題の評価ポイントに関しては、[こちらの記事](https://qiita.com/lovee/items/d76c68341ec3e7beb611)に詳しく書かれてありますので、ぜひご覧ください。

  
</details>

<details>
<summary>頂いたレビュー概要</summary>
  
### 初級
  
- [/]  可読性の向上
- [/]  安全性の向上
- [x]  バグの修正
- [x]  Fat VCの回避

### 中級
  
- [/]  構造のリファクタリング
- [/]  アーキテクチャの適用
- [/]  テストの追加

### ボーナス
  
- [ ]  UIのブラッシュアップ
- [ ]  機能の追加
  
</details>

---

## セットアップ方法

```
git clone https://github.com/techiro/yumemi-codecheck.git
```

```
cd yumemi-codecheck
xcodegen
open iOSEngineerCodeCheck.xcodeproj
```


※xcodegen,swiftlintがローカルの環境に導入されていなければ、Homebrewなどで環境構築してください

```
brew install xcodegen
```

参考:
- xcodegen https://github.com/yonaskolb/XcodeGen
- swiftlint https://qiita.com/OSR108/items/4b23b13bd23feada1921#2-homebrew-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB

## デモ

https://user-images.githubusercontent.com/35694946/139536016-0e811916-5b3c-4505-adcb-06e39a928625.mp4

https://user-images.githubusercontent.com/35694946/139536140-43a4cf21-d975-4f12-b740-78e0e427d149.mp4


## ⚒工夫した点
- Delegateメソッドを使用して、なるべく単一の責務になるように工夫した。
- APIを叩いて、画像データが取得できていない時には初期画像を表示して、画像が取得できていないことを明示
- 開発はGitHubのIssue/PRベースで開発を進めて、なるべく細かくコミットするように心がけました。
- issueには画像を載せて今の進捗が一眼で分かるよう工夫しました。
- SwiftLintを導入して、機械的に構文を確認しバグが含まれそうな部分を早期に修正することができました。
- APIで情報取得に失敗した時は、エラーが起きたことをユーザーに知らせるアラートを設置しました。
- UnitTestの導入を行った結果、エラーが出た時の処理に気づくことができました。
- DarkMode対応

## ❌実装できなかったこと
- TableViewのCellに画像を表示するところ
- 画像や、リポジトリのロード時にローディングアニメーションをつけるところ (詳細画面では初期画像を設定)
- ユニットテストのカバレッジが低いところ
- UITestが出来なかったところ

## 🗂フォルダ構成

### ViewControllersフォルダ
- SearchViewController 起動画面
- DetailViewController 詳細画面
- RepositoryTableViewCell　テーブルのセル
- AlertViewController  失敗時のアラートを表示


### Modelフォルダ（APIの構造体やその構造体を使ったデータ取得モデル）

- SearchRepositoriesResponse APIを叩いた時に取得するレスポンス
- Repository レスポンスの中身
- Owner Repositoryの中にネストしているOwnerモデル

### Extensionフォルダ
- URLのqueryを追加するコード

### APIフォルダ (実際にAPIを叩いて、データを取得する部分)
- GithubAPI GithubのAPIを叩くコード
- ImageAPI 画像URLから画像を取得するコード


## 期間
2021/10/23~2021/10/30までの課題

## 開発環境
- macOS 11.3.1（20E241）
- Xcode 13.0(13A233)

## 🎯開発方法

1. `main` ブランチから開発用のブランチを切る。（ブランチ名については下のブランチ命名規則を参照）
2. 開発用のブランチで開発を進める。（コミットのルールについては下記を参照）
3. 開発用のブランチ -> `main` にプルリクを出す。
4. 問題がなければ、マージする。

## ⛳️ブランチ命名規則

- 新規ページ `design/[ページ名]`
- 新規機能 `feat/[機能名]`
- 既存機能の修正 `fix/[機能名]`
- バグ修正 `hotfix/[バグ名]`


## 🚥コミットのルール

- コメントの言語（日・英）の規定なし
- 頭に、タグ（add:, update:, fix: など）をつける。
- コミットの粒度については、なるべく細かめにする。
