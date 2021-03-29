// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.8.0;

/**
 * @title entryCode
 * @dev Enter a code to unlock a new output
 * Find the quickest way to get to uint8 156
 * 
 * Spoiler: The code is xOr1, xOr2, addOneToCode, shiftCode
 */
contract entryCode {
    
    bool internal access;   // When true, access allows for new path in getAccess
    uint8 internal code;    // The code to check
    
    constructor () {
        access = false;
        code = 0;
    }
    
    /**
     * @dev Convert uint8 to binary sting, aid in flag viewing
     **/
    function toBinaryString(uint8 n) internal pure returns (string memory) {
        // Require input to stay under the size of a byte
        require(n < 256);

        bytes memory output = new bytes(8);

        for (uint8 i = 0; i < 8; i++) {
            output[7 - i] = (n % 2 == 1) ? byte("1") : byte("0");
            n /= 2;
        }

        return string(output);
    }

    /**
     * @dev Store 0 in uint8 code
     */
    function resetCode() public {
        code = 0;
    }
    
    /**
     * @dev Add 1 to code value
     */
    function addOneToCode() public {
        code += 1;
    }
    
    /**
     * @dev Shift value in variable
     */
    function shiftCode() public {
        code = code << 1;
    }
    
    /**
     * @dev xOr with hidden number 1
     */
    function xOr1() public {
        code = code ^ 170; // 0xbAA
    }
    
    /**
     * @dev Or with hidden number 2
     */
    function xOr2() public {
        code = code ^ 231; // 0xbE7
    }

    /**
     * @dev Return value of code as uint8
     * @return value of code
     */
    function getNumber() public view returns (uint8){
        return code;
    }
    
    /**
     * @dev Return value of code as string of binary conversion
     * @return string of bianry code
     */
    function getBinary() public view returns (string memory){
        string memory code_output = toBinaryString(code);
        return code_output;
    }
    
    /**
     * @dev Modify lock access based on code value 
     * If code is binary 10011100, 0xb9C, 156, allow access
     */
    function checkAccess() public {
        if (code == 156) {
            access = true;
        } else {
            access = false;
        }
    }
    
    /**
     * @dev Return lock access output, depends on checkAccess function
     * @return value of 'access'
     * 
     */
    function getAccess() public view returns (string memory){
        if (access == true) {
            return "Congratulations, you've cracked the code!";
        }
        
        return "false";
    }
}