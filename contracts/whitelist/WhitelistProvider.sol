pragma solidity ^0.4.17;
import "../permission/PermissionProviderInterface.sol";

contract WhitelistProvider {

    PermissionProviderInterface internal permissionProvider;

    mapping (address=>bool) whitelistAddresses;
    bool public enabled;

    function WhitelistProvider(address _permissionProvider) public {
        permissionProvider = PermissionProviderInterface(_permissionProvider);
    }

    modifier onlyWhitelistOwner() {
        require(permissionProvider.has(msg.sender, permissionProvider.ROLE_WHITELIST_OWNER()));
        _;
    }

    function enable() public onlyWhitelistOwner returns(bool){
        enabled = true;
    }

    function disable() public onlyWhitelistOwner returns(bool){
        enabled = false;
    }

    function setAllowed(address[] accounts, bool isAllowed) public onlyWhitelistOwner returns(bool){

        for(uint i = 0; i < accounts.length; i++){
            require(accounts[i] != 0x0);
            whitelistAddresses[accounts[i]] = isAllowed;
        }
        return true;
    }

    function isAllowed(address account) external view returns(bool){
        return enabled ? whitelistAddresses[account] : true;
    }
}
