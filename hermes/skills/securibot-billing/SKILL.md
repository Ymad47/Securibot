---
name: securibot-billing
description: "Manage Stripe billing for audits (invoices, subscriptions, payments)"
version: 1.0.0
author: Damy (Hermes Hackathon 2026)
---

# SecuriBot Billing Skill

Handles all Stripe operations for SecuriBot SaaS.

## Stripe Products

| Product | Price | Type |
|---------|-------|------|
| Audit One-Shot | $499 | One-time |
| Monitoring Monthly | $299/mo | Subscription |

## Operations

### Create Invoice
```python
stripe.Invoice.create(
    customer=customer_id,
    items=[{"price": "price_audit_499"}],
    metadata={"audit_id": "..."}
)
```

### Create Checkout Session
```python
stripe.checkout.Session.create(
    line_items=[{"price": "price_audit_499", "quantity": 1}],
    mode="payment",
    success_url="https://securia.ymad.fr/dashboard?session_id={CHECKOUT_SESSION_ID}",
    cancel_url="https://securia.ymad.fr/audit/new"
)
```

### Handle Webhook
- `invoice.paid` → Trigger audit
- `checkout.session.completed` → Confirm payment
- `subscription.created` → Activate monitoring

## Workflow

1. User submits audit request
2. Create Stripe Checkout Session
3. Redirect user to payment
4. Webhook confirms payment
5. Hermes triggers scan workflow
6. Report delivered via email

## Environment Variables

```bash
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
STRIPE_PRICE_ID_AUDIT=price_...
STRIPE_PRICE_ID_MONITORING=price_...
```
