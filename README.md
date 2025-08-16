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

## Implemented Features (基盤対応まとめ)

- **環境変数管理**

  - `--dart-define` を利用して環境ごとに設定を切替
  - `envProvider` から型安全に取得可能

- **API 通信基盤 (Dio)**

  - `dioProvider` を用意し、共通の通信クライアントを管理
  - **AuthInterceptor**
    - `Authorization` ヘッダーを自動付与
    - トークン未保持時はヘッダーを付けずに通信
  - **RefreshInterceptor**（⚠️ 準備中）
    - 401 エラー発生時にトークンリフレッシュ → リクエスト再送をハンドリング予定

- **Repository 層の分離**

  - `UserRepository` を抽象化し、
    - **RemoteRepository**（API 呼び出し用）
    - **FakeRepository**（フェイクデータ用）  
      に差し替え可能
  - `USE_FAKE=true` のときはフェイクデータで動作

- **DataSource の二重化**

  - Fake / Remote DataSource を実装済み
  - Repository 層経由で VM（ViewModel）から利用可能

- **テスト基盤**

  - `flutter_test` + `mocktail` + `dio_http_mock_adapter`
  - AuthInterceptor が Authorization を正しく付与するかをユニットテスト可能
  - RefreshInterceptor の再送挙動もモックで検証予定（⚠️ 準備中）

- **サンプル API 接続**
  - デフォルトで `https://jsonplaceholder.typicode.com` を利用可能
