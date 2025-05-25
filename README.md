# stripe-localstack

`stripe-localstack` は、Stripe API のローカル開発を提供するプロジェクトです。
VSCodeのDevContainer 機能を活用し、コンテナボリュームに直接 `git clone`
してすぐに開発を始められます。

## 特長

- Stripe API のモック環境をローカルで構築
- AWS SQSのモック環境をLocalStackで構築
- DevContainer による一貫した開発環境

## 前提条件

- Stripe
- Docker
- VSCode
- VSCode 拡張機能: Remote - Containers または Dev Containers

## アーキテクチャ

### サービス一覧

docker composeで実行するサービスの一覧は以下の通りです。

| サービス名 | 説明                                                                   |
| :--------- | :--------------------------------------------------------------------- |
| app        | プログラムを開発するためのコンテナ。                                   |
| stripe-cli | StripeにWebhookのローカルリスナーを登録し、Webhookイベントを受け取る。 |
| localstack | LocalStackでSQSリソースをエミュレートする。                            |

### サービス・プログラム関係図

StripeからSQSまでイベントが到達する仕組み

```
Stripe: Webhookでローカルリスナーにイベントを通知
-> stripe-cli: 通知されたイベントをstripe-event-sqs-pipelineに転送
  -> app(stripe-event-sqs-pipeline): 転送されたイベントのペイロードをSQSに送信
    -> LocalStaclk(SQS)
```

## セットアップ

1. VSCodeでコンテナボリュームに直接リポジトリをクローンします。
2. [.devcontainer/.env.sample]()をコピーして、[.devcontainer/.env]()を作成します。
   ```sh
   cp .devcontainer/.env.sample .devcontainer/.env
   ```
3. .envを開いて、STRIPE_API_KEYを設定します。
   STRIPE_API_KEYには、Stripeダッシュボードで取得できるシークレットキーを設定します。
4. 開発コンテナをリビルドします。

## 使い方

- 実行コマンドは[./stripe-event-sqs-pipeline/README.md]()を参照してください。
- `stripe`コマンド（Stripe CLI）は`stripe-cli`サービスを実行しているコンテナのシェルから利用できます。
    
