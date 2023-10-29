# Kanpai!

乾杯すると友達になれる新しいサービス、**Kanpai!**

![Kanpai!](https://github.com/jphacks/OL_2311/assets/38308823/b931b346-5b2e-4581-955b-daa478bd6e96)


#### レポジトリ

[ハードウェア](https://github.com/jphacks/OL_2311_1) | [WEB UI](https://github.com/jphacks/OL_2311_2) | [デバッグツール](https://github.com/jphacks/OL_2311_3)

## 製品概要

### 背景(製品開発のきっかけ、課題等）

コロナによる制限がなくなり、オフラインのイベントや懇親会が増えてきました。しかし、オフラインの懇親会では、以下のような課題が存在します。

- 話すきっかけがなかったり、知らない人に話しかける勇気がない
- SNS の交換を忘れてしまい、その場限りの関係なってしまうことが多い

私たちが開発した「Kanpai!」では、乾杯の動作に合わせて SNS の交換を行うことができます。これにより、話すきっかけが生まれ、また、SNS の交換を忘れることもありません。
会場にプロジェクターがあれば、会場内の総乾杯数を表示し、会場の盛り上がりを演出することもできます。

### 製品説明（具体的な製品の説明）

### 特長

#### 1. つい乾杯したくなるデザイン

加速度センサにより乾杯を検知すると、カップホルダー型デバイスの中にある LED が光り、さりげなく盛り上がりを演出します。アプリ上には乾杯した回数が表示され、乾杯した人のプロフィール画面がアンロックされていきます。全員との乾杯を目指すもよし、乾杯を口実に話しかけるもよし、つい乾杯したくなるデザインを目指しました。

会場にプロジェクターやスクリーンがあれば、全員の総乾杯数を表示することもできます！

#### 2. 乾杯した相手と簡単に繋がれる

懇親会が終わった後は、乾杯した相手のプロフィール画面をチェックしましょう！乾杯した人とは自動で SNS アカウントの交換が行われているため、すぐにフォローすることができます。

#### 3. 話題に困ったときは...

初めての人と乾杯すると、その人のプロフィールをアプリ上で確認することができます！話題に困ったら、プロフィールをちら見して共通の話題を探してみましょう。

### 解決出来ること

### 今後の展望

#### 機能面

- アプリ上で話したい話題を選ぶと、カップの LED の点灯色が変化する機能を実装する予定です。例えば、技術的な話をしたい人は赤、ゲーム好きは青、と言ったようにカップを光らせることで、話したい話題をアピールし、話しかけるハードルを下げることができます。
- 利用開始時に、話の種となるいくつかの質問を用意しています（「どこからきましたか？」「得意な領域は？」など）。この質問事項を、イベント主催者が自由にカスタマイズできる機能を実装予定です。
- レコーディング機能を追加し、「誰と乾杯した時に、どんなことを話したのか」を記録することで、後からこの人誰だっけ？になることを防ぎたいと考えています。 Whisper や ChatGPT などを活用して実現したいと考えています。

#### 技術面

- 乾杯の検知を機械学習で行う

### 注力したこと（こだわり等）

- 乾杯が発生した後、プロフィールを交換する処理は、ハードウェアレベルの通信、Bluetooth Low Energy、Firestore のリアルタイムリッスンの仕組みを組み合わせて実装しています。ハードウェアレベルでは、加速度センサによる乾杯検知と、赤外線によるユーザー ID の交換を行なっています。取得したユーザー ID は BLE を利用してアプリに送信され、アプリがサーバーにアクセスし相手の情報を取得します。

- カップホルダ

## 開発技術

### 活用した技術

#### フレームワーク・ライブラリ・モジュール

- アプリ: Flutter, Firebase (Firestore, Authentication)
- 会場表示用ページ: React, TypeScript
- デバッグツール: Next.js, TypeScript

#### デバイス

- M5Capsule（加速度センサ, 赤外線）
- BLE (Bluetooth low energy)

### 独自技術

#### ハッカソンで開発した独自機能・技術

- 独自で開発したものの内容をこちらに記載してください
- 特に力を入れた部分をファイルリンク、または commit_id を記載してください。

#### 製品に取り入れた研究内容（データ・ソフトウェアなど）（※アカデミック部門の場合のみ提出必須）

-
-
