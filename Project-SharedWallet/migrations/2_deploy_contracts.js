const Allowance = artifacts.require('Allowance');
const SharedWallet = artifacts.require('SharedWallet');

module.exports = function (deployer) {
	deployer.deploy(SharedWallet);
};
