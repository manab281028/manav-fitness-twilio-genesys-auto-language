# Configuration checklist

## 1. Twilio Lookup API

- Method: `GET`
- Endpoint template: `https://lookups.twilio.com/v2/PhoneNumbers/${input.customer_number}`
- Authentication: HTTP Basic using Twilio Account SID as username and Auth Token as password, configured securely in the integration/action.
- Required response field: `country_code` (string).
- Optional response field: `valid` (boolean).

Example request path for a number already normalized to E.164: `/v2/PhoneNumbers/+14155552671`. Use a test number you are authorized to query; sample numbers in docs may not be active.

## 2. Architect caller number

Create/update a flow string variable such as `Flow.customer_number` from `Call.Ani`. If your ANI includes a `tel:` prefix, remove that prefix before sending it. Ensure the resulting number is E.164, including `+` and country calling code.

## 3. Call Data Action mapping

- Input `customer_number` → `Flow.customer_number`
- Success output `country_code` → a Task string variable (example: `Task.country_code`)
- Verify that the action's published output contract contains `country_code`.

## 4. Language mapping

| Twilio `country_code` | Architect action |
|---|---|
| `US` | Set Language to English (`en-us`) |
| `IN` | Set Language to Hindi (`hi-in`) |
| Default | Set Language to English (`en-us`) |
| Data Action failure | Set Language to English (`en-us`) |
| Data Action timeout | Set Language to English (`en-us`) |

Confirm that Hindi (India) is enabled and supported for the flow's intended prompt/speech features in your Genesys org. Language codes and speech capabilities can differ by feature and organization configuration.

## 5. Validation

- [ ] Data Action test returns `country_code` for an authorized US test number.
- [ ] Data Action test returns `country_code` for an authorized Indian test number.
- [ ] US calls set English automatically.
- [ ] Indian calls set Hindi automatically.
- [ ] Other country, invalid number, failure, and timeout follow English fallback.
- [ ] No language-selection menu/prompt is played.
- [ ] Correct greeting plays after language selection.
- [ ] Existing main menu and queue routing still work.
- [ ] Validate and publish the action and inbound flow.
