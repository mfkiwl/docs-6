#!/bin/bash
set -x
################################################################################
# File:    buildDocs.sh
# Purpose: Script that builds our documentation using sphinx and updates GitHub
#          Pages. This script is executed by:
#            .github/workflows/docs_pages_workflow.yml
#
# Authors: Michael Altfield <michael@michaelaltfield.net>
# Created: 2020-07-17
# Updated: 2023-03-26
# Version: 0.3
################################################################################
 
###################
# INSTALL DEPENDS #
###################
 
apt-get update
apt-get -y install git rsync python3-sphinx python3-sphinx-rtd-theme python3-stemmer python3-git python3-pip python3-virtualenv python3-setuptools
 
python3 -m pip install --upgrade rinohtype pygments 
python3 -m pip install docutils==0.16 
#####################
# DECLARE VARIABLES #
#####################

# prevent git "detected dubious ownership" errors
git config --global --add safe.directory "*"

pwd
ls -lah
export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
 
# make a new temp dir which will be our GitHub Pages docroot
docroot=`mktemp -d`

export REPO_NAME="${GITHUB_REPOSITORY##*/}"
 
##############
# BUILD DOCS #
##############
 
# first, cleanup any old builds' static assets
make -C docs clean
 
# get a list of branches, excluding 'HEAD' and 'gh-pages'
versions="`git for-each-ref '--format=%(refname:lstrip=-1)' refs/remotes/origin/ | grep -viE '^(HEAD|gh-pages)$'`"
for current_version in ${versions}; do
 
   # make the current language available to conf.py
   export current_version
   git checkout ${current_version}
 
   echo "INFO: Building sites for ${current_version}"
 
   # skip this branch if it doesn't have our docs dir & sphinx config
   if [ ! -e 'docs/conf.py' ]; then
      echo -e "\tINFO: Couldn't find 'docs/conf.py' (skipped)"
      continue
   fi
 
   languages="en"
   # languages="en `find docs/locales/ -mindepth 1 -maxdepth 1 -type d -exec basename '{}' \;`"
   for current_language in ${languages}; do
 
      # make the current language available to conf.py
      export current_language
 
      ##########
      # BUILDS #
      ##########
      echo "INFO: Building for ${current_language}"
 
      # HTML #
      sphinx-build -b html docs/ docs/_build/html/${current_language}/${current_version} -D language="${current_language}"
 
      # PDF #
      sphinx-build -b rinoh docs/ docs/_build/rinoh -D language="${current_language}"
      mkdir -p "${docroot}/${current_language}/${current_version}"
      cp "docs/_build/rinoh/target.pdf" "${docroot}/${current_language}/${current_version}/${REPO_NAME}_${current_language}_${current_version}.pdf"
 
      # EPUB #
      sphinx-build -b epub docs/ docs/_build/epub -D language="${current_language}"
      mkdir -p "${docroot}/${current_language}/${current_version}"
      cp "docs/_build/epub/target.epub" "${docroot}/${current_language}/${current_version}/${REPO_NAME}_${current_language}_${current_version}.epub"
 
      # copy the static assets produced by the above build into our docroot
      rsync -av "docs/_build/html/" "${docroot}/"
 
   done
 
done
 
# return to master branch
git checkout master
 
#######################
# Update GitHub Pages #
#######################
 
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
 
pushd "${docroot}"
 
# don't bother maintaining history; just generate fresh
git init
git remote add deploy "https://token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git checkout -b gh-pages
 
# add .nojekyll to the root so that github won't 404 on content added to dirs
# that start with an underscore (_), such as our "_content" dir..
touch .nojekyll

