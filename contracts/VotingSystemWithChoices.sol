pragma solidity >=0.6.0 <0.7.0;
import "./VotingSystem.sol";
import "./Ownable.sol";

contract VotingSystemWithChoices is VotingSystem, Ownable {
    mapping (uint32 => string) public choices;
    
    modifier validChoice(uint32 _id) {
        require (bytes(choices[_id]).length > 0, "INVALID_CHOICE");
        _;
    }

    function addChoice(uint32 _id, string memory _description) public onlyOwner() {
        require (bytes(choices[_id]).length == 0, "CHOICE_ALREADY_EXISTS");
        choices[_id] = _description;
    }

    function vote(uint32 _choice) external validChoice(_choice){
        _vote(_choice);
    }
    
    function getNumberOfVotes(uint32 _choice) external view validChoice(_choice) returns (uint) {
        uint count = 0;
        for (uint i=0; i<votes.length; i++) {
            if (votes[i].choice == _choice) {
                count++;
            }
        }
        return count;
    }
}
