import { SQSClient, SendMessageCommand } from "@aws-sdk/client-sqs";

const sqs = new SQSClient();
const QUEUE_URL = Deno.env.get("AWS_SQS_STRIPE_EVENTS_QUEUE_QUEUE_URL");

Deno.serve(async (req) => {
  const payload = await req.json();
  console.log(payload);
  await sqs.send(
    new SendMessageCommand({
      QueueUrl: QUEUE_URL,
      MessageBody: JSON.stringify(payload),
    })
  );
  return new Response("Event received")
})
