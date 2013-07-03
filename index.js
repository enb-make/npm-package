module.exports = process.env.{{PackageNameUpperUnderscored}} ?
    require('./lib-cov/hello-world') :
    require('./lib/hello-world');
