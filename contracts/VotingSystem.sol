pragma solidity >=0.6.0 <0.7.0;

abstract contract VotingSystem {
    struct Vote {
        uint id;
        uint32 choice;
    }

    Vote[] internal votes;   
    mapping (uint => address) private voteToOwner;
    
    function canVote() public view returns (bool) {
        for (uint i=0; i<votes.length; i++) {
            if (voteToOwner[i] == msg.sender) {
                return false;
            }
        }
        return true;
    }

    function _vote(uint32 _choice) internal {
        require (canVote(), "ALREADY_VOTED");

        uint _id = votes.length;
        votes.push(Vote(_id, _choice));
        voteToOwner[_id] = msg.sender;
    }
}
