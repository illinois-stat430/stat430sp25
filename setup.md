
# # STAT 430 setup and workflow

## Welcome

Welcome to STAT 430, let's have a productive semester!

This document will go through GitHub, computational resources, software, and overall course organization. This will be a valuable resource for you as you become familiar with this course's GitHub based organization in which every student will submit assignments by pushing to an individual GitHub repository that resides within my course's GitHub organization.

You should have downloaded this document from the course website https://github.com/illinois-stat430/stat430sp25 or some other source. 


### Version Control 

In this course, we will use Git and GitHub Enterprise. Git is one of several version control softwares. It allows users to save a document with time stamps and comments on what was changed in that document systematically. GitHub is a a cloud-based service that implements a Git repository hosting system. GitHub Enterprise is a Github service that we have thanks to our good friends in the Computer Science Department. We will discuss these topics in much detail throughout this document.


### Work Flow

You will use Markdown and GitHub to submit labs, homework assignments, projects, etc. You will obtain your homework assignment from my GitHub course page (my **stat430sp25** repository) and will submit them to your individual GitHub repository. Eventually this will all make sense and you will be comfortable with it!


![](https://miro.medium.com/v2/resize:fit:600/0*VcMPr1unIjAIHw2j.jpg)



## Software needed for this class

We will be working with [R](https://cran.r-project.org) and [RStudio](https://rstudio.com). 

R is a statistical programming language. It is free and open-source and is being developed by users to handle tasks beyond statistics and data science. We code in R, usually in a **script** and saved as an .R file or .Rmd file. The output of the code we run is visible in the **console**.

RStudio is an interface for R that is relatively user-friendly, visually sufficient, and well-organized for content management. In RStudio, we will do almost everything we need for this course - write R Markdown files (.Rmd), knit the .Rmd to .html, and repeatedly interact with GitHub repositories.


### Create your individual GitHub repositories

Repositories (**repos** for short) are essentially project folders where you intend to store a set of files in the same location, much like a folder. These repositories are constantly being updated and are in need of version of control. This is where GitHub and other Git platforms come in. GitHub allows you to make your edits to a project locally and save them remotely while keeping all previous versions to your project intact. You do not need to constantly change file names to indicate new versions, just push your edits to GitHub. GitHub will store the previous versions and a detailed record of the changes made. GitHub and other version control platforms are fundamentally important for collaboration.

We will now start the setup of your individual student **GitHub repositories**. Each student should click on this link https://edu.cs.illinois.edu/create-gh-repo/sp25_stat430 in order to create your student repo. Your personal repo is where you will keep your assignment files. The idea is that:  
- you will work on your assignments from your repo, updating it often to ensure you're working on the correct file(s)  
- you will obtain course resources, including homework assignments, from my **stat430sp25** course repo.  

GitHub will be a reoccurring topic throughout this course.


### Git and GitHub setup

See [Chapter 11](https://happygitwithr.com/push-pull-github) in Happy Git and GitHub for the useR for  details on the push-pull GitHub workflow that we will use to distribute resources in this class. Chapter 11 references to Appendix A for shell commands that may help you in your quest to clone my  **stat430sp25** repo in the desired place. 

1. **Setup your individual repo and join my illinois-stat430 GitHub organization.**

2. **Clone your personal course repo onto your computer.** Your personal repo will be created automatically by the CS repo creator tool affiliated with my course's Illinois-stat430 GitHub organization. Cloning the repo connects your GitHub repo to your local computer as a directory (with the same name as the repo). Make sure that you know which directory that you clone your repo in! I highly recommend creating a **stat430** directory on your Desktop and then cloning your repo in this directory. 

You can clone your repo this by first changing *YourNetID.git* to your actual netid .git in the following and then coping the command into the terminal/shell (make sure the working directory is in the place you desire)

```
git clone git@github.com:illinois-stat430/sp25_stat430_YourNetID.git
```

When you type the above you may get something like the following error message:

```
ERROR: The `illinois-stat430' organization has enabled or enforced SAML SSO. To access
this repository, you must use the HTTPS remote with a personal access token
or SSH with an SSH key and passphrase
that has been authorized for this organization. Visit
https://docs.github.com/articles/authenticating-to-a-github-organization-with-saml-single-sign-on/ for more information.

fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

If you do get this error message and have a MAC, you may need to generate an [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), [add your SSH key to your GitHub account](https://docs.github.com/en/enterprise-server@3.0/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account), and then [configure SSO](https://docs.github.com/en/enterprise-cloud@latest/authentication/authenticating-with-saml-single-sign-on/authorizing-an-ssh-key-for-use-with-saml-single-sign-on) for this course's GitHub organization (it may say Configure SSO instead of Enable SSO in your SSH and GPG keys GitHub page). Windows users may find the linked resources provided in the previous sentence useful as well. If not, then either [this link](https://www.howtogeek.com/762863/how-to-generate-ssh-keys-in-windows-10-and-windows-11/) or [this link](https://dev.to/oxayomide_54/how-to-set-up-ssh-key-authentication-with-github-on-windows-j23) or both may help.




3. **Clone the **stat430sp25** repo onto your computer.** Cloning the repo connects my GitHub repo to your local computer as a directory (with the same name as the repo). Make sure that you know which directory that you clone your repo in! I highly recommend creating a **stat430** directory on your Desktop and then cloning your repo in this directory. 

You can also clone my repo by directly typing the following into your terminal:

```
git clone git@github.com:illinois-stat430/stat430sp25.git
```

When you type the above you may get something like the following error message:

```
ERROR: The `illinois-stat430' organization has enabled or enforced SAML SSO. To access
this repository, you must use the HTTPS remote with a personal access token
or SSH with an SSH key and passphrase
that has been authorized for this organization. Visit
https://docs.github.com/articles/authenticating-to-a-github-organization-with-saml-single-sign-on/ for more information.

fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

If you do get this error message, you may need to generate an [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), [add your SSH key to your GitHub account](https://docs.github.com/en/enterprise-server@3.0/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account), and then [configure SSO](https://docs.github.com/en/enterprise-cloud@latest/authentication/authenticating-with-saml-single-sign-on/authorizing-an-ssh-key-for-use-with-saml-single-sign-on) for this course's GitHub organization (it may say Configure SSO instead of Enable SSO in your SSH and GPG keys GitHub page).


**Do not edit any files in your local versions of my stat430sp25 repo**. The **stat430sp25** repo is an internal repo that you can only pull materials from, you do not have writing permissions in this repo. Editing files in the **stat430sp25** repo  will create a [conflict](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/about-merge-conflicts). You should copy files from my **stat430sp25** repo to your desired destination.



### R and RStudio tasks to do

If you completed the above tasks and followed my recommendation of cloning your repos within a **stat430** directory that is on your Desktop, then proceed with the following R and RStudio tasks:

1. Install and update R to the latest version.

2. Install and update RStudio to the latest version.

3. Open R Studio and create a new R Project to be stored in the directory that contains both of your repos (*possibly your *stat430** directory on your desktop).



### Download (pull) and upload (push) your homework to GitHub

See [Chapter 11](https://happygitwithr.com/push-pull-github) in Happy Git and GitHub for the useR for  details on the push-pull GitHub workflow that we will use to distribute resources in this class. Chapter 11 references to Appendix A for shell commands that may help you in your quest to obtain and submit your homework assignments. 

Before we begin, a warning: **Do not edit the files in your local version of my stat430sp25 repository.**

Here are the steps of the workflow that we will use to obtain and submit homework assignments:

1. **pull from my **stat430sp25** repository. To do this you will first open a terminal or shell and navigate to the local version of my **stat430sp25** repository that exists on your computer. If you followed my recommendations then this directory has the following path on a Mac:

```
~/Desktop/stat430/stat430sp25
```

The ~/ is a placeholder for /Users/danieleck/ on my machine. On my machine the root directory is danieleck and Desktop is in my root directory.

Once your terminal or shell is in the **stat430sp25** repository, then make a pull from GitHub by typing:

```
git pull
```

This will download all files that are currently in my remote **stat430sp25** GitHub repository to your computer.


2. **copy files from stat430sp25 to another place**. If you edit files in **stat430sp25** then you may create a [merge conflict](https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts) in the future which will prevent you from obtaining course resources. It is therefore much better to copy files from **stat430sp25** to another place on your computer. I recommend copying course materials to either your repo or your **stat430** directory. You can copy by point-and-drag or by using terminal commands. [Terminal commands are recommended](https://trstringer.com/using-the-terminal/).  

3. **push files to your virtual repos**. We will now discuss what to do when you have edited a file on your computer and are ready to upload (push) it to Github. First, you will need to get your terminal or shell in the local directory containing your personal repository. If you followed my recommendations then this directory has the following path on a Mac:

```
~/Desktop/stat430/sp25_stat430_YourNetID
```

The ~/ is a placeholder for /Users/danieleck/ on my machine. On my machine the root directory is danieleck and Desktop is in my root directory.

Once your terminal or shell is in the directory containing your local repository, then you can upload (push) files to Github by typing the following three GitHub commands as follows:


```
git add -A
git commit -m "An understandable message that describes what was changed"
git push 
```

The -A flag in the first line of the above code adds all changed values to your commit. You can add individual files if you choose to do so. The latter method can be preferable in many cases. For example, you can just push changes to a README.md file by typing

```
git add README.md
git commit -m "Added new sentence from local computer"
git push 
```

Go online to view your changes once your push appears to go through.


### Reproducible Documentation

The homework assignments that you submit will be, unless otherwise notified, pdf or html files that are outputs from knitting an R Markdown document (.Rmd file extension).

By reproducible documentation, I mean that we will use good principles and software (R and RStudio) that allow anyone (with similar software) to be able to look at our input (.Rmd) and the code therein and re-create the same output (.html or .pdf) and come to the same conclusion that we did. To do this, we need to keep good notes in our code documents and version control can aid us.  We will need to set R's random seed for every document that uses random number generation, so that the results are reproducible.

Creating reproducible experiments is necessary for all scientific progress. Results that cannot be verified by a third-party should be viewed with skepticism. Data analyses and numerical simulations are no exception.

Computer based assignments will be written in R Markdown. In case you were wondering, this is an R Markdown document. Hyperlinks like the one in this sentence can be [embedded in the text](http://rmarkdown.rstudio.com) using Markdown. Read the corresponding .Rmd file to see how this is done. [This reference contains a lot of useful information on Markdown syntax that will help you in this class](https://www.markdownguide.org/basic-syntax/).


