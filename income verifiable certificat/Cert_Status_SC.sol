pragma solidity ^0.8.1;

//#################################################################
//this contract is used to manage the status of verifiable certificate (VC)
//which has been issued, and when the status of this contract is active,
//the corresponding VC is valid, otherwise invalid.
//##################################################################  

contract Cert_Status_SC{
            
  //   address IDP_income=0x544a194e6E4857927Fc88a8454dab267103e51e3;
  //   address IDP_age=0x6E819b34c53Dc81400D95ab87BFdBE3Ae80E2EA2;
    
   
    mapping(address => bool) legal_IDP;
    
    mapping(bytes32 => bool) Cert_Status;
    
//#################################################################
//Ethereum account address of deploying this contract's authority
//##################################################################
    address  Authority_Address=0x6E819b34c53Dc81400D95ab87BFdBE3Ae80E2EA2;


//#################################################################
//Legal identity providers (IDPs) need to be registered through this function
//################################################################## 
       function legal_IDP_register(address IDP_DID) public {
        
        require ( msg.sender==Authority_Address,"Your identity is illegal");
            legal_IDP[IDP_DID]=true;
        
        
        }
    
    
//#################################################################
//Using this function to activate the status of VC which has been issued
//##################################################################     
   function Set_Status_Active(bytes32 Sign_H) public {
        
        require ( legal_IDP[msg.sender]==true,"Your identity is illegal");
            Cert_Status[Sign_H]=true;
        
        
        }


//#################################################################
//Using this function to revoke the status of VC which has been issued
//################################################################## 
   function  Set_Status_Revocation(bytes32 Sign_H) public {
        
        require (legal_IDP[msg.sender]==true,"Your identity is illegal");
            Cert_Status[Sign_H]=false;
        
        }       
        
 //#################################################################
//Using this function to see whether VC is active
//##################################################################        
    function  read_Status(bytes32 Sign_H) public view returns(bool){
        
   //     require (legal_IDP[msg.sender]==true,"Your identity is illegal");
           return Cert_Status[Sign_H];
     //        return msg.sender;
        
        }       
       
       
        
    }
    
    
    
