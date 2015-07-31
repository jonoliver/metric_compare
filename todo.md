## Report comparisons

- Determine remaining tools to make comparisons on
- Make comparison reports more granular for specific tools

## Repo

- If args < 2 and HEAD is master or branch, do not check out based on sha 
- Add tests for repo

## Rake tasks

- Add default rspec task

## Errors

- Gracefully handle and report errors

#### Priority for searching metric reports

- Always check for direct file name first
- If no file is found, check for git commit
- If commit exists, check for file name with full commit SHA
  - If no report exists, check out git commit, run report, save report name as full commit sha

## Comparisons still to make
- Saikuro
  - Method complexity
  - Class complexity
  - File complexity

## Partial comparisons finished (make more granular)
- Cane
  - Break out by violation (Abc complexity, style requirements, class comments, more?)(low priority)
- Flog
  - Complexity score Total, Avg score by file
- Flay
  - Score by file
- Reek
  - Total code smells by file
- Rails Best Practices
- Stats
  - Code to test ratio

## Skip (or low priority)
- Churn
- Roodi
  - Warnings by file
- Hotspots
  - Hotspots are determined based on the other tools. (Already a compilation)