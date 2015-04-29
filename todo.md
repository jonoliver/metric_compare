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
