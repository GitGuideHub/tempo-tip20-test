// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITIP20 {
    function transferFrom(
        address from,
        address to,
        uint256 amount,
        bytes32 memo
    ) external returns (bool);
}

contract InvoicePayment {
    ITIP20 public token;
    address public owner;

    struct Invoice {
        address payer;
        address payee;
        uint256 amount;
        bool paid;
    }

    mapping(bytes32 => Invoice) public invoices;

    event InvoiceCreated(
        bytes32 indexed invoiceId,
        address payer,
        address payee,
        uint256 amount
    );

    event InvoicePaid(
        bytes32 indexed invoiceId,
        address payer,
        address payee,
        uint256 amount
    );

    constructor(address _token) {
        token = ITIP20(_token);
        owner = msg.sender;
    }

    function createInvoice(
        bytes32 invoiceId,
        address payer,
        address payee,
        uint256 amount
    ) external {
        require(invoices[invoiceId].payer == address(0), "Invoice exists");

        invoices[invoiceId] = Invoice({
            payer: payer,
            payee: payee,
            amount: amount,
            paid: false
        });

        emit InvoiceCreated(invoiceId, payer, payee, amount);
    }

    function payInvoice(bytes32 invoiceId) external {
        Invoice storage inv = invoices[invoiceId];
        require(!inv.paid, "Already paid");

        inv.paid = true;

        token.transferFrom(
            inv.payer,
            inv.payee,
            inv.amount,
            invoiceId
        );

        emit InvoicePaid(invoiceId, inv.payer, inv.payee, inv.amount);
    }
}
