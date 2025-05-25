# stripe event sqs pipeline

Stripeで発生したイベントを受け取って、AWS
SQSのキューにメッセージを送信するスクリプト。
StripeのWebhookとSQSとの間でリクエストの形式に互換性がないため、このスクリプトを使用する必要がある。

## 前提条件

- AWSまたはLocalStackでSQSリソースを作成してあること。
- Stripeのアカウントをを保有していること
- Denoがインストールされていること

## 使い方

### 環境変数

| 変数名                                        | 説明                        |
| :-------------------------------------------- | :-------------------------- |
| AWS_SQS_STRIPE_EVENTS_QUEUE_QUEUE_URL（必須） | メッセージを送信する先のURL |

### 実行コマンド

```sh
deno run \
    --allow-net \
    --allow-env \
    --allow-read \
    --allow-sys \
    main.ts
```

デフォルトでは、[http://localhost:8000]に公開される。

### 動作確認

[Stripe CLI](https://docs.stripe.com/stripe-cli/overview)を使うと、Webhookエンドポイントの動作確認を簡単にできる。
[インストール方法](https://docs.stripe.com/stripe-cli#install)に従って、Stripe
CLIをインストールすると、Stripe CLIを利用できる。

以下の2つのコマンドを使えば、動作確認できる。

- [ローカルのWebhookエンドポイントにイベントを転送する](https://docs.stripe.com/stripe-cli/overview#forward-events-to-your-local-webhook-endpoint)
  ```sh
  stripe listen --api-key sk_xxxxxxxx --forward-to localhost:8000
  ```
- [テスト用にWebhookイベントをトリガーする](https://docs.stripe.com/stripe-cli/overview#trigger-a-webhook-event-while-testing)
  ```sh
  stripe trigger checkout.session.completed
  ```

## 利用ツール

- [Deno](https://docs.deno.com/runtime/)
- [aws-cli/client-sqs](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/client/sqs/)
