## 0.2.0

Upgrade Notes:

* SchnitzelPress has been rebranded to Schnitzelpress (lower-case p; better now than later). If you've made any modifications to the host app's code, you'll probably need to make changes to reflect this.
* The code you need to push to Heroku (or your own server) has been significantly thinned down. We're now providing a skeleton app that you can download to set up or update your blog. Find details on www.schnitzelpress.org.
* Configuration is now stored in the database and can be edited from the new "Configuration" page in your Admin Panel; this obviously means that some of the stuff happening within your Schnitzelpress 0.1.x host application needs to be removed and re-entered in the web configuration.
* Schnitzelpress now expects an environment variable to be present named SCHNITZELPRESS_OWNER, containing the email address of the admin user. On Heroku, you can add this through the `heroku config:add` command.

Changes:

* By popular request (haha), you can now delete posts.
* The various available rake tasks have been moved to the `schnitzelpress` command line tool.
* Most of your blog's configuration is now stored in MongoDB and can be modified from the new "Configuration" page in your the admin panel.
* Post with dates now use double-digit days and months in their canonical URLs. (Your existing posts will forward to the new canonical URLs automatically.)
* When logged in as an admin, you will be shown a small admin actions panel in the upper right corner of your browser, allowing you to quickly edit posts, jump to the admin section, or log out.
* Schnitzelpress now has a light-weight, custom-built asset pipeline that serves all Javascripts and Stylesheets as one single file each, compressed and ready for hardcore caching.
* When running Schnitzelpress locally (aka: development mode), you can use a simple developer-only login provider to log into your blog for testing purposes.
* Various performance improvements.

## 0.1.1 (2012-02-26)

* Add improved caching of post views and post indices.
* Minor bugfixes.

## 0.1.0 (2012-02-25)

* Initial Release
