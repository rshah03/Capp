# Development
To start developing, make sure you have Cocoapods installed on your Mac. 
1. Run `sudo gem install cocoapods`
> If this gives you issues, go here: https://guides.cocoapods.org/using/troubleshooting#installing-cocoapods
2. CD into the working directory for this project
3. Run `pod install`
> The podfile I've created has everything you need for the project to work with the most recent master branch. Do not push changes to the Podfile without consulting the rest of us first. 

# Commits, Branching, etc.
- ALWAYS run `git pull` before starting any work! Failure to do so may cause marge conflicts and prevent the push. 
- I (Ronak) will check commits and branch pushes before merging with master. If something is wrong, I'll let you know.
- For the sake of consistency and to maintain a clear development approach, make sure you commit to the appropriate branch.
> I.e. Do not commit UI work to a branch other than UI. 
- Commit message format: '[Component name] - [Task Summary]'
> Add specifics of the commit details to the commit summary, not the title.
> Example: "Login - Added constraints"
- Don't create additional branches unless you absolutely need to. And let the others know if you do. Branches will not show up on the repo until you push a commit from that branch locally. 

