module.exports = process.env.COVERAGE ?
    require('./lib-cov/hello-world') :
    require('./lib/hello-world');
