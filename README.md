# Manav Fitness Center — Automatic Caller Language Selection

A Genesys Cloud CX Architect inbound-call example that uses the caller's phone number and the Twilio Lookup API to select a default language automatically, without playing a language-selection prompt.

**Language mapping for this version**
- `US` → English (`en-us`)
- `IN` → Hindi (`hi-in`)
- Lookup failure, timeout, or another country → English fallback

> This repository documents the configuration and tests shown in the supplied screenshots. It does not contain a deployable Genesys export or live credentials. Verify locale identifiers against the languages enabled in your Genesys organization.

## Call flow

## Call flow

![Manav Fitness Center - AI Call Flow](docs/screenshots/manav-fitness-auto-language-flow.png)

## Repository contents

- `docs/screenshots/` — screenshots supplied during the configuration walkthrough, renamed and ordered.
- `docs/CONFIGURATION.md` — setup notes and mapping checklist.
- `docs/ARCHITECTURE.md` — integration sequence and design considerations.
- `examples/twilio-response-us.json` — redacted illustrative API response.
- `examples/data-action-contract.json` — minimal response contract example.
- `examples/curl-example.sh` — safe template for testing with environment variables.

## Quick setup

1. In Twilio Console, find the Account SID and Auth Token. Store them as environment variables; never commit them.
2. Configure a Genesys Cloud **Web Services Data Actions** integration and a GET action for Twilio Lookup v2.
3. Pass the caller's normalized ANI as `customer_number`.
4. Map the returned `country_code` to a Task string variable in Architect.
5. In the language-selection task, route `US` to `en-us`, `IN` to `hi-in`, and default/failure/timeout to English.
6. Play the appropriate greeting and continue to the existing main menu. Do not add a language-selection prompt.
7. Test with valid numbers you are authorized to use, validate the flow, then publish.

See [configuration details](docs/CONFIGURATION.md) and [architecture notes](docs/ARCHITECTURE.md).

## Security

Never commit Twilio Auth Tokens, Account SIDs paired with secrets, real customer phone numbers, call recordings, or customer data. Use GitHub Secrets for CI environments and rotate any credential accidentally exposed. The screenshots are included as supplied; review them for sensitive information before making the repository public.

## Limitations

Twilio Lookup's `country_code` identifies the country associated with a phone number, not the caller's physical location or language preference. A US number calling from India will still match `US`. For real deployments, consider a customer preference/CRM lookup when available.
