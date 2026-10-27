# Architecture

1. A call arrives at the Genesys Cloud inbound flow.
2. Architect reads `Call.Ani` and normalizes it to an E.164 phone number.
3. The flow invokes a Genesys Cloud Web Services Data Action.
4. The action sends an authenticated GET request to Twilio Lookup v2.
5. Twilio returns metadata including `country_code`.
6. Architect maps `US` to English and `IN` to Hindi. Unknown country, failure, and timeout use English as the safe default.
7. Architect plays the greeting for the selected language and continues into the normal main menu/queue flow.

## Design notes

- No language menu is required; language is selected from the lookup result.
- Keep API credentials out of flow variables, source files, screenshots, and Git history.
- Handle Data Action failure and timeout explicitly so the caller can continue.
- Country code is a proxy for language, not a guarantee of caller preference. Consider CRM/customer language preference when production accuracy matters.
