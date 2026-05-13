#!/usr/bin/env node

const args = process.argv.slice(2);
const params = {};

for (let i = 0; i < args.length; i++) {
  if (args[i].startsWith('--')) {
    params[args[i].slice(2)] = args[i + 1];
    i++;
  }
}

const { agent, model, scope, summary, body } = params;

if (!agent || !model || !summary) {
  console.error('Usage: node generate-commit-message.cjs --agent "Agent" --model "Model" --summary "Summary" [--scope "Scope"] [--body "Body"]');
  process.exit(1);
}

let message = '';

if (scope) {
  message += `${scope}: ${summary}\n`;
} else {
  message += `${summary}\n`;
}

if (body) {
  message += `\n${body}\n`;
}

message += `\nCoding-Agent: ${agent}`;
message += `\nModel: ${model}\n`;

console.log(message);
