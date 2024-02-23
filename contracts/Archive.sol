// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Archive {
    struct Cert {
        string userName;
        string id;
        string courseName;
        string issuingAuthority;
        string issueDate;
        address user;
        bool isAdded;
    }

    /** Mapping for certificates */
    mapping (address => mapping(string => Cert)) public certificates;

    /** Public functions */
    function addCertificate(
        string memory _userName,
        string memory _id,
        string memory _courseName,
        string memory _issuingAuthority,
        string memory _issueDate,
        address _user
    ) public {
        require(
            certificates[_user][_id].isAdded == false,
            "Certificate must not be already added."
        );

        require(
            bytes(certificates[_user][_id].id).length == 0,
            "Certificate id must be empty."
        );

        Cert memory cert = Cert({
            userName: _userName,
            id: _id,
            courseName: _courseName,
            issuingAuthority: _issuingAuthority,
            issueDate: _issueDate,
            user: _user,
            isAdded: true
        });

        certificates[_user][_id] = cert;
    }

    function getCertificate(address _user, string memory _id)
        public
        view
        returns(string memory, string memory, string memory, string memory) {
            require(
                _user != address(0),
                "User address must not be empty"
            );
            require(
                bytes(_id).length != 0,
                "Certificate id must not be empty."
            );

            return (
                certificates[_user][_id].userName,
                certificates[_user][_id].issuingAuthority,
                certificates[_user][_id].courseName,
                certificates[_user][_id].issueDate
            );
    }
}
