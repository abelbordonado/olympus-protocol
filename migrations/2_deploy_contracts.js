var Core = artifacts.require("./OlympusLabsCore.sol");
<<<<<<< Updated upstream
// var StrategyProvider = artifacts.require("./strategy/StrategyProvider");
=======
// var StrategyProvider = artifacts.require("./strategy/StrategyProvider.sol");
>>>>>>> Stashed changes
// var ExchangeProvider = artifacts.require("./exchange/ExchangeProvider.sol");
// var PriceProvider = artifacts.require("./price/PriceProvider.sol");

module.exports = function (deployer) {
  deployer.deploy(Core);
  // deployer.deploy(StrategyProvider);
  // deployer.deploy(ExchangeProvider);
  // deployer.deploy(PriceProvider);
};
