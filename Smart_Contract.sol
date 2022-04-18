// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Distribution{
    address public owner;
    uint public fortune;
    bool dead;

    constructor() payable public
    {
        owner= msg.sender;
        fortune=msg.value;
        dead=false;

    }

    modifier OnlyOwner{
        require(msg.sender==owner);
        _;

    }
    modifier isDead
    {
        require(dead==true);
        _;
    }

   address payable[] public familyWallets;

mapping(address => uint) inherit;

function setinherit(address payable wallet, uint amount) OnlyOwner public {
    familyWallets.push(wallet);
    inherit[wallet]= amount;
}

function payout() isDead private{
for(uint i=0;i<familyWallets.length;i++)
{
    familyWallets[i].transfer(inherit[familyWallets[i]]);
}
}
function deceased() public OnlyOwner {
    dead=true;
    payout();
}





}