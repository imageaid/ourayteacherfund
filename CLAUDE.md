# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A Rails 8 app for the Ouray Teacher Fund, an education non-profit. It combines a
public marketing website, a CMS, a grant-application workflow for teachers, and
an admin back-office for the board. See `README.md` for the product context (the
home/welcome page is intentionally hard-coded).

## Stack

- Ruby 3.4.2, Rails ~> 8.0.2, PostgreSQL
- Frontend: Hotwire (Turbo + Stimulus), importmap-rails (no bundler/npm build),
  Propshaft assets, Tailwind via `tailwindcss-rails`
- Auth: Sorcery. Rich text: ActionText. Files: ActiveStorage + AWS S3.
- Background jobs: GoodJob (Postgres-backed). Slugs: FriendlyId. Pagination: Pagy.
  Ordering: acts_as_list. Redis/Kredis available.

## Commands

```bash
bin/dev                       # Run the app (foreman/Procfile.dev: web :3000, tailwind watch, good_job worker)
bin/setup                     # Install deps, db:prepare, clear logs — idempotent
bin/rails db:prepare          # Create/migrate DB

bin/rails test                # Run unit/integration tests (parallelized)
bin/rails test test/models/grant_request_test.rb        # Single file
bin/rails test test/models/grant_request_test.rb:42     # Single test by line
bin/rails test:system         # System tests (Selenium + Chrome; needs Chrome installed)

bundle exec rubocop           # Lint (rubocop-rails-omakase style)
bundle exec annotate          # Refresh the schema comments at the top of model files
```

Models are annotated with their schema (via the `annotate` gem) as a comment
block at the top of each file — keep it accurate but treat `db/schema.rb` as the
source of truth.

## Architecture

### User model: STI + role enum (both matter)

`User` is a single-table-inheritance base (`users.type`) with subclasses
`Applicant`, `BoardMember`, and `Donor`. Independently, `User#role` is an enum
(`subscriber, applicant, donor, director, secretary, treasurer, vice_president,
president`). Authorization checks generally use `role`, not `type`:
`User#board_member?` is true for the five board roles; `User#applyable?` is true
for `subscriber`/`applicant`. When creating an applicant from a public form the
controller flips an existing user's `type` to `"Applicant"`.

Each subclass keeps flexible attributes in the shared `meta` jsonb column via
`store_accessor` (e.g. `Donor` address fields, `Applicant#applied_on`/`status`,
`BoardMember` term dates). Prefer adding to `meta` over new columns for
subclass-specific data.

### Two separate authentication flows

- **Admin** (`/admin/*`, controllers inherit `AdminController`): Sorcery
  password login via `Admin::SessionsController`. `AdminController#login_required`
  requires a logged-in board member and renders the `admin` layout.
- **Public applicants**: passwordless **magic links** (Sorcery `magic_login`
  submodule). `MagicLinksController` emails a token; `MagicSessionsController`
  logs the user in and routes them to their latest grant request.
  `ApplicationController#login_required` redirects unauthenticated users to the
  magic-link page.

The GoodJob dashboard is mounted at `/admin/good_job` and gated to board members
in `config/initializers/good_job.rb`.

### Grant application domain

- **Grant**: exactly one is active at a time — enforced by a UNIQUE index on
  `active`, so `Grant.find_by(active: true)` is the canonical "current grant".
  Its application questions live in the `questions` jsonb array.
- **GrantRequest**: an applicant's submission. Answers are stored in the
  `responses` jsonb (question text → response). The controller receives a
  `questions` form param and the `Admin::Questionable` concern
  (`format_grant_responses` / `format_grant_questions`) converts between the form
  shape and the jsonb columns.
- Public submission path: `pre_new` → `preflight` (blocks re-applying if a
  decision already exists) → `new`/`create`.
- **GrantReview**: a board member's review of a request. **GrantDecision**:
  the outcome; approved decisions surface as "awardees" on the welcome page.

### CMS & marketing site

`Page` has an ActionText `body` and a FriendlyId slug. Flags drive placement:
`navigation: true` adds it to the site nav (`ApplicationController#set_navigation_pages`,
loaded on every request), and the single `welcome_content: true` page provides
the welcome page's editable content (`WelcomeController` also shows recent donors
and awardees). Public pages render via `PagesController#show` using
`Page.friendly.find`.

### Messaging

`Message` (ActionText body, `message_type`/`status` enums) is scheduled through
`DeliverMessagesJob` with `set(wait_until: sends_at)`. The job fans a message out
to role groups (board/applicants/donors/subscribers) by mapping to `role` enum
integers.

### Conventions

- **Dynamic search scopes**: `User` and `GrantRequest` expose a `filter_by(params)`
  scope that dispatches to `with_<key>` scopes; admin controllers wrap this via the
  `Admin::UserSearchable` concern (`search_scope`).
- **`SchoolYears`** (`app/services/school_years.rb`) computes current/future/past
  school-year strings and rolls over in September (month < 9). Used to tag and
  scope applicants by school year.
- FriendlyId slugs are used for `User`, `GrantRequest`, and `Page`; look these up
  with `.friendly.find`.
