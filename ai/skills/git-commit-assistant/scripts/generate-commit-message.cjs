#!/usr/bin/env node

const args = process.argv.slice(2);
const params = {};

for (let i = 0; i < args.length; i++) {
  if (args[i].startsWith('--')) {
    params[args[i].slice(2)] = args[i + 1];
    i++;
  }
}

const { scope, summary, body } = params;

if (!summary) {
  console.error('Usage: node generate-commit-message.cjs --summary "Summary" [--scope "Scope"] [--body "Body"]');
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

console.log(message);
