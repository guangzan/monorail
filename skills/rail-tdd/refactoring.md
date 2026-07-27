# Refactor candidates

After green, look for:

- **Duplication** → extract function/class
- **Long methods** → break into private helpers (keep tests on the public seam)
- **Shallow modules** → combine or deepen
- **Feature envy** → move logic to where the data lives
- **Primitive obsession** → introduce a small domain type
- **Existing code** the new change reveals as problematic
