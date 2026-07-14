# Graph Report - .  (2026-07-14)

## Corpus Check
- 1 files · ~734 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 40 nodes · 45 edges · 5 communities (4 shown, 1 thin omitted)
- Extraction: 89% EXTRACTED · 11% INFERRED · 0% AMBIGUOUS · INFERRED: 5 edges (avg confidence: 0.95)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Formula Contract Tests|Formula Contract Tests]]
- [[_COMMUNITY_Grat Formula Packaging|Grat Formula Packaging]]
- [[_COMMUNITY_Tap Installation Guide|Tap Installation Guide]]
- [[_COMMUNITY_Test-Bot Validation|Test-Bot Validation]]
- [[_COMMUNITY_Bottle Publication Workflow|Bottle Publication Workflow]]

## God Nodes (most connected - your core abstractions)
1. `Grat` - 10 edges
2. `Homebrew Tap for grat` - 4 edges
3. `Bottle Artifacts` - 4 edges
4. `Bottle Declaration` - 3 edges
5. `Formula Binary Contract` - 3 edges
6. `pr-pull Job` - 3 edges
7. `Bottle Pull` - 3 edges
8. `macOS Test Job` - 3 edges
9. `Linux Test Job` - 3 edges
10. `Homebrew Formula Validation` - 3 edges

## Surprising Connections (you probably didn't know these)
- `Brewfile Installation` --conceptually_related_to--> `Grat`  [INFERRED]
  README.md → Formula/grat.rb
- `Homebrew Installation` --conceptually_related_to--> `Grat`  [INFERRED]
  README.md → Formula/grat.rb
- `Homebrew Formula Validation` --conceptually_related_to--> `Grat`  [INFERRED]
  .github/workflows/tests.yml → Formula/grat.rb
- `Bottle Artifacts` --conceptually_related_to--> `Bottle Declaration`  [INFERRED]
  .github/workflows/tests.yml → Formula/grat.rb
- `Formula Test Stub` --references--> `Grat`  [EXTRACTED]
  test/formula_binary_test.rb → Formula/grat.rb

## Import Cycles
- None detected.

## Communities (5 total, 1 thin omitted)

### Community 1 - "Grat Formula Packaging"
Cohesion: 0.29
Nodes (6): Bottle Declaration, Formula Version Test, Grat, Grat.install, Formula Binary Contract, Formula Test Stub

### Community 2 - "Tap Installation Guide"
Cohesion: 0.40
Nodes (4): Brewfile Installation, grat, Homebrew Installation, Homebrew Tap for grat

### Community 3 - "Test-Bot Validation"
Cohesion: 0.60
Nodes (5): Bottle Artifacts, Homebrew Formula Validation, Linux Test Job, macOS Test Job, brew test-bot Workflow

### Community 4 - "Bottle Publication Workflow"
Cohesion: 0.67
Nodes (4): Bottle Pull, Commit Push, pr-pull Job, brew pr-pull Workflow

## Knowledge Gaps
- **6 isolated node(s):** `Formula`, `Grat.install`, `Formula Version Test`, `Formula Test Stub`, `brew pr-pull Workflow` (+1 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Formula Binary Contract` connect `Grat Formula Packaging` to `Formula Contract Tests`?**
  _High betweenness centrality (0.510) - this node is a cross-community bridge._
- **Why does `Grat` connect `Grat Formula Packaging` to `Tap Installation Guide`, `Test-Bot Validation`?**
  _High betweenness centrality (0.505) - this node is a cross-community bridge._
- **Why does `Bottle Declaration` connect `Grat Formula Packaging` to `Test-Bot Validation`?**
  _High betweenness centrality (0.241) - this node is a cross-community bridge._
- **Are the 3 inferred relationships involving `Grat` (e.g. with `Brewfile Installation` and `Homebrew Installation`) actually correct?**
  _`Grat` has 3 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `Bottle Artifacts` (e.g. with `Bottle Pull` and `Bottle Declaration`) actually correct?**
  _`Bottle Artifacts` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Formula`, `Grat.install`, `Formula Version Test` to the rest of the system?**
  _6 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Formula Contract Tests` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._