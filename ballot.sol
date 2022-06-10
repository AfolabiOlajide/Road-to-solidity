// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Ballot{
    address public chairPerson;

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    struct Voter{
        uint vote;
        bool voted;
        uint weight;
    }

    Proposal [] public proposals;
    mapping (address => Voter) public voters;


    constructor (bytes32[] memory proposalNames){
        chairPerson = msg.sender;

        voters[chairPerson].weight = 1;

        // will add the proposalNames to the smart contract upon deployment
        for(uint i = 0; i < proposalNames.length; i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
}