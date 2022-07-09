# CS-340

Coursework for final project of Oregon State University's CS340 Intro to Databases course in Summer 2022.

<b>Team Name:</b> Savage and Average<br>
<b>Team Members:</b> Mallory Huston and Sory Diagouraga

## Ground Rules:

### Create a new branch for each new feature

From this point, each member of the group will create a new branch for any feature they are adding to the project. Do this by entering either of these two options:

<pre>
<code>git checkout -b branchName – This creates the branch and checks it out</code>
</pre>

<pre>
<code>git checkout branchName – This checks out the branch</code>
</pre>

Be sure to always check which branch you are on using “git status” before you begin working!

### Merge your branch

Once your branch is ready to be merged to master, follow these steps:

* While in your branch you will 
<pre>
<code>git add .
git commit -m "message"
git push origin <branch name> – This creates the branch remotely and pushes to that branch on GitHub</code>
</pre>

* Go to GitHub and create a new pull request
  * You can compare your branch to any other branch, but you will most likely be comparing to master
  * You can assign a specific person or not
  * You will not be able to approve your own pull request

* Once someone reviews the pull request, they will resolve any issues or conflicts that come up and approve the pull request to be merged into the master

### Start each day off right

Begin every day by pulling or fetching from the master to your local master.

* Pulling will automatically try to merge the recent commits from master and throw errors if there are any conflicts
* Fetching will gather the most recent commits in a branch which you can then view and decide to merge or not
* Once you have all the most recent updates on your master you can then merge those changes into your branch:
<pre>
<code>git checkout <branch you want to update>
git merge <branch name you're merging from></code>
</pre>

* You may have to handle merge conflicts at this point. Note that files with merge conflicts are usually a different color in the sidebar.
* Create a new branch
<pre>
<code>git checkout -b <div>&lt;new branch name&gt;</div></code>
</pre>

* This branch will start off with a copy of the branch you were on
