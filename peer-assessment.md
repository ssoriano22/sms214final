# Peer Assessment - Priscilla Pierce

## Automate

* The entire analysis is automated - **Not yet:** *Data reading and cleaning is currently in paper.qmd. Creating a standalone script that creates intermediate outputs would help with organization. All other subparts of this spec are met.*

    * Data reading and cleaning is handled in a standalone script that creates intermediate output(s).
    * The analysis is performed in a Quarto document that reads intermediate outputs.
    * Files in the R/ folder exclusively define functions and have no other side effects.
    * All scripts run without errors.
* The analysis produces the expected output - **Not yet, with personal comment:** *I commented out library(ggh4x) in paper.qmd because I do not have that package, so that may be impacting how the Quarto document code runs for me. I encountered an error message where the file, '../R/moving-average.R' was not able to be opened. The text and code of paper.qmd is well organized.*
    * The Quarto document performs the data analysis (moving average).
    * The Quarto document creates a figure that is a reasonable approximation of the original.

## Organize

* Data are properly organized - **Not yet:** *Output folder has not been created yet, however I see in your self assessment that you are planning to create one.*
    * Raw data is contained in its own folder.
    * Outputs are contained in a separate folder from raw data.
* Code is properly organized - **Not yet:** *I see in your self assessment that you are planning to create an output folder. After that is completed and the paper.qmd is updated, this spec will be met.*
    * At least one function is defined in a script in R/ and used elsewhere in the workflow.
    * All code in the repo (except in the scratch/ folder) is required for the analysis (i.e., no “safety blanket” code remaining)

## Document

* The repo has an effective README - **Meets spec, small additional comment:** *Location of cleaned data is not immediately clear when viewing repository or README. README is very concise and has a pleasing format. I especially like the Repository Layout section.*
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
* Code follows a professional style - **Meets spec:** *Looks great, very neat.*
    * All code files follow a consistent style (the Air formatter automates this).
    * The code has an appropriate amount of comments.
        * Comments are minimized by using meaningful variable names and helper functions.
        * Comments are used to explain the why of code, not the what.