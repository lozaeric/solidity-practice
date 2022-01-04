const Voting = artifacts.require("VotingSystemWithChoices");

module.exports = function(deployer) {
  deployer.deploy(Voting);
};
