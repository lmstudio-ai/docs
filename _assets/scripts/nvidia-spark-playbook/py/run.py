# /// script
# dependencies = [
#   "lmstudio",
# ]
# ///

import lmstudio as lms


def main():
    # Connect to Remote LM Studio on port 1234, replace <SPARK_LOCAL_IP> with the IP address of your DGX Spark on your local network
    lms.configure_default_client("<SPARK_LOCAL_IP>:1234")

    # Get model reference (uses already loaded model if available)
    model = lms.llm("openai/gpt-oss-120b")

    # Hard-coded prompt
    prompt = "List three cool project ideas that I can run with a local LLM"

    print("Sending prompt:", prompt)
    print("\nResponse:")

    # Send the prompt and stream the response
    for fragment in model.respond_stream(prompt):
        print(fragment.content, end="", flush=True)

    print("\n\nDone!")


if __name__ == "__main__":
    main()
