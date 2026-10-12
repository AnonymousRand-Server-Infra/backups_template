# backups template

## first time setup guide

- write all the files that have a `.example` such that it is correct for your setup (e.g. write an `.env` file for every `.env.example`), and make sure all the "SYNC" comments in every file in the project are checked.
- in `./backups/`, init a new git repo which will be the backups of the backups; it should be ignored via `.gitignore` (but only if its git repo is added AFTER this outer git repo has already tracked `./backups/`, i think), and make sure that the thing producing the backups is pointed to `./backups/`.
- set up and enable systemd services as necessary (git auto commits, removing old backups).
- note that `.env` files must be accessible to scripts that source them!