# add password protected index file
cat > index.html <<EOF
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Password Protected</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="robots" content="noindex, nofollow">

        <style>
            *,
            *:after,
            *:before {
                box-sizing: border-box;
            }
            body,
            html {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen", "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif;
                font-weight: 300;
                font-size: 16px;
                background: #f2f2f2;
                color: #2D3737;
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100%;
            }

            .protected {
                background: #fff;
                -webkit-box-shadow: 0 2px 3px 0 rgba(0,0,0,0.1);
                box-shadow: 0 2px 3px 0 rgba(0,0,0,0.1);
                border-radius: 3px;
                min-width: 500px;

            }
            .protected__content {
                padding: 24px 28px;
            }
            .protected__content__heading {
                font-size: 16px;
                font-weight: 500;
                margin: 0 0 12px;
                line-height: 1;
            }
            .protected__alert {
                display: none;
                border-bottom: 1px solid transparent;
                border-radius: 3px 3px 0 0;
                padding: 12px 14px;
                color: #a94442;
                background-color: #f2dede;
                border-color: #ebccd1;
            }
            .protected__content__input {
                display: block;
                border: solid 1px #ccc;
                padding: 12px 14px;
                -webkit-box-shadow: 0 2px 3px 0 rgba(0,0,0,0.1);
                box-shadow: 0 2px 3px 0 rgba(0,0,0,0.1);
                font-size: 16px;
                width: 100%;
                border-radius: 3px;

                margin-bottom: 12px;
            }
            .protected__content__input:focus {
                outline: none;
                border-color: #228843;
            }
            .protected__content__btn {
                background-color: #228843;
                border-radius: 3px;
                cursor: pointer;
                border: none;
                color: #fff;
                padding: 12px 14px;
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen", "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif;
                font-weight: 500;
                font-size: 16px;

            }
            .protected__content__btn:hover {
                background-color: #1C6D36;
            }

        </style>

    </head>

    <body>

        <div class="protected">
            <div class="protected__alert" data-id="alert">You entered the wrong password</div>
            <div class="protected__content">
                <h1 class="protected__content__heading">You need a password to continue</h1>
                <input class="protected__content__input" data-id="password" type="password" placeholder="password"/>
                <button data-id="button" type="button" class="protected__content__btn">Continue</button>
            </div>
        </div>

        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/js-sha1/0.6.0/sha1.min.js"></script>
        <script type="text/javascript">
            "use strict"
            var button = document.querySelectorAll('[data-id="button"]')
            var password = document.querySelectorAll('[data-id="password"]')

            function login(secret) {
                var hash = sha1(secret)
                var url = hash + "/index.html"
                var alert = document.querySelectorAll('[data-id="alert"]')

                var request = new XMLHttpRequest()
                request.open('GET', url, true)

                request.onload = function () {
                    if (request.status >= 200 && request.status < 400) {
                        window.location = url
                    } else {
                        parent.location.hash = hash
                        alert[0].style.display = 'block'
                        password[0].setAttribute('placeholder', 'Incorrect password')
                        password[0].value = ''
                    }
                }
                request.onerror = function () {
                    parent.location.hash = hash
                    alert[0].style.display = 'block'
                    password[0].setAttribute('placeholder', 'Incorrect password')
                    password[0].value = ''
                }
                request.send()
            }

            button[0].addEventListener("click", function () {
                login(password[0].value)
            })

            document.onkeydown = function (e) {
                e = e || window.event
                if (e.keyCode == 13) {
                    login(password[0].value)
                }
            }
        </script>
    </body>
</html>
EOF
 
# Add README
cat > README.md <<EOF
# GitHub Pages Cache
 
Nothing to see here. The contents of this branch are essentially a cache that's not intended to be viewed on github.com.
 
 
If you're looking to update our documentation, check the relevant development branch's 'docs/' dir.
 
For more information on how this documentation is built using Sphinx, Read the Docs, and GitHub Actions/Pages, see:
 
 * https://tech.michaelaltfield.net/2020/07/18/sphinx-rtd-github-pages-1
EOF

mkdir ee6d5702ebeead784de2cb71f35ac5b5cc66a965 && cd $_
# add redirect from the docroot to our default docs language/version
cat > index.html <<EOF
<!DOCTYPE html>
<html>
   <head>
      <title>Locus Lock Docs</title>
      <meta http-equiv = "refresh" content="0; url='/${REPO_NAME}/ee6d5702ebeead784de2cb71f35ac5b5cc66a965/en/master/'" />
   </head>
   <body>
      <p>Please wait while you're redirected to our <a href="/${REPO_NAME}/ee6d5702ebeead784de2cb71f35ac5b5cc66a965/en/master/">documentation</a>.</p>
   </body>
</html>
EOF
cd ../
mv en ee6d5702ebeead784de2cb71f35ac5b5cc66a965

# copy the resulting html pages built from sphinx above to our new git repo
git add .
 
# commit all the new files
msg="Updating Docs for commit ${GITHUB_SHA} made on `date -d"@${SOURCE_DATE_EPOCH}" --iso-8601=seconds` from ${GITHUB_REF} by ${GITHUB_ACTOR}"
git commit -am "${msg}"
 
# overwrite the contents of the gh-pages branch on our github.com repo
git push deploy gh-pages --force
 
popd # return to main repo sandbox root
 
# exit cleanly
exit 0
