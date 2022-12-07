pragma solidity ^0.8.0;

contract Lottery {

    address[] public members;
    address public manager;
    event SendEthToWinner (address account, uint amount);
    modifier restricted(){
        require(msg.sender == manager); 
        _;
    }

    constructor () {
         manager = msg.sender;
    }

    function buyLottery() public payable {
        //require(msg.value == 1 ether, "Balance in account should be equal to 1 ETH");
        members.push(msg.sender);
    }
     
    function genRandomWinner() private view returns(uint) {
        return (uint(keccak256(abi.encodePacked(block.timestamp, members.length))));
    }

    function pickWinner() public restricted {
        uint index = genRandomWinner() % members.length;
        payable (members[index]).transfer(address(this).balance); 
        members = new address[](0);
    }

    receive() external payable {
    }
}
