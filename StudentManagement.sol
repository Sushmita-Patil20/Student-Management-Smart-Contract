// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentManagement {

    struct Student {
        uint256 id;
        string name;
        uint256 marks;
        bool exists;
    }

    address public owner;
    uint256 public studentCount;

    mapping(uint256 => Student) public students;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can modify records");
        _;
    }

    function addStudent(
        string memory _name,
        uint256 _marks
    ) public onlyOwner {
        require(_marks <= 100, "Marks cannot exceed 100");

        studentCount++;

        students[studentCount] = Student(
            studentCount,
            _name,
            _marks,
            true
        );
    }

    function updateMarks(
        uint256 _id,
        uint256 _marks
    ) public onlyOwner {
        require(students[_id].exists, "Student does not exist");
        require(_marks <= 100, "Invalid marks");

        students[_id].marks = _marks;
    }

    function getStudent(
        uint256 _id
    ) public view returns (
        uint256,
        string memory,
        uint256,
        string memory
    ) {
        require(students[_id].exists, "Student does not exist");

        string memory result =
            students[_id].marks >= 35 ? "PASS" : "FAIL";

        return (
            students[_id].id,
            students[_id].name,
            students[_id].marks,
            result
        );
    }
}
