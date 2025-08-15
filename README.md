## Environment 設定

このプロジェクトでは、`--dart-define` を用いて実行時に環境変数を渡します。  
`lib/config/app_env.dart` の `envProvider` から型付きで取得できます。

### 利用可能な変数

| 変数名       | 必須         | デフォルト値 | 説明                                                |
| ------------ | ------------ | ------------ | --------------------------------------------------- |
| ENV          | 任意         | dev          | 環境名 (dev / stg / prod など)                      |
| API_BASE_URL | 条件付き必須 | なし         | API のベース URL（`USE_FAKE=false` のとき必須）     |
| USE_FAKE     | 任意         | true         | true ならバックエンド未接続でもフェイクデータで動作 |

### 実行例

#### フェイクデータで実行（API 不要）

```bash
flutter run \
  --dart-define=ENV=dev \
  --dart-define=USE_FAKE=true
```

```bash
flutter run \
  --dart-define=ENV=dev \
  --dart-define=USE_FAKE=false \
  --dart-define=API_BASE_URL=https://jsonplaceholder.typicode.com
```