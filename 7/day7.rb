# --- Day 7: Handy Haversacks ---
#
# You land at the regional airport in time for your next flight. In fact, it looks like you'll even have time to grab some food: all flights are currently delayed due to issues in luggage processing.
#
# Due to recent aviation regulations, many rules (your puzzle input) are being enforced about bags and their contents; bags must be color-coded and must contain specific quantities of other color-coded bags. Apparently, nobody responsible for these regulations considered how long they would take to enforce!
#
# For example, consider the following rules:
#
# light red bags contain 1 bright white bag, 2 muted yellow bags.
# dark orange bags contain 3 bright white bags, 4 muted yellow bags.
# bright white bags contain 1 shiny gold bag.
# muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
# shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
# dark olive bags contain 3 faded blue bags, 4 dotted black bags.
# vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
# faded blue bags contain no other bags.
# dotted black bags contain no other bags.
# 
# These rules specify the required contents for 9 bag types. In this example, every faded blue bag is empty, every vibrant plum bag contains 11 bags (5 faded blue and 6 dotted black), and so on.
#
# You have a shiny gold bag. If you wanted to carry it in at least one other bag, how many different bag colors would be valid for the outermost bag? (In other words: how many colors can, eventually, contain at least one shiny gold bag?)
#
# In the above rules, the following options would be available to you:
#
# A bright white bag, which can hold your shiny gold bag directly.
# A muted yellow bag, which can hold your shiny gold bag directly, plus some other bags.
# A dark orange bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
# A light red bag, which can hold bright white and muted yellow bags, either of which could then hold your shiny gold bag.
# 
# So, in this example, the number of bag colors that can eventually contain at least one shiny gold bag is 4.
#
# How many bag colors can eventually contain at least one shiny gold bag? (The list of rules is quite long; make sure you get all of it.)
#

# I think each of these rules might describe a node in a tree.
# Maybe this is about graph traversal? The bag counts could be edge weights? When calculating cost, you would want to multiply by edge weight, rather than adding it.

# Strategies:
# 
# parse each rule into something like { 'light red' => { 'bright white' => 1, 'muted yellow' => 2 } }
# to find 'contains shiny gold >= 1'
# 
# option 1: (top-down, brute force)
# build a full inventory of a bag, and detect whether it has a shiny gold
# move on to the next top-level bag
# 
# option 2: (bottom-up, should avoid)
# select all bags that directly contain a shiny gold
# recursively select all bags that can contain them
# how do I know when I've reached the outer bag? 
# maybe I just add them to a list of matches and stop trying when I don't find any new matches
# 
# 
# option 3: 
# use an algorithm that I don't know about
# 

# if this were a directed graph, could I formulate the question as:
# Give me all of the vertices reachable starting from 'shiny gold' where the product of edge lengths on the path is at least 1.
# 

require_relative 'bag'
require_relative 'rule_set'

rs = RuleSet.new('./input')
puts rs.bags_that_can_contain('shiny gold').length

# Your puzzle answer was 259.
