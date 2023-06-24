// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <= 0.9.0;
contract first_coin{
    uint public playerCount = 0;
    mapping (address => Player) public players;

    enum Level{ Beginner, Intermediate, advanced}

    struct Player {
        address playerAddress;
        Level playerLevel;
        string firstName;
        string lastName;
        uint createTime;
    }
    function addPlayer (string memory firstName, string memory lastName) public {
        players[msg.sender] =Player (msg.sender, Level.Beginner, firstName, lastName, block.timestamp);
        playerCount += 1; 
    }
    function changePlayerLevel (address playerAddress) public {
        Player storage player = players[playerAddress] ;
        if (block.timestamp >= player.createTime +15){
            player.playerLevel = Level.Intermediate;
        }
    }
}