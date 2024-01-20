const hre = require('hardhat')
const {getNamedAccounts} = hre

module.exports = async function () {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;
    const {deployer, tokenOwner} = await getNamedAccounts();

    let libs = [
        "ProofVerifier",
    ]

    let deployedLib = {}
    for (let lib of libs) {
        await deploy(lib, {
            from: deployer,
            log: true,
        });
        deployedLib[lib] = (await hre.deployments.get(lib)).address
    }

    await deploy('TestLpcVerifier', {
        from: deployer,
        libraries: deployedLib,
        log: true,
    })
}

module.exports.tags = ['testLPCVerifierFixture']
