import { tool } from "@opencode-ai/plugin";

export default tool({
    description: "Says hello",
    args: {
        name: tool.schema.string().describe("Who am I saying hello to?"),
    },
    async execute(args) {
        return `Hello ${args.name}!`;
    },
});
