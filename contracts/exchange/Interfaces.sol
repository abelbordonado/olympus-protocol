pragma solidity ^0.4.17;

import "../libs/ERC20.sol";
import {StorageTypeDefinitions as STD} from "../storage/OlympusStorage.sol";
import "./ExchangeAdapterBase.sol";

interface IOlympusLabsCore {
    function updateOrderStatus(uint orderId, STD.OrderStatus status) external returns(bool);
}

interface IExchangeProvider{
    function placeOrder(uint orderId, ERC20[] tokenAddresses, uint[] amount, uint[] rates, address deposit) external payable returns (bool);
    function canceOrder(uint orderId) external returns(bool);
    function getOrderStauts(uint orderId) external view returns(uint);
}

interface IExchangeAdapterManager {
    function pickExchange(ERC20 token, uint amount, uint rate) external view returns (bytes32 exchangeId);
    function checkTokenSupported(ERC20 token) external view returns(bool);
    function getExchangeAdapter(bytes32 exchangeId) external view returns(address);
    function isValidAdapter(address adapter) external view returns(bool);
}

interface IAdapterOrderCallback{
    function adapterOrderStatusUpdated(address exchange, uint adapterOrderId) external returns(bool);
    function adapterApproved(uint adapterOrderId, address tokenOwner, address payee, uint srcCompletedAmount, uint destCompletedAmount) external returns (bool);
}

interface IExchangeAdapter{

    // returns the order id from the adapter, if success. Nothing to do with the real order Id.
    function placeOrder(bytes32 exchangeId, ERC20 dest, uint amount, uint rate, address deposit) external payable returns(uint adapterOrderId);

    // pay when the order is succeeded.
    function payOrder(uint adapterOrderId) external payable returns(bool);

    // cancel the order according to the orderId of the adatper.
    function cancelOrder(uint adapterOrderId) external returns(bool);

    function getOrderStatus(uint adapterOrderId) external view returns(ExchangeAdapterBase.OrderStatus);
    function getDestCompletedAmount(uint adapterOrderId) external view returns(uint);

    /// >0 : current exchange rate
    /// =0 : not support
    /// <0 : support but doesn't know rate
    function getRate(bytes32 exchangeId, ERC20 token, uint amount) external view returns (int);
    function isEnabled(bytes32 _id) external view returns (bool);

    function getExchange(bytes32 _id) external view returns(bytes32 name, ExchangeAdapterBase.Status status);

    function addExchange(bytes32 _id, bytes32 _name) external returns(bool);
}
