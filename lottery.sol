// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lottery{
    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor(){
        manager=msg.sender;
    }

    function participent() public payable  {
         require(msg.value==10 wei,"only 1 eather is required ");
         players.push(payable (msg.sender));
    }
    function getbalance() public view returns(uint){
        require(msg.sender==manager,"only manager can access this");
        return address(this).balance;
    }
    function random() internal view returns(uint){
        return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,players.length)));
    }
   function pickwinner() public {
    require(manager==msg.sender,"you are not manager");
    require(players.length>=3,"atleast 3 players are required");

    uint r=random();
    uint index=r%players.length;
    winner=players[index];
    winner.transfer(getbalance());
    players=new address payable[](0);

   }   
}