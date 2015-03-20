## Priority for searching metric reports

- Always check for direct file name first
- If no file is found, check for git commit
- If commit exists, check for file name with full commit SHA
  - If no report exists, check out git commit, run report, save report name as full commit sha

## Argument parsing

- No arguments: Compare current HEAD to last commit
- One argument: Compare current HEAD to argument (using priority searching)
- Two arguments: Compare both arguments using priority searching

## Report comparisons

- Determine remaining tools to make comparisons on
- Make comparison reports more granular for specific tools