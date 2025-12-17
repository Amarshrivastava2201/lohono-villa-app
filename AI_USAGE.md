
---

# 🤖 `AI_USAGE.md` (Frontend)

```md
# AI Usage Documentation – Flutter Frontend

## AI Tools Used
- ChatGPT (OpenAI)

---

## How AI Was Used

AI assistance was used to:
- Understand Flutter project structure
- Design clean separation between models, services, and UI
- Integrate REST APIs using the HTTP package
- Handle asynchronous data using FutureBuilder
- Debug runtime and integration issues during development

---

## What Was Accepted

- Folder and file structuring suggestions
- API service abstraction pattern
- Model creation for JSON parsing
- UI state handling (loading, error, empty)

---

## What Was Rejected

- Overly complex state management solutions (e.g., Bloc, Riverpod)
- Premature UI optimizations not required by the assignment
- Platform-specific customizations beyond scope

---

## What Was Modified and Why

- API base URL adjusted from `localhost` to `127.0.0.1` for Windows desktop compatibility
- Simplified UI widgets for clarity and readability
- Reduced abstraction layers to keep the app easy to understand and review

---

## Rationale

The focus was on correctness, clarity, and alignment with the assignment requirements rather than building a production-scale Flutter architecture.
