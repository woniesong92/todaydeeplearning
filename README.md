# Today's Deep Learning

We want to recommend the best Arvix papers in (cs.[CV|CL|LG|AI|NE]/stat.ML) categories.
We will pull the papers everyday and the users will upvote the papers they recommend.
The papers will be ranked based on the number of votes they received during the day, week, and month.

### See it in action

![Screenshot1](http://i.imgur.com/ptnkSwu.jpg)
![Screenshot2](http://i.imgur.com/1iDKRux.jpg)


```
$ rake db:setup
$ rails server
```

You can also do

```
$ rake arvix_papers:populate_with_latest_papers
```

### Style guide

1. Rails (https://github.com/bbatsov/rails-style-guide)
2. BEM for CSS (http://getbem.com/introduction/)

### How to contribute

1. Pick an issue
2. Open a PR

### Deploy to Heroku

1. Create a heroku instance and setup DB

  ```
  $heroku create todaysdeeplearning
  $heroku run rake db:migrate
  $heroku restart
  ```

2. `$git push heroku master`
3. Install ImageMagick on Heroku

  ```
  $heroku buildpacks:add --index 1 https://github.com/ello/heroku-buildpack-imagemagick
  ```
4. Open the website in heroku

  ```
  $heroku open
  ```

### Heavily inspired by

1. http://www.arxiv-sanity.com/
2. https://www.lobal.io/

### TensorflowKR

This is a project initially started from the TensorFlowKR group (https://www.facebook.com/groups/TensorFlowKR)
