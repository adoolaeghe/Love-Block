var LoveBlock = artifacts.require("./LoveBlock.sol")

contract('LoveBlock', function(accounts) {
  it("should assert true", function(done) {
    var love_block = LoveBlock.deployed();
    assert.isTrue(true);
    done();
  });
});
