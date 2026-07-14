# Graph Report - homebrew-grat  (2026-07-14)

## Corpus Check
- Corpus is ~734 words - fits in a single context window. You may not need a graph.

## Summary
- 40 nodes · 42 edges · 6 communities (3 shown, 3 thin omitted)
- Extraction: 88% EXTRACTED · 12% INFERRED · 0% AMBIGUOUS · INFERRED: 5 edges (avg confidence: 0.95)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `0c76849f`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Grat Formula Packaging|Grat Formula Packaging]]
- [[_COMMUNITY_Formula Contract Tests|Formula Contract Tests]]
- [[_COMMUNITY_Tap Installation Guide|Tap Installation Guide]]
- [[_COMMUNITY_Bottle Publication Workflow|Bottle Publication Workflow]]
- [[_COMMUNITY_Test-Bot Validation|Test-Bot Validation]]
- [[_COMMUNITY_Grat Command Usage|Grat Command Usage]]

## God Nodes (most connected - your core abstractions)
1. `Grat` - 10 edges
2. `Bottle Artifacts` - 4 edges
3. `Bottle Declaration` - 3 edges
4. `Formula Binary Contract` - 3 edges
5. `pr-pull Job` - 3 edges
6. `Bottle Pull` - 3 edges
7. `macOS Test Job` - 3 edges
8. `Linux Test Job` - 3 edges
9. `Homebrew Formula Validation` - 3 edges
10. `Commit Push` - 2 edges

## Surprising Connections (you probably didn't know these)
- `Grat` --conceptually_related_to--> `Brewfile Installation`  [INFERRED]
  Formula/grat.rb → README.md
- `Grat` --conceptually_related_to--> `Homebrew Installation`  [INFERRED]
  Formula/grat.rb → README.md
- `Grat` --conceptually_related_to--> `Homebrew Formula Validation`  [INFERRED]
  Formula/grat.rb → .github/workflows/tests.yml
- `Bottle Declaration` --conceptually_related_to--> `Bottle Artifacts`  [INFERRED]
  Formula/grat.rb → .github/workflows/tests.yml
- `Grat` --references--> `Formula Test Stub`  [EXTRACTED]
  Formula/grat.rb → test/formula_binary_test.rb

## Import Cycles
- None detected.

## Communities (6 total, 3 thin omitted)

### Community 1 - "Grat Formula Packaging"
Cohesion: 0.22
Nodes (8): Grat, Bottle Declaration, Grat.install, Formula Version Test, Formula Test Stub, Formula Binary Contract, Homebrew Installation, Brewfile Installation

### Community 4 - "Bottle Publication Workflow"
Cohesion: 0.67
Nodes (4): brew pr-pull Workflow, pr-pull Job, Bottle Pull, Commit Push

### Community 3 - "Test-Bot Validation"
Cohesion: 0.60
Nodes (5): brew test-bot Workflow, macOS Test Job, Linux Test Job, Homebrew Formula Validation, Bottle Artifacts

## Knowledge Gaps
- **9 isolated node(s):** `Formula`, `Homebrew Tap for grat`, `Grat.install`, `Formula Version Test`, `Formula Test Stub` (+4 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Formula Binary Contract` connect `Grat Formula Packaging` to `Formula Contract Tests`?**
  _High betweenness centrality (0.437) - this node is a cross-community bridge._
- **Why does `Grat` connect `Grat Formula Packaging` to `Test-Bot Validation`?**
  _High betweenness centrality (0.368) - this node is a cross-community bridge._
- **Why does `Bottle Declaration` connect `Grat Formula Packaging` to `Test-Bot Validation`?**
  _High betweenness centrality (0.221) - this node is a cross-community bridge._
- **Are the 3 inferred relationships involving `Grat` (e.g. with `Brewfile Installation` and `Homebrew Installation`) actually correct?**
  _`Grat` has 3 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `Bottle Artifacts` (e.g. with `Bottle Declaration` and `Bottle Pull`) actually correct?**
  _`Bottle Artifacts` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Formula`, `Homebrew Tap for grat`, `Grat.install` to the rest of the system?**
  _9 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Formula Contract Tests` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._