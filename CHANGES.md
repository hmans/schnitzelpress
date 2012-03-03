## 0.2.0 (unreleased)

Upgrade Notes:

* SchnitzelPress has been rebranded to Schnitzelpress (lower-case p). You'll probably need to adjust your blog app's code for this. (Better now than later, I guess!)
* Schnitzelpress now adds Rack::Cache in production by itself; you no longer need to do it in your blog app's config.ru file. It is recommended that you remove the Rack::Cache invocation from your app.
* Configuration is now stored in the database and can be edited from the new "Configuration" page in your Admin Panel; this obviously means that some of the stuff happening within your blog application can (and, in some cases, should) be removed. Please consult the Schnitzelpress 0.2.0 Upgrade Guide for details.

Changes:

* The various available rake tasks have been moved to the `schnitzelpress` command line tool.
* Most of your blog's configuration is now stored in MongoDB and can be modified from the new "Configuration" page in your the admin panel.
* When logged in as an admin, you will be shown a small admin actions panel in the upper right corner of your browser, allowing you to quickly edit posts, jump to the admin section, or log out.
* Schnitzelpress now has a light-weight, custom-built asset pipeline that serves all Javascripts and Stylesheets as one single file each, compressed and ready for hardcore caching.
* Post with dates now use double-digit days and months in their canonical URLs. (Your existing posts will forward to the new canonical URLs automatically.)
* Various performance improvements.

## 0.1.1 (2012-02-26)

* Add improved caching of post views and post indices.
* Minor bugfixes.

## 0.1.0 (2012-02-25)

* Initial Release
