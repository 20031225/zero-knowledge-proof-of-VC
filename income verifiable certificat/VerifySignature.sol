pragma solidity ^0.4.10;

//##########################################################################################################
//this contract is used to implement on-chain verification of the digital signature
//of IDP, Sign(Sign_H), attached to VC to ensure that VC used to generate zero-knowledge proof (ZPK)  is issued by legal IDP. 
//##########################################################################################################

contract VerifySignature{

  function verifyByHashAndSig(bytes32 hash, bytes signature) public view returns (address){
  
  //##########################################################################################################
//The output of this function is the address of Ethereum account of identity provider (IDP) and through this
//address, service provider can determine whether VC used to generate zero-knowledge proof (ZPK)  is issued by legal IDP.

//The input of this function contains:
//hash: It is the hash digest of VC, namely Sign_H and hash(Sign_H)=keccak256 (Attribute || User DID || IDP DID)
//signature: It is the digital signature of VC and signature=sign(Sign_H). Futhermore, the algorithm of signature is ECDSA
// and IDP can use web3.js of Ethereum to implement the signature.
//##########################################################################################################
  
    bytes memory signedString = signature;
    uint8 v;
    
    bytes32  r = bytesToBytes32(slice(signedString, 0, 32));
    bytes32  s = bytesToBytes32(slice(signedString, 32, 32));
    byte  v1 = slice(signedString, 64, 1)[0];
   // if(uint8(v1)<28){
    v = uint8(v1);//}
  //  else{
  //   v = uint8(v1); 
 //   }
    return ecrecoverDirect(hash, r, s, v);
  }


  function slice(bytes memory data, uint start, uint len) returns (bytes){
    bytes memory b = new bytes(len);

    for(uint i = 0; i < len; i++){
      b[i] = data[i + start];
    }
    return b;
  }


  function bytesToBytes32(bytes memory source) returns (bytes32 result) {
    assembly {
        result := mload(add(source, 32))
    }
  }


  function ecrecoverDirect(bytes32 hash, bytes32 r, bytes32 s, uint8 v) returns (address addr){
     /* prefix might be needed for geth only
     * https://github.com/ethereum/go-ethereum/issues/3731
     */
     bytes memory prefix = "\x19Ethereum Signed Message:\n32";
     hash = sha3(prefix, hash);
     
//##########################################################################################################
//ecrecover() is the verification function of signature precompiled in Ethereum
//##########################################################################################################
     addr = ecrecover(hash, v, r, s);
  }
}
