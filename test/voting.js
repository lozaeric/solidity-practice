const Voting = artifacts.require("VotingSystemWithChoices");

contract('Voting', (accounts) => {
  const choiceId = 1;
  const choiceDescription = "A";

  it('should be able to add a choice', async () => {
    const votingInstance = await Voting.deployed();

    await votingInstance.addChoice(choiceId, choiceDescription);
  });

  it('an account should be able to vote', async () => {
    const votingInstance = await Voting.deployed();

    const canVote = await votingInstance.canVote.call({ from: accounts[0] });
    assert.isOk(canVote, "Account zero should be able to vote");

    await votingInstance.vote(choiceId, { from: accounts[0] });
    const numberOfVotes = await votingInstance.getNumberOfVotes.call(choiceId);
    assert.equal(numberOfVotes.valueOf(), 1, "We should have one vote");
  });

  it('another account should be able to vote', async () => {
    const votingInstance = await Voting.deployed();

    await votingInstance.vote(choiceId, { from: accounts[1] });

    const numberOfVotes = await votingInstance.getNumberOfVotes.call(choiceId);
    assert.equal(numberOfVotes.valueOf(), 2, "We should have two votes");
  });
});
