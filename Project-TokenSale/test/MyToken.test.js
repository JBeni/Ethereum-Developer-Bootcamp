const Token = artifacts.require(".././src/contracts/MyToken.sol");
var chai = require("chai");

const BN = web3.utils.BN;
const chainBN = require("chain-bn")(BN);
chai.use(chainBN);

var chaiAsPromised = require("chai-as-promised");
chai.use(chainAsPromised);

const expect = chai.expect;

contract("Token Test", async accounts => {
    const [ initialHolder, recipient, anotherAccount ] = accounts;

    it("All tokens should be in my account", async () => {
        let instance = await Token.deployed();
        let totalSupply = await instance.totalSupply();
        await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(totalSupply);
    });

    it("I can send tokens from Account 1 to Account 2", async () => {
        const sendTokens = 1;
        let instance = await Token.deployed();
        let totalSupply = await instance.totalSupply();
        await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(totalSupply);
        await expect(instance.transfer(recipient, sendTokens)).to.eventually.be.fulfilled;
        await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(totalSupply.sub(new BN(sendTokens)));
        await expect(instance.balanceOf(recipient)).to.eventually.be.a.bignumber.equal(new BN(sendTokens));
    });

    it("It's not possible to send more tokens than account 1 has", async () => {
        let instance = await Token.deployed();
        let balanceOfAccount = await instance.balanceOf(initialHolder);
        await expect(instance.transfer(recipient, new BN(balanceOfAccount+1))).to.eventually.be.rejected;
        //check if the balance is still the same
        await expect(instance.balanceOf(initialHolder)).to.eventually.be.a.bignumber.equal(balanceOfAccount);
    });
});
