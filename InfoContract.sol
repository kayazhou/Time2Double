pragma solidity ^0.4.21;

contract InfoContract {

    string fName;
    uint age;
    address public _owner;

    mapping (address => uint) public balance;

    event Instructor(
       string name,
       uint age
    );

    event Money(
        uint amount
    );

    // constructor() public {
    //     _owner = msg.sender;
    // }

    function () public payable{
        emit Money(msg.value);
    }

    function setInfo(string _fName, uint _age) public {
       fName = _fName;
       age = _age;
       emit Instructor(_fName, _age);
    }

    function getInfo() public constant returns (string, uint) {
       return (fName, age);
    }

    function getInvoker() constant public returns (address){
        return msg.sender;
    }
    function getOwnerBalance() constant public returns (uint256){
        return address(this).balance;
    }
}
