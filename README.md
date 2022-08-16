# CS-340

Coursework for final project of Oregon State University's CS340 Intro to Databases course in Summer 2022.

<b>Team Name:</b> Savage and Average<br>
<b>Team Members:</b> Mallory Huston and Sory Diagouraga
<br><b>Project Name:</b> <i>Clearwater Arena</i>

## Ground Rules:

### 1. Create a new branch for each new feature

From this point, each member of the group will create a new branch for any feature they are adding to the project. Do this by entering either of these two options:

<pre>
<code>git checkout -b branchName – This creates the branch and checks it out</code>
</pre>

<pre>
<code>git checkout branchName – This checks out the branch</code>
</pre>

Be sure to always check which branch you are on using “git status” before you begin working!

### 2. Merge your branch

Once your branch is ready to be merged to main, follow these steps:

* While in your branch you will 
<pre>
<code>git add .
git commit -m "message"
git push origin &lt;branch name&gt; – This creates the branch remotely and pushes to that branch on GitHub</code>
</pre>

* Go to GitHub and create a new pull request
  * You can compare your branch to any other branch, but you will most likely be comparing to main
  * You can assign a specific person or not
  * You will not be able to approve your own pull request

* Once someone reviews the pull request, they will resolve any issues or conflicts that come up and approve the pull request to be merged into the main

### 3. Start each day off right

Begin every day by pulling or fetching from the main to your local main.

* Pulling will automatically try to merge the recent commits from main and throw errors if there are any conflicts
* Fetching will gather the most recent commits in a branch which you can then view and decide to merge or not
* Once you have all the most recent updates on your main you can then merge those changes into your branch:
<pre>
<code>git checkout &lt;branch name you want to update&gt;
git merge &lt;branch name you're merging from&gt;</code>
</pre>

* You may have to handle merge conflicts at this point. Note that files with merge conflicts are usually a different color in the sidebar.
* Create a new branch
<pre>
<code>git checkout -b &lt;new branch name&gt;</code>
</pre>

* This branch will start off with a copy of the branch you were on
