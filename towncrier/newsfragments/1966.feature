AdminLTE3 design optimizations, asset compression and caching

- fixed copy of qemu-arm-static for alpine
- added 'set -eu' safeguard
- silenced npm update notification
- added color to webpack call
- changed Admin-LTE default blue
- AdminLTE 3 style tweaks
- localized datatables
- moved external javascript code to vendor.js
- added mailu logo
- moved all inline javascript to app.js
- added iframe display of rspamd page
- updated language-selector to display full language names and use post
- added fieldset to group and en/disable input fields
- added clipboard copy buttons
- cleaned external javascript imports
- pre-split first hostname for further use
- cache dns_* properties of domain object (immutable during runtime)
- fixed and splitted dns_dkim property of domain object (space missing)
- added autoconfig and tlsa properties to domain object
- suppressed extra vertical spacing in jinja2 templates
- improved accessibility for screen reader
- deleted unused/broken /user/forward route
- updated gunicorn to 20.1.0 to get rid of buffering error at startup
- switched webpack to production mode
- added css and javascript minimization
- added pre-compression of assets (gzip)
- removed obsolete dependencies
- switched from node-sass to dart-sass
- changed startup cleaning message from error to info
- move client config to "my account" section when logged in

