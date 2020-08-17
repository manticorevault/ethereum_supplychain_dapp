pragma solidity ^0.4.24;

// Define a Supply Chain contract
contract SupplyChain {
    // Define "owner"
    address owner;

    // Define a variable called "upc" for Universal Product Code
    uint upc;

    // Define a variable called "sku" for Stock Keeping Unit
    uint sku;

    // Define a public mapping "items" that maps the UPC to an Item
    mapping(uint => Item) items;

    // Define a public mapping 'itemsHistory' that maps the UPC to an array of TxHash, 
    // that track its journey through the supply chain -- to be sent from DApp.
    mapping (uint => string[]) itemsHistory;

    // Define enum "State" 
    enum State 
    {
        Harvested, 
        Processed,
        Packed,
        ForSale,
        Sold,
        Shipped,
        Received,
        Purchased
    }

    State constant defaultState = State.Harvested;

    // Define a struct "Item" 
    struct Item {
        uint sku;
        uint upc;
        address ownerID;
        address originFarmerID;
        string originFarmName;
        string originFarmInformation;
        string originFarmLatitude;
        string originFarmLongitude;
        uint productID;
        string productNotes;
        uint productPrice;
        State itemState;
        address distributorID;
        address retailerID;
        address consumerID;
    }

    // Define 8 events with the same state values and accept "upc" as input argument
    event Harvested(uint upc);
    event Processed(uint upc);
    event Packed(uint upc);
    event ForSale(uint upc);
    event Sold(uint upc);
    event Shipped(uint upc);
    event Received(uint upc);
    event Purchased(uint upc);

    // Define a modifier that checks to see if msg.sender == owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Define a modifier that verifies the Caller
    modifier verifyCaller (address _address) {
        require(msg.sender == _address);
        _;
    }

    // Define a modifier that checks if the paid amount is sufficient to cover the price
    modifier paidEnough(uint _price) {
        require(msg.value >= _price);
        _;
    }

    // Define a modifier that checks the price and refunds the remaining balance
    modifier checkValue(uint _upc) {
        _;
        uint _price = items[_upc].productPrice;
        uint amountToReturn = msg.value - _price;
        items[_upc].consumerID.transfer(amountToReturn);
    }

    // Define a modifier that checks if an item.state of an upc is Harvested
    modifier harvested(uint _upc) {
        require(items[_upc].itemState == State.Harvested);
        _;
    }

    // Define a modifier that checks if an item.state of an upc is Processed
    modifier processed(uint _upc) {
        require(items[_upc].itemState == State.Processed);
        _;
    }

    // Define a modifier that checks if an item.state of an upc is Packed
    modifier packed(uint _upc) {
        require(items[_upc].itemState == State.Packed);
        _;
    }

    // Define a modifier that checks if an item.state of an upc is ForSale
    modifier forSale(uint _upc) {
        require(items[_upc].itemState == State.ForSale);
        _;
    }

    // Define a modifier that checks if an item.state of an upc is Sold
    modifier sold(uint _upc) {
        require(items[_upc].itemState == State.Sold);
        _;
    }

    // Define a modifier that checks if an item.state of an upc is Shipped
    modifier shipped(uint _upc) {
        require(items[_upc].itemState == State.Shipped);
        _;
    }

    // Define a modifier that checks if an item.state of an upc is Received
    modifier received(uint _upc) {
        require(items[_upc].itemState == State.Received);
        _;
    }
    
    // Define a modifier that checks if an item.state of an upc is Purchased
    modifier purchased(uint _upc) {
        require(items[_upc].itemState == State.Purchased);
        _;
    }

    // In the constructor set 'owner' to the address that instantiated the contract
    // and set 'sku' to 1
    // and set 'upc' to 1
    constructor() public payable {
        owner = msg.sender;
        sku = 1;
        upc = 1;
    }

    // Define a function "kill" if required
    function kill() public {
        if(msg.sender == owner) {
            selfdestruct(owner);
        }
    }

    // Define a function "harvestItem" that allos a farmer to mark an item as "Harvested"
    function harvestItem(uint _ipc, address _originFarmerID, string _originFarmName, string _originFarmInformation, string _originFarmLatitude, string _originFarmLongitude, string _productNotes) public {
        // Add the new item as parte of Harvest

        // Increment sku
        sku = sku + 1;

        //Emit the appropriate event
    }

    // Define a function "processItem" that allows a farmer to mark an item as "Processed"
    // Call modifier to check if upc has passed previous supply chain state
    // Call modifier to very caller of this function
    function processItem(uint _upc) public {
        // Update the appropriate fields
        
        // Emit the appropriate event
    }

    // Define a function "packItem" that allows a farmer to mark an item "Packed"
    // Call modifier to check if upc has passed previous supply chain stage
    // Call modifier to verify caller of this function
    function packItem(uint _upc) public {
        // Update the appropriate fields

        // Emit the appropriate event
    }

    // Define a function "sellItem" that allows a farmer to mark an item "ForSale"
    // Call modifier to check if upc has passed previous supply chain stage
    // Call modifier to verify caller of this function
    function sellItem(uint _upc) public {
        // Update the appropriate fields

        // Emit the appropriate event
    }

    // Define a function 'buyItem' that allows the disributor to mark an item 'Sold'
    // Use the above defined modifiers to check if the item is available for sale, if the buyer has paid enough, 
    // and any excess ether sent is refunded back to the buyer
    // Call modifier to check if upc has passed previous supply chain stage
    // Call modifer to check if buyer has paid enough
    // Call modifer to send any excess ether back to buyer
    function buyItem(uint _upc) public payable {
        // Update the appropriate fields - ownerID, distributorID, itemState

        // Transfer money to farmer

        // emit the appropriate event
    }

    // Define a function "shipItem" that allows a farmer to mark an item "Shipped"
    // Use the above modifers to check if the item is sold
    // Call modifier to check if upc has passed previous supply chain stage
    // Call modifier to verify caller of this function
    function shipItem(uint _upc) public {
        // Update the appropriate fields

        // Emit the appropriate event
    }

    // Define a function "receiveItem" that allows a farmer to mark an item "Received"
    // Use the above modifiers to check if the item is shipped
    // Call modifier to check if upc has passed previous supply chain stage
    // Access Control List enforced by calling Smart Contract / DApp
    function receiveItem(uint _upc) public {
        // Update the appropriate fields - ownerID, retailerID, itemState

        // Emit the appropriate event
    }

    // Define a function 'purchaseItem' that allows the consumer to mark an item 'Purchased'
    // Use the above modifiers to check if the item is received
    // Call modifier to check if upc has passed previous supply chain stage
    // Access Control List enforced by calling Smart Contract / DApp
    function purchaseItem(uint _upc) public {
        // Update the appropriate fields - ownerID, retailerID, itemState

        // Emit the appropriate event
    }
  // Define a function 'fetchItemBufferOne' that fetches the data
  function fetchItemBufferOne(uint _upc) public view returns (
    uint itemSKU,
    uint itemUPC,
    address ownerID,
    address originFarmerID,
    string memory originFarmName,
    string memory originFarmInformation,
    string memory originFarmLatitude,
    string memory originFarmLongitude
  )
  {
  // Assign values to the 8 parameters
    itemSKU = items[_upc].sku;
    itemUPC = items[_upc].upc;
    ownerID = items[_upc].ownerID;
    originFarmerID = items[_upc].originFarmerID;
    originFarmName = items[_upc].originFarmName;
    originFarmInformation = items[_upc].originFarmInformation;
    originFarmLatitude = items[_upc].originFarmLatitude;
    originFarmLongitude = items[_upc].originFarmLongitude;
  }

  // Define a function 'fetchItemBufferTwo' that fetches the data
  function fetchItemBufferTwo(uint _upc) public view returns (
    uint itemSKU,
    uint itemUPC,
    uint productID,
    string memory productNotes,
    uint productPrice,
    uint itemState,
    address distributorID,
    address retailerID,
    address consumerID
  )
  {
    // Assign values to the 9 parameters
    itemSKU = items[_upc].sku;
    itemUPC = items[_upc].upc;
    productID = items[_upc].productID;
    productNotes = items[_upc].productNotes;
    productPrice = items[_upc].productPrice;
    itemState = uint(items[_upc].itemState);
    distributorID = items[_upc].distributorID;
    retailerID = items[_upc].retailerID;
    consumerID = items[_upc].consumerID;
  }
}