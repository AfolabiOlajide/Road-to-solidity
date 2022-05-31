// writing my first contract

contract MyfirstContract {
    string name;

    // function to set the string
    function setName(string memory _name) public {
        name = _name;
    }

    // function to call/get name data
    function getName() public view returns (string memory) {
        return name;
    }
}
