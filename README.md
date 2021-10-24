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

課題が完成したら、リポジトリーのアドレスを教えてください。

## 参考記事

提出された課題の評価ポイントに関しては、[こちらの記事](https://qiita.com/lovee/items/d76c68341ec3e7beb611)に詳しく書かれてありますので、ぜひご覧ください。

  
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

※xcodegenが導入されていない環境であれば、Homebrewなどで環境構築してください
参考:https://github.com/yonaskolb/XcodeGen



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
- リリース `release/[バージョン]`


## 🚥コミットのルール

- コメントの言語（日・英）の規定なし
- 頭に、タグ（add:, update:, fix: など）をつける。
- コミットの粒度については、なるべく細かめにする。