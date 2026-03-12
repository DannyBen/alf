# AGENTS.md

## Purpose

This repository is a Bashly-based CLI. Prefer working from the source partials in `src/` and regenerate artifacts as needed.

## Source Of Truth

- Do not use the generated `./alf` executable as the primary code-reading target.
- Treat `./alf` as a generated artifact for verification only.
- Read and edit:
  - `src/bashly.yml`
  - `src/initialize.sh`
  - `src/commands/*.sh`
  - `src/lib/*.sh`
  - `settings.yml`

## Helper Commands

- `op.conf` is the repo-local source of truth for common helper commands such as
  testing, ShellCheck, formatting, generation, and docs tasks.
- Prefer the `op.conf` entries when looking up or running standard project
  workflows.

## Generated Artifact Policy

- Only inspect `./alf` when you need to verify generated output, trace a generation issue, or confirm the final emitted behavior.
- Do not base architectural conclusions or refactoring plans on `./alf` when the equivalent source exists under `src/`.

## Test Strategy

The repository uses Bats as the primary test framework.

For Bats tests, prefer this split:

- Use checked-in fixtures when the unit's job is to interpret files, parse config, or derive behavior from prepared filesystem state.
- Use stubs when the unit's job is orchestration.
- In stub-driven unit tests, it is acceptable to create the smallest transient prerequisite inline when it is only a mechanical precondition (for example, an empty file required to satisfy an existence check).
- Keep command adapter tests tiny and structural.
- Keep integration tests sparse and focused on top-level CLI wiring, not behavior that is already covered at the unit level.

## Review Notes

- This project is being prepared for a `1.0.0` release and semver commitment.
- Prefer deterministic, local, hermetic tests over live network access.
- Treat installer flows as release/integration verification, not unit coverage.
