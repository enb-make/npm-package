/**
 * Hello World calculator.
 *
 * @name HelloWorld
 */
function HelloWorld() {

}

/**
 * Calculates `Hello World`.
 *
 * @returns {String}
 */
HelloWorld.prototype.calculate = function() {
    return 'Hello' + ' ' + 'World';
};

module.exports.HelloWorld = HelloWorld;
