module.exports = process.env.{{PackageNameUpperUnderscored}}_COVERAGE ?
    require('./lib-cov') :
    require('./lib');
