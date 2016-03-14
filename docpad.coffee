fsUtil = require('fs')
pathUtil = require('path')

# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON

docpadConfig = {

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			url: "http://www.hibernatespatial.org"

			# Here are some old site urls that you would like to redirect from
			oldUrls: []

			# The default title of our website
			title: "Hibernate Spatial"

			# The website description (for SEO)
			description: """
				The documentation for Hibernate Spatial
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				Hibernate, Hibernate Spatial, geometry, spatial data, gis, mysql, sql server, oracle, postgres, postgis, geography, persistence, ORM
				"""

			# The website author's name
			author: "Karel Maesen"

			# The website author's email
			email: "karel@geovise.com"

			# Styles
			styles: [
				"/styles/twitter-bootstrap.css"
				"/styles/style.css"
			]

			# Services plugin configuration ( https://github.com/docpad/docpad-plugin-services )
			services:
				googleAnalytics: 'UA-43281004-1'

			# Scripts
			scripts: [
				"//cdnjs.cloudflare.com/ajax/libs/jquery/1.10.2/jquery.min.js"
				"//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"
				"/vendor/twitter-bootstrap/dist/js/bootstrap.min.js"				
				"/scripts/script.js"
			]



		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')

		# should we should the Hibernate 5 notice Jumbotron? Default to true.
		getShowH5Jumbo: ->
			if @document.showH5Jumbo?				
				@document.showH5Jumbo
			else
				true					

	# =================================
	# Collections
	# These are special collections that our website makes available to us

	collections:
		pages: (database) ->
			database.findAllLive({pageOrder: $exists: true}, [pageOrder:1,title:1])

		posts: (database) ->
			database.findAllLive({tags:$has:'post'}, [date:-1])

		navs: (database) ->
			database.findAllLive({isNav: $exists: true}, [pageOrder:1,title:1]).on "add", (document) ->
#				docpad.log(document.get("relativePath"))
				base = document.get("relativePath").substr("documentation/".length)
#				docpad.log("Processing: " + base)
				parts = base.split("/")
				#last element is index.html.xx file, so before last determines title and order				
				md = {}
				if (parts.length < 2)
#					docpad.log("ERROR - all files in pages must be at least one-level down (for file: " + base + ")")
				else 				
					part = parts[parts.length - 2]				
#					docpad.log("info", part) 
					numAndTitle = part.split("-")				
					if (numAndTitle.length > 1)
						md = {layout: "page", title : numAndTitle[1], menuOrder: numAndTitle[0]}				
#					docpad.log("adds page with base: " + base)
				document.setMetaDefaults(md)

		mains: (database) ->
			database.findAllLive({isMain: $exists: true}, [pageOrder:1,title:1])			


	# =================================
	# Plugins

	plugins:
		downloader:
			downloads: [
				{
					name: 'Twitter Bootstrap'
					path: 'src/files/vendor/twitter-bootstrap'
					url: 'https://codeload.github.com/twbs/bootstrap/tar.gz/master'
					tarExtractClean: true
				}
			]


	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
}


# Export our DocPad Configuration
module.exports = docpadConfig
