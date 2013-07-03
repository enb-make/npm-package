module.exports = process.env.PACKAGE_COVERAGE ?
    require('./lib-cov/hello-world') :
    require('./lib/hello-world');
