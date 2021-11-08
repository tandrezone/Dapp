pragma solidity ^0.5.16;
/**
 * The contractName contract does this and that...
 */
contract Election {
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    mapping(uint => Candidate) public candidates;
    // store accounts that have voted
    mapping(address => bool) public voters;
    // voted event
    event votedEvent (
        uint indexed _candidateId
    );
    uint public candidatesCount;
    //constructor
    constructor() public {
        addCandidate("KamalHaasan");
        addCandidate("RajniKanth");
    }
    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        // require that the voter hasn't voted before
        require (!voters[msg.sender]);
        // require a valid candidate
        require (_candidateId > 0 && _candidateId <= candidatesCount);
        //record  that voter has voted
        voters[msg.sender] = true;
        // update candiadte voteCount
        candidates[_candidateId].voteCount ++;
        //trigger
        emit votedEvent(_candidateId);
    }
}