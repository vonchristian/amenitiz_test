# Amenitiz Technical Test – Cash Register App

This is a Rails 8 application built to demonstrate a modular, maintainable, and testable checkout system with promotions.

---
## Live Preview

You can preview the app using the following URL:

🔗 **http://192.34.59.50/carts/1**

<img width="1111" alt="Screenshot 2025-06-20 at 9 07 02 AM" src="https://github.com/user-attachments/assets/b65852b5-df6b-482a-9698-2d3e5be4e196" />


## Tech Stack

- **Ruby on Rails 8**
- **PostgreSQL**
- **Tailwind CSS** (via `cssbundling-rails`)
- **Hotwire (Turbo + Stimulus)** for real-time UX
- **ActiveInteraction** for service orchestration
- **Money-Rails** for handling money and currencies
- **RSpec + FactoryBot + Capybara** for testing

---


### Code Structure

| Component         | Purpose                                                                 |
|-------------------|-------------------------------------------------------------------------|
| `LineItem`        | Represents a scanned product in the cart with quantity and prices       |
| `Cart`            | Holds all `LineItems`, keeps track of total cost                        |
| `Promotion`       | Connects a `Product` to a `Rule` class, determines active discounts      |
| `PromoRules::*`   | Implements business logic per promotion type                            |
| `ScanService`     | Scans products into the cart, creates or increments a `LineItem`        |
| `PromotionService`| Applies active promotions to each item and recalculates totals          |

---

### Promotion Rules

Promotion rules are implemented as separate model classes under `PromoRules::*`. Each rule follows a common interface:

```ruby
def apply(item)
  # Mutates the line item with calculated pricing
end
```

This pattern allows for easily adding new promotion types without changing existing services.

---

### Flow

1. A product is scanned by code → `ScanService.run!`
2. If it exists in the cart → increment quantity
3. `PromotionService.run!` is called to apply any eligible promotions
4. Turbo Streams update the cart UI with real-time pricing

---

## Setup

```bash
bundle install
bin/rails db:setup
bin/dev # or run Rails server and Tailwind manually
```

Manual:

```bash
bin/rails s
bin/rails tailwindcss:watch
```

---

## Running Tests

```bash
bundle exec rspec
```

Run a specific service:

```bash
bundle exec rspec spec/services/scan_service_spec.rb
```

---

## Best Practices Followed

- Clear separation of concerns using service objects
- Open/Closed design via rule delegation
- Minimal conditional logic inside services
- Real-time UI updates with Turbo + semantic `dom_id`s
- Test coverage for all major services and models
- Rule logic encapsulated in per-class apply methods
- Easily extensible structure for future promotions or pricing logic

---

## Extending Promotions

To add a new promotion:

1. Create a new rule class in `app/models/promo_rules/`
2. Implement `apply(item)` instance method
3. Add a migration and factory if needed
4. Create a `Promotion` linking the product to this rule
5. (Optional) Add tests under `spec/models/promo_rules/`

---