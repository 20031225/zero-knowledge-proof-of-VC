pragma solidity ^0.8.1;

//##########################################################################
//This contract is used to avoid replay attack and malleability attack  of zero-knowledge proof (ZKP), pi={a, b, c, public input}. 
//This contract will be imported into the contract, Cert_ZK_Proof_SC, and its functions such as set_cert_isused_sc_Status and read_Status
//are called respectively in Cert_ZK_Proof_SC .
//##########################################################################
contract Cert_IsUsed_SC{
    
    mapping(bytes32 => bool) cert_Status;
    
    address Authority_Address=0x6E819b34c53Dc81400D95ab87BFdBE3Ae80E2EA2;
    
    mapping(address => bool) legal_SC;
    

     
       function legal_IDP_register(address legal_SC_Addr) public {
        
        require ( msg.sender==Authority_Address,"Your identity is illegal");
            legal_SC[legal_SC_Addr]=true;
        
        
        }
    
    
    
  //###################################################################################
 //Set that pi has been used through proof_hash = keccak256(pi.public input)
 //###################################################################################     
   function set_cert_isused_sc_Status(bytes32 proof_hash) public {
        
        require (legal_SC[msg.sender]==true,"Your identity is illegal");
            cert_Status[proof_hash]=true;
        
        
        }

    //###################################################################################
 //read the status of pi to determine whether pi has been used
 //###################################################################################       
    function  read_Status(bytes32 proof_hash) public returns(bool){
        
        require (legal_SC[msg.sender]==true,"Your identity is illegal");
           return cert_Status[proof_hash];
        
        }       
       
       
        
    }
