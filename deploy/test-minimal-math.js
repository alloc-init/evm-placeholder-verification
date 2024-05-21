const hre = require('hardhat')
const {getNamedAccounts} = hre

module.exports = async function () {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;
    const {deployer, tokenOwner} = await getNamedAccounts();

    await deploy('TestMinimalMath', {
        from: deployer,
        log: true,
    });
}

module.exports.tags = ['testMinimalMathFixture']
