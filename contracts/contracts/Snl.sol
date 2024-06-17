// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SNL is ERC721 {
    uint256 constant boardSize = 72;
    uint256 constant diceSides = 6;

    uint256 private _nextTokenId;

    bool public gameStarted;

    mapping(uint256 => uint256) snakes;
    mapping(uint256 => uint256) ladders;

    mapping(address => Player) public players;

    struct Player {
        uint256 playerPosition;
        bool isStarted;
        bool isActive;
    }

    event PlayerJoined(address indexed playerAddr, uint256 time);

    event PlayerMoved(address player, uint256 position);

    event GameWon(address player, uint256 time);

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        // Initialize snakes and ladders positions
        // const snakepoints = [10,1, 27,9, 24, 15,31,23, 43, 26, 40, 30, 58, 39, 70, 51, 65, 55];
        snakes[10] = 1;
        snakes[27] = 9;
        snakes[24] = 15;
        snakes[31] = 23;
        snakes[43] = 26;
        snakes[40] = 30;
        snakes[58] = 39;
        snakes[70] = 51;
        snakes[65] = 55;
        // const ladderpoints =  [3, 12, 8, 16,  13, 22,  19, 30, 33, 52, 36, 44, 37, 47, 50,69, 54, 63];
        ladders[3] = 12;
        ladders[8] = 16;
        ladders[13] = 22;
        ladders[19] = 30;
        ladders[33] = 52;
        ladders[36] = 44;
        ladders[37] = 47;
        ladders[50] = 69;
        ladders[54] = 63;
    }

    function joinGame() public {
        require(
            players[msg.sender].isStarted == false,
            "player has already joined!"
        );
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        players[msg.sender] = Player(0, true, true);
        emit PlayerJoined(msg.sender, block.timestamp);
    }

    function rollDice() public {
        require(players[msg.sender].isStarted, "Game has not started");
        require(players[msg.sender].isActive, "User not authorized");
        uint256 diceRoll = (uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender))
        ) % diceSides) + 1;
        movePlayer(diceRoll);
    }

    function movePlayer(uint256 diceRoll) internal {
        uint256 newPosition = players[msg.sender].playerPosition + diceRoll;

        if (newPosition > boardSize) {
            newPosition = players[msg.sender].playerPosition;
        } else {
            if (snakes[newPosition] != 0) {
                newPosition = snakes[newPosition];
            } else if (ladders[newPosition] != 0) {
                newPosition = ladders[newPosition];
            }

            players[msg.sender].playerPosition = newPosition;
            emit PlayerMoved(msg.sender, newPosition);

            if (newPosition == boardSize) {
                players[msg.sender].isActive = false;
                emit GameWon(msg.sender, block.timestamp);
            }
        }
    }
}
