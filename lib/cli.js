var program = require('commander');

program
    .version(require('../package.json').version)
    .usage('[options] <file ...>')
    .option('-c, --config [path]', 'configuration file path')
    .parse(process.argv);

if (program.args.length > 0) {
    console.log('Arguments:', program.args);
    console.log('Config:', program.config || 'default-config');
} else {
    program.help();
}
