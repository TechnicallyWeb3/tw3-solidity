// SPDX-License-Identifier: MIT
// TechnicallyWeb3[Invoice.sol] Updated version 0.1.0

pragma solidity ^0.8.20;

/**
 * @title Invoicing Smart Contract
 * @dev Utilities for greating smart contract invoices
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @title Invoice Smart Contract
/// @notice This contract manages the creation, sending, and payment of invoices
/// @dev All function calls are currently implemented without side effects
contract InvoiceContract {
    /// @notice Emitted when an invoice is sent to a client
    /// @param invoiceNum The unique identifier of the invoice
    /// @param vendor The address of the vendor who sent the invoice
    /// @param client The address of the client receiving the invoice
    /// @param totalAmount The total amount of the invoice
    event InvoiceSent(
        uint256 indexed invoiceNum,
        address indexed vendor,
        address indexed client,
        uint256 totalAmount
    );

    /// @notice Emitted when a payment is made towards an invoice
    /// @param invoiceNum The unique identifier of the invoice
    /// @param payer The address of the account making the payment
    /// @param amount The amount paid
    /// @param remainingBalance The remaining balance on the invoice after this payment
    event PaymentReceived(
        uint256 indexed invoiceNum,
        address indexed payer,
        uint256 amount,
        uint256 remainingBalance
    );

    /// @notice Emitted when an invoice is updated
    /// @param invoiceNum The unique identifier of the invoice
    /// @param updater The address of the account updating the invoice
    /// @param newStatus The new status of the invoice
    event InvoiceUpdated(
        uint256 indexed invoiceNum,
        address indexed updater,
        Status newStatus
    );

    /// @notice Emitted when an invoice is cancelled
    /// @param invoiceNum The unique identifier of the invoice
    /// @param canceller The address of the account cancelling the invoice
    event InvoiceCancelled(
        uint256 indexed invoiceNum,
        address indexed canceller
    );

    /// @notice Ensures only the vendor of an invoice can call a function
    /// @param _invoiceNum The invoice number to check
    modifier IsVendor(uint256 _invoiceNum) {
        require(
            invoices[_invoiceNum].vendor == msg.sender,
            "Only vendor can perform this action"
        );
        _;
    }

    /// @notice Represents the current status of an invoice
    enum Status {
        DRAFT,
        SENT,
        PARTIAL_PAYMENT,
        PAID,
        CANCELLED,
        LATE,
        OVERDUE,
        UNCOLLECTABLE
    }

    /// @notice Represents a single item in an invoice
    struct LineItem {
        string sku;
        string title;
        string description;
        uint256 amount;
        uint16 tax;
    }

    /// @notice Defines the payment terms for an invoice
    struct Terms {
        IERC20 paymentToken;
        uint16[] payments;
        uint16[] milestones;
        uint256[] dueDates;
    }

    /// @notice Represents a payment made towards an invoice
    struct Payment {
        uint256 amount;
        uint256 date;
        address payer;
    }

    /// @notice Represents a complete invoice
    struct Invoice {
        Status invoiceStatus;
        string referenceNum;
        uint256 invoiceDate;
        address client;
        address vendor;
        address paymentAddress;
        Terms terms;
    }

    uint256 private currentInvoiceNumber;

    mapping(string => uint256) public invoiceNum;
    mapping(uint256 => Invoice) private invoices;
    mapping(address => Terms) private vendorTerms;
    mapping(uint256 => LineItem[]) private invoiceItems;
    mapping(uint256 => Payment[]) private invoicePayments;

    /// @notice Initializes the contract with default vendor terms
    /// @param _paymentToken Address of the token accepted for invoices
    /// @param _paymentTerms Array of payment percentages (in basis points)
    /// @param _paymentMilestones Array of project completion percentages for each payment
    /// @param _paymentDates Array of durations between invoice date and due dates
    constructor(
        address _paymentToken,
        uint16[] memory _paymentTerms,
        uint16[] memory _paymentMilestones,
        uint256[] memory _paymentDates
    ) {
        setVendorTerms(
            msg.sender,
            _paymentToken,
            _paymentTerms,
            _paymentMilestones,
            _paymentDates
        );
    }

    /// @notice Generates a new invoice
    /// @param _referenceNum A unique reference number for the invoice
    /// @param _client Address of the client
    /// @param _paymentAddress Address where payments should be sent
    /// @param _items Array of line items for the invoice
    function generateInvoice(
        string memory _referenceNum,
        address _client,
        address _paymentAddress,
        LineItem[] memory _items
    ) public {
        require(vendorTerms[msg.sender].payments.length > 0, "Vendor terms not defined");
        currentInvoiceNumber++;
        invoices[currentInvoiceNumber] = Invoice(
            Status.DRAFT,
            _referenceNum,
            block.timestamp,
            _client,
            msg.sender,
            _paymentAddress,
            vendorTerms[msg.sender]
        );

        replaceInvoiceItems(currentInvoiceNumber, _items);
    }

    /// @notice Sends an invoice to the client
    /// @param _invoiceNum The invoice number to send
    function sendInvoice(uint256 _invoiceNum) external IsVendor(_invoiceNum) {
        invoices[_invoiceNum].invoiceStatus = Status.SENT;
        invoices[_invoiceNum].invoiceDate = block.timestamp;
    }

    /// @notice Allows a client to pay an invoice
    /// @param _invoiceNum The invoice number being paid
    /// @param _amount The amount being paid
    function payInvoice(uint256 _invoiceNum, uint256 _amount) external {
        require(
            invoices[_invoiceNum].invoiceStatus == Status.SENT,
            "Invoice not sent"
        );
        require(_amount > 0, "Amount must be greater than 0");
        require(
            _amount <=
                invoices[_invoiceNum].terms.paymentToken.balanceOf(msg.sender),
            "Insufficient balance"
        );
        require(
            invoices[_invoiceNum].terms.paymentToken.transferFrom(
                msg.sender,
                invoices[_invoiceNum].paymentAddress,
                _amount
            ),
            "Transfer failed"
        );

        Invoice storage invoice = invoices[_invoiceNum];

        invoicePayments[_invoiceNum].push(Payment(_amount, block.timestamp, msg.sender));
        emit InvoiceSent(
            currentInvoiceNumber,
            msg.sender,
            invoice.client,
            invoiceItems[_invoiceNum].length
        );

        // Update invoice status based on payment...
    }

    /// @notice Cancels an invoice
    /// @param _invoiceNum The invoice number to cancel
    function cancelInvoice(uint256 _invoiceNum) external IsVendor(_invoiceNum) {
        invoices[_invoiceNum].invoiceStatus = Status.CANCELLED;
        emit InvoiceCancelled(currentInvoiceNumber, msg.sender);
    }

    /// @notice Updates the line items of an invoice
    /// @param _invoiceNum The invoice number to update
    /// @param _items The new array of line items
    function updateInvoice(
        uint256 _invoiceNum,
        LineItem[] memory _items
    ) external IsVendor(_invoiceNum) {
        replaceInvoiceItems(_invoiceNum, _items);
    }

    /// @notice Retrieves detailed information about an invoice
    /// @param _invoiceNum The invoice number to query
    /// @return invoice The full Invoice struct
    /// @return amountDue The current amount due based on milestones
    /// @return totalDue The total amount due for the entire invoice
    /// @return amountPaid The amount already paid
    /// @return remainingBalance The remaining balance to be paid
    /// @return nextDueDate The next due date (if applicable)
    function getInvoice(
        uint256 _invoiceNum
    )
        external
        view
        returns (
            Invoice memory invoice,
            uint256 amountDue,
            uint256 totalDue,
            uint256 amountPaid,
            uint256 remainingBalance,
            uint256 nextDueDate
        )
    {
        
        invoice = invoices[_invoiceNum];
        // Calculate totalDue, amountDue, amountPaid, remainingBalance, and nextDueDate...
        // Calculate totalDue
        totalDue = 0;
        for (uint256 i = 0; i < invoiceItems[_invoiceNum].length; i++) {
            totalDue += invoiceItems[_invoiceNum][i].amount;
        }

        // Calculate amountPaid
        amountPaid = 0;
        for (uint256 i = 0; i < invoicePayments[_invoiceNum].length; i++) {
            amountPaid += invoicePayments[_invoiceNum][i].amount;
        }

        // Calculate remainingBalance
        remainingBalance = totalDue > amountPaid ? totalDue - amountPaid : 0;

        // Calculate amountDue and nextDueDate based on milestones
        amountDue = 0;
        nextDueDate = 0;
        for (uint256 i = 0; i < invoice.terms.milestones.length; i++) {
            if (block.timestamp < invoice.terms.dueDates[i] && nextDueDate == 0) {
                nextDueDate = invoice.terms.dueDates[i] + invoice.invoiceDate;
                amountDue = invoice.terms.payments[i] * totalDue / 10000;
                break;
            }
        }

        // Ensure amountDue doesn't exceed remainingBalance
        amountDue = amountDue > remainingBalance
            ? remainingBalance
            : amountDue;
    }

    function setVendorTerms(
        address _vendorAddress,
        address _paymentToken,
        uint16[] memory _payments,
        uint16[] memory _milestones,
        uint256[] memory _dueDates
    ) internal {
        require(_payments.length == _milestones.length && _milestones.length == _dueDates.length, "Arrays must have the same length");
        require(_payments.length > 0, "At least one payment milestone is required");

        uint16 totalPayments = 0;
        uint16 prevMilestone = 0;
        uint256 prevDueDate = 0;

        for (uint256 i = 0; i < _payments.length; i++) {
            totalPayments += _payments[i];
            require(_milestones[i] > prevMilestone && _milestones[i] <= 10000, "Milestones must be increasing and <= 10000");
            require(_dueDates[i] > prevDueDate && _dueDates[i] <= 10 * 365 days, "Due dates must be increasing and <= 10 years");
            
            prevMilestone = _milestones[i];
            prevDueDate = _dueDates[i];
        }

        require(totalPayments == 10000, "Total payments must equal 10000");

        vendorTerms[_vendorAddress] = Terms(
            IERC20(_paymentToken),
            _payments,
            _milestones,
            _dueDates
        );
    }

    function replaceInvoiceItems(uint256 _invoiceNum, LineItem[] memory _items) internal {
        delete invoiceItems[_invoiceNum];
        for (uint256 i = 0; i < _items.length; i++) {
            invoiceItems[_invoiceNum].push(_items[i]);
        }
    }
}
