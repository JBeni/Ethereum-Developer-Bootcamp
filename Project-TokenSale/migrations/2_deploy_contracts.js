var MyToken = artifacts.require('./src/contracts/MyToken.sol');
var MyTokenSale = artifacts.require('./src/contracts/MyTokenSale.sol');

module.exports = async function (deployer) {
	let addr = await web3.eth.getAccounts();
	await deployer.deploy(MyToken, 1000000000);
	await deployer.deploy(MyTokenSale, 1, addr[0], MyToken.address);
	let tokenInstance = await MyToken.deployed();
	await tokenInstance.transfer(MyTokenSale.address, 1000000000);
};
