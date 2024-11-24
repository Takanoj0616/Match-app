# Match App

Match Appは、ユーザー同士の「いいね」「スキップ」を通じてつながりを楽しむシンプルなマッチングアプリです。  
Firebaseを活用して、ログイン、データベース管理、リアルタイムなユーザーインタラクションを実現しています。

## 特徴

### 1. **Firebase Authentication を使用したログイン/ログアウト**
- メールアドレスとパスワードで簡単にアカウント作成。
- セキュアな認証システムを利用してログイン・ログアウトが可能。

### 2. **ユーザー情報のデータベース登録**
- Firebase Realtime Database を使用して、名前、年齢、趣味、プロフィール画像などの情報を登録。
- 登録情報は即時に保存・取得できます。

### 3. **好き・嫌い判定機能**
- ユーザーのプロフィールを「いいね」または「スキップ」で評価。
- 評価結果はデータベースに保存され、次回以降に反映されます。

---

## 使用技術

### 言語
- Swift

### フレームワーク/ライブラリ
- UIKit

### Firebase
- **Firebase Authentication**: ユーザーの認証処理
- **Firebase Realtime Database**: ユーザー情報の保存と読み込み
- **Firebase Storage**（オプション）: プロフィール画像のアップロード

---