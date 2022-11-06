pragma solidity ^0.8.17;

contract Owner {

address owner ;


constructor(){

    owner =msg.sender;
    }

modifier isOwner() {
require(owner == msg.sender,"not the owner");
    _;
    }
}