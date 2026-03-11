# AGENTS.md

## Purpose

This repository is a Bashly-based CLI. Prefer working from the source partials in `src/` and regenerate artifacts as needed.

## Source Of Truth

- Do not use the generated `./alf` executable as the primary code-reading target.
- Treat `./alf` as a generated artifact for verification only.
- Read and edit:
  - `src/bashly.yml`
  - `src/initialize.sh`
  - `src/*_command.sh`
  - `src/lib/*.sh`
  - `settings.yml`

## Generated Artifact Policy

- Only inspect `./alf` when you need to verify generated output, trace a generation issue, or confirm the final emitted behavior.
- Do not base architectural conclusions or refactoring plans on `./alf` when the equivalent source exists under `src/`.

## Test Strategy

The repository currently uses approval tests. Keep this distinction clear in future work:

- Approval tests should cover stable user-facing output:
  - help text
  - generated alias output
  - other intentional CLI snapshots
- Behavioral tests should move toward Bats:
  - config discovery
  - `which`
  - `generate`
  - `save`
  - `upload`
  - failure modes
  - local fixture repo scenarios

## Approval Testing Rules

- Never edit approval files manually.
- Never refresh approval files as a blind mechanical step.
- Approval updates should happen only through the approval workflow itself.
- Approval changes should be user-approved, because the approval step is the control point that distinguishes intended output changes from regressions.
- Do not "bake in" new snapshots unless the changed output has been intentionally reviewed and accepted.

## Migration Guidance

- Do not remove or loosen existing approval coverage until replacement behavioral coverage exists and the current approvals pass cleanly.
- Reduce approvals only after:
  - deterministic Bats coverage is in place
  - network-dependent tests are removed or isolated
  - the current approval suite is green

## Review Notes

- This project is being prepared for a `1.0.0` release and semver commitment.
- Prefer deterministic, local, hermetic tests over live network access.
- Treat installer and upgrade flows as release/integration verification, not unit coverage.
