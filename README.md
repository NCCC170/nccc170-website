# NCCC-170 Website

A [website for NCCC-170](https://nccc170.netlify.app/), 
the North Central Coordinating Committee. 

The code for the website is located in a 
[github repository](https://github.com/NCCC-170/nccc170-website).
If you are looking to add content, 
please take a look at the 
[content/](https://github.com/NCCC-170/nccc170-website/content/) folder.

If you would like to add/update content and are familiar with git/github, 
please use a [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests).
If you are uncomfortable making a pull request, 
then feel free to email [Jarad Niemi](mailto:niemi@iastate.edu). 

If you are interested in co-administering the website,
e.g. updating your own content without having to go through me,
I can add you as a collaborator on the 
[github repository](https://github.com/NCCC-170/nccc170-website). 


## To do

Here are some thoughts about what we should/could do with the NCCC170 website.

### Background

As of summer 2022, there were two main websites for NCCC170:

- [official NIMSS](https://www.nimss.org/projects/view/mrp/outline/18798)
- [Arkansas site](https://nccc170.uark.edu/)

A new site has been created to replace the Arkansas site. 
The new site is hosted by netlify and code is on 
[github](https://github.com/NCCC-170/nccc170-website).

- [netlify site](https://nccc170.netlify.app/)


### What has been done

- Old website
    - <https://nccc170.uark.edu/>
    - Archived at <https://github.com/NCCC-170/uark-archive>
- New website
    - Created [NCCC-170 Github organization](https://github.com/NCCC-170)
    - New domain <https://nccc170.netlify.app/>
    - Use [Hugo backend](https://gohugo.io/) with [wowchemy/hugo-starter-research-group](https://research-group.netlify.app/) theme deployed by [Netlify](https://www.netlify.com/)
    - Content is written in [Markdown](https://www.markdownguide.org/tools/hugo/) with [YAML frontmatter](https://gohugo.io/content-management/front-matter/)
    - Added (some) people
    - Added (some) meetings
    - Added proposals
    - Provided example publications
    
    
### What needs to be done    
   
#### By administrator
   
- Domain
    - Redirect <https://nccc170.uark.edu/> to new website (SEO)
    - Update [NIMSS website link](https://www.nimss.org/projects/view/links/18798)
- Website
    - Link meeting talks to individuals
    - Add "Alum" section on [People page](https://nccc170.netlify.app/people/)
    - Remove/update [Tour page](https://nccc170.netlify.app/tour/)
    - New favicon
    - Add pictures
    
#### By you
  
All content for the website is located in the [content/](https://github.com/NCCC-170/nccc170-website/content/) folder.
To add content to the website, please use a pull request. 
  
- People
    - Add/update your information (see People section)
    - Also link your profile to publications/events
- Publications
    - Add publications, but how?
    - Record publications in Excel/csv file
        - Write script to convert to Excel/csv data to website content
- Pictures
    - Upload to OneDrive link sent by Nora

Also

- Add links from your personal websites (SEO)


### Questions


- Is it NCCC-170 or NCCC170? 
- Purchase a domain?, e.g. <http://nccc170.org/> is available
- Other content?
    - [CRAN Task View: Agricultural Science](https://cran.r-project.org/web/views/Agriculture.html)
    - Projects:
        - Mixed models in R
    - Sharing resources:
        - Blog?





## Add/update content

Below there is information about how to add or update content including 
people, publications, meetings, and proposals. 
Ideally, NCCC170 members would use a 
[pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests)
through the 
[Github repository for this website](https://github.com/NCCC-170/nccc170-website).
If you are uncomfortable making a pull request, 
then feel free to email [Jarad Niemi](mailto:niemi@iastate.edu). 



### People

Individuals associated with NCCC-170 can have a profile on this website. 
These profiles live in the 
[authors/](https://github.com/NCCC-170/nccc170-website/content/authors) folder. 

#### Add a new person

To add a new person, copy a folder in the 
[authors/](https://github.com/NCCC-170/nccc170-website/content/authors) folder.
Edit the folder name to the new person's last name and modify the content 
within the folder. 
The `_index.md` file provides the profile while the `avatar.jpg` is used for 
including a picture of the individual.

#### Update an existing person

To add update an existing person, find the appropriate folder within the
[authors/](https://github.com/NCCC-170/nccc170-website/content/authors) folder.
Edit the `_index.md` or other files accordingly. 

### Add a publication

To add a paper, copy a folder in the 
[publication/](https://github.com/NCCC-170/nccc170-website/content/publication) folder.
Name the folder using the title of the manuscript but using only letters, numbers, 
and underscores. 
Edit files within this folder as necessary. 

[Publication types](https://wowchemy.com/docs/content/publications/)


### Add annual meeting

Annual meetings are added by the website administrator, 
currently Jarad Niemi. 

To add the annual meeting, copy a folder in the 
[event/](https://github.com/NCCC-170/nccc170-website/content/publication) folder.
Currently this group only has one meeting per year. 
Name the folder using the year. 
Edit files within this folder as necessary. 


### Add proposals

Proposals are added by the website administrator, 
currently Jarad Niemi. 

To add the annual meeting, copy a folder in the 
[proposals/](https://github.com/NCCC-170/nccc170-website/content/publication) folder.
Name the folder `using the year. `project<YYYY>`.
Edit files within this folder as necessary. 




