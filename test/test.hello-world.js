var HelloWorld = require('..').HelloWorld;
var assert = require('assert');

describe('hello-world', function() {
    var helloWorld;
    beforeEach(function() {
        helloWorld = new HelloWorld();
    });
    it('should calculate valid value', function() {
        assert.equal(helloWorld.calculate(), 'Hello World');
    });
});
