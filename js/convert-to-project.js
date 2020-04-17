const path = require('path');
const fs = require('fs');
const Mustache = require('mustache');

function getPath(relative) {
  return path.join(__dirname, '../', relative);
}

function main() {
  const filePath = path.join(process.cwd(), process.argv[2])
  const sheet = fs.readFileSync(filePath, { encoding: 'utf8' });

  const template = fs.readFileSync(getPath('styles/base/project-template.mml'), { encoding: 'utf8' });
  const output = Mustache.render(template, {
    stylesheet: sheet,
  });

  console.log(output);
}

main();
