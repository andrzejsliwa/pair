

#pair#


Copyright (c) 2012 Andrzej Śliwa.

__Version:__ 0.1


**pair** is a simple git helper for pair programming

[![Build Status](https://secure.travis-ci.org/andrzejsliwa/pair.png?branch=master)](http://travis-ci.org/andrzejsliwa/pair)

Note: This is a work in progress, see the
[TODO](http://github.com/andrzejsliwa/pair/blob/master/TODO.md) for more
informations on what still need to be done.

## License
See [LICENSE](http://github.com/andrzejsliwa/pair/blob/master/LICENSE) file for licensing information.

## Installation

Download the sources from our [Github repository](http://github.com/andrzejsliwa/pair)

Build it<pre>$ cd pair
$ make</pre>

Copy 'pair' to your bin path (ex. /usr/local/bin)<pre>$ cp pair ~/usr/local/bin</pre>

## Basic usage

The basic usage of **pair** is:Run it first time
<pre>$ pair
created example pair config: '/Users/andrzejsliwa/.pair.config'
first update it and run pair again...</pre>

Edit config file (~/.pair.config)<pre>%% define your identity...
{my_name,  "Andrzej Sliwa"}.
{my_email, "andrzej.sliwa@i-tool.eu"}.

%% define your pairs...
{"an-ar",  [{left, my_name}, {right, "Artur Kowalski"},
          {email, "andrzej+artur@mydomain.com"}]}.

{"an-jan", [{left, my_email}, {right, "Jan Kowalski"},
          {email, "andrzej+jan@mydomain.com"}]}.</pre>

Change pair<pre>$ ./pair an-ar
Pairing: Andrzej Sliwa + Artur Kowalski</pre>Back to your identity
<pre>$ ./pair
Back to my identity.</pre>

To generate doc, run 'make doc'.

## Contribute

For issues, comments or feedback please [create an
issue](http://github.com/andrzejsliwa/rebar_proper_plugin/issues).

### Notes for developers

If you want to contribute patches or improve the doc, you will need to
build hackney using the `rebar.dev.config`  file. It can also be built
using the **Makefile**:<pre>$ make dev       ; # compile & get deps
$ make dev_clean ; # clean all files</pre>


##Modules##


<table width="100%" border="0" summary="list of modules">
<tr><td><a href="http://github.com/andrzejsliwa/pair/blob/master/doc/pair.md" class="module">pair</a></td></tr></table>

