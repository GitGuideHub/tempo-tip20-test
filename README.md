## Tempo Moderato Testnet

All contracts and transactions in this repository
were redeployed and tested on the Tempo Moderato testnet.

This includes:
- Fresh TIP-20 deployment
- Memo-based payments
- Invoice payment flow
- Multi-address interaction


# tempo-tip20-test
Testing TIP-20 token standard on Tempo testnet with payment-oriented use cases (memo, approve, transferFrom).
# Tempo TIP-20 Testnet Participation

This repository documents my participation in the Tempo testnet
by deploying and testing a TIP-20 token focused on payment use cases.

## Overview
Tempo introduces TIP-20 as a payment-first token standard.
This project tests core primitives described in the documentation:
- stablecoin-style decimals
- memo-based transfers
- delegated payments via approve / transferFrom

## Contract details
- Network: Tempo Testnet
- Token name: Tempo Test USD
- Symbol: tUSD
- Decimals: 6
- Contract address: 0xPASTE_CONTRACT_ADDRESS

## Tested scenarios

### 1. Deployment
- Deployed custom TIP-20 contract from Remix
- Initial supply minted to deployer

### 2. Transfers
- Standard transfer between addresses
- Transfer with memo for payment reference

Examples of memos:
- invoice_001
- salary_feb
- rent_payment

### 3. Approve & transferFrom
- Approved spender address
- Executed delegated transfer with memo
- Simulated payroll / invoice settlement

## Why this matters
TIP-20 is designed for real payment flows.
This test focuses on realistic on-chain behavior
rather than synthetic transaction spam.

## Tools
- Remix IDE
- MetaMask
- Tempo Testnet

## Notes
This repository is intended as public feedback
and practical testing of the Tempo protocol.

## Additional payment scenario: Invoices

To further test TIP-20 payment capabilities,
a simple invoice-based payment contract was deployed.

Flow:
1. Invoice created with invoiceId as reference
2. Payer approves InvoicePayment contract
3. Invoice is settled via transferFrom with memo = invoiceId

This simulates real-world accounting and payroll flows
using TIP-20 memo-based transfers.

Network: Tempo Moderato Testnet


