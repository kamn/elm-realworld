## May 14 2017 - 10:52 to 11:07
General setup.
Started to read though the basic documentation.
Added a very basic elm file.
Started to read https://dev.to/rtfeldman/tour-of-an-open-source-elm-spa as a reference.

## May 14 2017 - 11:09 to 11:24
Having difficulty with html-to-elm.
Getting error messages about how node is not setup correctly.
Was related to not having a variable assigned

## May 14 2017 - 11:24 to 11:39
Ran into bug because my views directory was named Views.elm.
Added the basic layout and got it working in Main.elm.
Started to try to get the contents of the layout working

## May 15 2017 - 10:02 to 10:17
Started to look into Routing.
Ran into elm-reactor error with intalling a library.
Going to do it according to an elm guide instead


## May 15 2017 - 10:18 to 10:33
Got a little farther but routing is such a hassle in Elm.
Got the basic framework up but still not the basic routing of going to a different url

## May 15 2017 - 10:33 to 10:48
Some links to help with future dealing with routing since I am not taking the time to deeply understand.

https://www.elm-tutorial.org/en/07-routing/02-routing.html
http://package.elm-lang.org/packages/evancz/url-parser/2.0.1

Also think there is some way to use elm-route but it keeps breaking my repo

## May 15 2017 - 10:52 to 11:07
Starting to look around to resolve the elm-http issue...
Nothing jumps out.
I will have to report an issue tomorrow

## May 15 2017 - 11:14 to 11:29
Finally got the routing working.
It was easy once I started to actually pay attention.
I do think the example could be a little better.

## May 16 2017 - 8:57 to 9:12
Started to import the other views into the product.

## May 16 2017 - 9:13 to 9:28
Continued to work on setting up views.
Tried to input the editor html and it seems to have has some issues on a placeholder.
I should report that.
Also the footer seems to overlap with pages that have a large height.

## May 16 2017 - 10:14 to 10:29
Moved the routes out of Main and into Routes.
Added some data structures that will need to be used with the Views.
Started to look into Json decoding

## May 17 2017 - 6:55 to 7:10
Added a data structure for comments.
Started to use the data structures in the views for Articles.

## May 17 2017 - 8:50 to 9:05
Trying to figure out how to do requests in Elm

## May 17 2017 - 9:06 to 9:21
Figured a basic way of setting up the requests.
I realize that I don't know much about Cmd.
Read https://www.elm-tutorial.org/en/03-subs-cmds/02-commands.html

## May 17 2017 - 9:52 to 10:07
Looking into how to decode complex data types.
https://github.com/NoRedInk/elm-decode-pipeline
Seems like pipline is a better way to go than the default since they only go upto 8 props.
I wonder how you do more than that?
Started to decode the articles object

## May 17 2017 - 10:08 to 10:23
Continue work on decode.
The example docs for elm-decode pipline need to have nullable imported.
Got a basic decode of articles working! Alright!
I think next I will work on displaying those articles correctly.

## May 18 2017 - 9:38 to 9:53
Starting working and from the test server and got a null description.
Started to make templates 

## May 18 2017 - 9:54 to 10:09
Got the basic data from the example app and then iterated to display static data.
Working on making it more dynamic.
Got a lot of the data working.
I am having some issues with the footer css.
I might look at the real app to see what they did.
