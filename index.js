module.exports = process.env.{{PackageNameUpperUnderscored}}_COVERAGE ?
    require('./lib-cov/hello-world') :
    require('./lib/hello-world');
