# Self-Assessment

## Automate

* The entire analysis is automated - **NOT YET** - _Need to move data reading and cleaning to new script that creates intermediate data files._

    * Data reading and cleaning is handled in a standalone script that creates intermediate output(s).
    * The analysis is performed in a Quarto document that reads intermediate outputs.
    * Files in the R/ folder exclusively define functions and have no other side effects.
    * All scripts run without errors.
* The analysis produces the expected output - **NOT YET** - _Figure data needs to have: year filter, color lines changed to different line types, y axes adjusted to the left side, x axis added on top, legend moved inside plot area, and hurricane year added as vertical line._
    * The Quarto document performs the data analysis (moving average).
    * The Quarto document creates a figure that is a reasonable approximation of the original.

## Organize

* Data are properly organized - **NOT YET** - _Need to create intermediate outputs, see Automate._
    * Raw data is contained in its own folder.
    * Outputs are contained in a separate folder from raw data.
* Code is properly organized - **NOT YET** - _Some safetly blanket code still remaining._
    * At least one function is defined in a script in R/ and used elsewhere in the workflow.
    * All code in the repo (except in the scratch/ folder) is required for the analysis (i.e., no “safety blanket” code remaining)

## Document

* The repo has an effective README - **MEETS SPEC** - _README.md currently meets specs._
    * A short, but descriptive title
        * A README’s title is set to the repository name by default - change this!
    * A brief explanation of the repository’s purpose
        * Paragraphs or a bulleted list are both acceptable options
        * You may include an image or logo that represents the project
    * A concise description of what’s housed in the repository
        * This includes information about the repository structure or file organization
    * Details regarding data access
        * Any necessary information on where data lives (e.g. is it housed in the repo, on a server, in a library/package etc.) and how to access it in order to run the code
    * A list of authors or current contributors (for collaborative work)
        * Consider hyperlinking collaborators’ GitHub profiles or other professional profile
    * References
        * In an appropriate, consistent format, including links.
        * Don’t forget to add references for datasets too.
* Code follows a professional style - **MEETS SPEC** - _Air formatter is in use, code is commented appropriately._
    * All code files follow a consistent style (the Air formatter automates this).
    * The code has an appropriate amount of comments.
        * Comments are minimized by using meaningful variable names and helper functions.
        * Comments are used to explain the why of code, not the what.