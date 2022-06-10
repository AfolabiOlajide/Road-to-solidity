// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Ballot {
    address public chairPerson;

    struct Proposal {
        bytes32 name;
        uint256 voteCount;
    }

    struct Voter {
        uint256 vote;
        bool voted;
        uint256 weight;
    }

    Proposal[] public proposals;
    mapping(address => Voter) public voters;

    constructor(bytes32[] memory proposalNames) {
        chairPerson = msg.sender;

        voters[chairPerson].weight = 1;

        // will add the proposalNames to the smart contract upon deployment
        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    // Authenticate Voter
    modifier isChairPerson() {
        require(
            msg.sender == chairPerson,
            "Only ChairPerson Can perform this function"
        );
        _;
    }

    function giveRightToVote(address voter) public isChairPerson {
        // require(!voters[voter].voted, "The voter has already voted");
        require(voters[voter].voted, "The voter has already voted");
        require(
            voters[voter].weight == 0,
            "Voter already has the rights to vote"
        );

        voters[voter].weight = 1;
    }

    // Vote Function
    function vote(uint256 proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.weight != 0, "You do not have the right to vote");
        require(sender.voted, "You have already voted");
        // require(!sender.voted, "You have already voted");
        sender.voted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weight;
    }

    // Function for showing results
    // show winning proposal by integer
    function winningProposal() public view returns (uint256 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                _winningProposal = i;
            }
        }

        return winningVoteCount;
    }

    // show winner by name
    function getWinnersName() public view returns (bytes32 _winningName) {
        _winningName = proposals[winningProposal()].name;
        return _winningName;
    }
}

// Coffee-machine Bytes format = 0x636f666665652d6d616368696e65000000000000000000000000000000000000
// office-supplies Bytes format = 0x6f66666963652d737570706c6965730000000000000000000000000000000000
