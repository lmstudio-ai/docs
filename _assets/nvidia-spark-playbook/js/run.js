const { LMStudioClient } = require("@lmstudio/sdk");

async function main() {
  // Connect to Remote LM Studio on port 1234, replace {SPARK_LOCAL_IP} with the IP address of your DGX Spark on your local network
  const client = new LMStudioClient({ baseUrl: "ws://{SPARK_LOCAL_IP}:1234" });

  // Get model reference (uses already loaded model if available)
  const model = await client.llm.model("openai/gpt-oss-120b");

  const prompt = "List three cool project ideas that I can run with a local LLM";

  console.log("Sending prompt:", prompt);
  console.log("\nResponse:");

  // Send the prompt and stream the response
  const prediction = model.respond(prompt);

  for await (const fragment of prediction) {
    process.stdout.write(fragment.content);
  }

  console.log("\nDone!");
}

main().catch(console.error);
