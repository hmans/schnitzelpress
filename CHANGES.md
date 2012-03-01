== 0.2.0 (unreleased)

Upgrade Notes:

* SchnitzelPress has been rebranded to Schnitzelpress (lowe-case p). You'll probably need to adjust your blog app's code for this. (Better now than later, I guess!)
* Schnitzelpress now adds Rack::Cache in production by itself; you no longer need to do it in your blog app's config.ru file. It is recommended that you remove the Rack::Cache invocation from your app.

Changes:

* Schnitzelpress now has a light-weight, custom-built asset pipeline that serves all Javascripts and Stylesheets as one single file each, compressed and ready for hardcore caching.
* Post with dates now use double-digit days and months in their canonical URLs. (Your existing posts will forward to the new canonical URLs automatically.)
* Various performance improvements.

== 0.1.1 (2012-02-26)

* Add improved caching of post views and post indices.
* Minor bugfixes.

== 0.1.0 (2012-02-25)

* Initial Release
