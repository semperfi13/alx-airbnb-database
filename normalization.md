# Airbnb Database Normalization

## Objective

Ensure that the database design follows best practices in normalization and achieves **Third Normal Form (3NF)**.

---

## ✅ Normalization Steps

### Step 1: First Normal Form (1NF)

All attributes contain atomic values (no lists or multi-valued fields).  
**Result:** ✅ All tables comply with 1NF.

---

### Step 2: Second Normal Form (2NF)

All non-key attributes depend on the full primary key.  
Since all tables use single-column primary keys, this rule is already satisfied.  
**Result:** ✅ Schema is in 2NF.

---

### Step 3: Third Normal Form (3NF)

All attributes must depend only on the primary key and not on other non-key attributes.

**Review Results:**

| Table     | Status | Notes |
|-----------|--------|-------|
| User      | ✅     | Fully normalized |
| Property  | ✅     | Optional: split `location` into `city`, `state`, etc. |
| Booking   | ✅     | Fully normalized |
| Payment   | ✅     | Fully normalized |
| Review    | ✅     | Consider unique constraint on (`user_id`, `property_id`) |
| Message   | ✅     | Fully normalized |

---

## 🟢 Optional Improvements

- Normalize `location` into a separate table or structured fields for advanced filtering.
- Add constraints to ensure 1 review per user per property.
- Consider soft-delete flags (e.g., `is_active`, `is_deleted`) instead of physical deletion.

---

## ✅ Conclusion

The Airbnb database design meets the requirements for **3NF** and is free from redundancy and transitive dependencies.
