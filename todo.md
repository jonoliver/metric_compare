## Priority for searching metric reports

- Always check for direct file name first
- If no file is found, check for git commit
- If commit exists, check for file name with full commit SHA
  - If no report exists, check out git commit, run report, save report name as full commit sha

## Repo
 - Move git stuff into git module

## Report comparisons

- Determine remaining tools to make comparisons on
- Make comparison reports more granular for specific tools

## Rake tasks
- Add default rspec task

## Tests

- Add tests for repo

## Errors

- Gracefully handle and report errors